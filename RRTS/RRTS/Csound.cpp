#include "Csound.h"

Csound::Csound(void)
{
}

Csound::~Csound(void)
{
}

Csound* Csound::only_instance = NULL;

Csound* Csound::Instance()
{
	if (only_instance == NULL)
		only_instance = new Csound;
	return only_instance;
}

bool Csound::InitializeSoundSystem(HWND hWnd)
{
	HRESULT					hResult;
	IDirectMusicAudioPath8	*dmAudioPath;

	// Initialize COM
	CoInitialize( NULL );
	
	// Create the loader
	if( FAILED( hResult = CoCreateInstance( CLSID_DirectMusicLoader, NULL, 
		CLSCTX_INPROC, IID_IDirectMusicLoader8,
		(void**) &g_pLoader ) ) ) {
		return false;
	}
	
	// Create the performance
	if( FAILED( hResult = CoCreateInstance( CLSID_DirectMusicPerformance, NULL,
		CLSCTX_INPROC, IID_IDirectMusicPerformance8,
		(void**) &g_pPerformance ) ) ) {
		return false;
	}
	
	// Initialize the audio
	if( FAILED( hResult = g_pPerformance->InitAudio( 
		NULL,
		NULL,
		hWnd,
		DMUS_APATH_DYNAMIC_STEREO,
		4,
		DMUS_AUDIOF_ALL,
		NULL
		))) {
		return false;
	}
	
	// Get the default path
	if( FAILED( g_pPerformance->GetDefaultAudioPath( &dmAudioPath ) ) ) 
		return false;
	
	// Set the default volume
	if( FAILED( dmAudioPath->SetVolume(0,0) ) ) 
		return false;
	return true;
}

IDirectMusicSegment8 * Csound::LoadSound(WCHAR *filename)
{
	IDirectMusicSegment8 * snd;
	if ( FAILED(g_pLoader->LoadObjectFromFile (
		CLSID_DirectMusicSegment,
		IID_IDirectMusicSegment8,
		filename,
		( LPVOID* ) &snd
		) ) )
	{
		return NULL;
	}
	
	// Download the data
	if ( FAILED ( snd->Download( g_pPerformance ) ) ) {
		return NULL;
	}
	return snd;
}

void Csound::StopSound(IDirectMusicSegment8 *snd)
{
	g_pPerformance->Stop(snd, NULL, 0, 0);
}

void Csound::PlaySound(IDirectMusicSegment8 *snd)
{
	g_pPerformance->PlaySegmentEx(
		snd,
		NULL,
		NULL,
		DMUS_SEGF_DEFAULT | DMUS_SEGF_SECONDARY,
		0,
		NULL,
		NULL,
		NULL
	);
}