#include "Mesh.h"

using namespace bnl;

void Mesh::InnerRender()
{
    for( DWORD i=0; i<NumMaterials; i++ )
    {
        // Set the material and texture for this subset
        device->SetMaterial( &materials[i] );
        device->SetTexture( 0, textures[i] );
    
        // Draw the mesh subset
        mesh->DrawSubset( i );
    }
}

void Mesh::render(LPDIRECT3DDEVICE9 device)
{
    for( DWORD i=0; i<NumMaterials; i++ )
    {
        // Set the material and texture for this subset
        device->SetMaterial( &materials[i] );
        device->SetTexture( 0, textures[i] );
    
        // Draw the mesh subset
        mesh->DrawSubset( i );
    }
}

void Mesh::Render(const D3DXVECTOR3& offset)
{
	D3DXMATRIXA16 world;
	// get the world matrix
	device->GetTransform(D3DTS_WORLD, &world);
	D3DXMATRIXA16 trans;
	// compute the translation matrix
	D3DXMatrixTranslation(&trans, offset.x, offset.y, offset.z);

	// set the new world matrix, (old world matrix) * (translation)
	device->SetTransform(D3DTS_WORLD, &(world*trans*default_transformation));
	InnerRender();
}

void Mesh::RenderAbsolute(const D3DXVECTOR3 &position)
{
	D3DXMATRIXA16 translation;
	D3DXMatrixTranslation(&translation, position.x, position.y, position.z);
	device->SetTransform(D3DTS_WORLD, &(translation * default_transformation));

	InnerRender();
}

void Mesh::SetDefaultTransformation(D3DXMATRIXA16 &transformation)
{
	default_transformation = transformation;
}

D3DXMATRIXA16& Mesh::GetDefaultTransformation()
{
	return default_transformation;
}

Mesh::Mesh(char *filename, LPDIRECT3DDEVICE9 device_)
{
	device = device_;
    LPD3DXBUFFER pD3DXMtrlBuffer;

	HRESULT hr;
    if( FAILED( hr = D3DXLoadMeshFromX( filename, D3DXMESH_SYSTEMMEM, 
										device, NULL, &pD3DXMtrlBuffer, 
										NULL, &NumMaterials, &mesh ) ) )
    {
		MessageBox(NULL, "Could not find x-file", "BNL2", MB_OK);
		PostQuitMessage(1);
        return;
    }

	//DWORD fvf = mesh->GetFVF();
    // We need to extract the material properties and texture names from the 
    // pD3DXMtrlBuffer

    D3DXMATERIAL* d3dxMaterials = (D3DXMATERIAL*)pD3DXMtrlBuffer->GetBufferPointer();
    materials = new D3DMATERIAL9[NumMaterials];
    textures  = new LPDIRECT3DTEXTURE9[NumMaterials];

    for( DWORD i=0; i < NumMaterials; i++ )
    {
        // Copy the material
        materials[i] = d3dxMaterials[i].MatD3D;

        // Set the ambient color for the material (D3DX does not do this)
        materials[i].Ambient = materials[i].Diffuse;

        textures[i] = NULL;
        if( d3dxMaterials[i].pTextureFilename != NULL && 
            lstrlen(d3dxMaterials[i].pTextureFilename) > 0 )
        {
            // Create the texture
            if( FAILED( D3DXCreateTextureFromFile( device, 
                                                d3dxMaterials[i].pTextureFilename, 
                                                &textures[i] ) ) )
            {
				// Looking for texrures in the textures directory
				char* tmp = d3dxMaterials[i].pTextureFilename;
				char* tmp2 = tmp;
				int j = 0;
				char k;
				while( (k = tmp[j]) != NULL)
				{
					if (k == '\\')
						tmp2 = &tmp[j+1];
					j++;
				}
				
				size_t size = strlen(tmp2)+strlen("graphics\\")+1;
				char* texture_filename = new char[size];
				texture_filename[0] = 0;
				strcat_s(texture_filename, size, "graphics\\");
				strcat_s(texture_filename, size, tmp2);
				
				if( FAILED( D3DXCreateTextureFromFile( device, 
													texture_filename, &textures[i] ) ) )
				MessageBox(NULL, "Could not find texture map", "BNL2", MB_OK);
				delete [] texture_filename;
            }
        }
	}
    
	// Done with the material buffer
    pD3DXMtrlBuffer->Release();
	// Set the default transformation matrix;
	D3DXMatrixIdentity(&default_transformation);
}

Mesh::~Mesh(void)
{
    if( materials != NULL ) 
        delete[] materials;

    if( textures )
    {
        for( DWORD i = 0; i < NumMaterials; i++ )
        {
            if( textures[i] )
                textures[i]->Release();
        }
        delete[] textures;
    }
    if( mesh != NULL )
        mesh->Release();
}
