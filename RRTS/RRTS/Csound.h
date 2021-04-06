#pragma once
#include <dmusici.h>

class Csound
	//singleton class
{
private:
	static Csound* only_instance;
	IDirectMusicLoader8			*g_pLoader;
	IDirectMusicPerformance8	*g_pPerformance;
	Csound(void);

public:
	static Csound* Instance();
	bool InitializeSoundSystem( HWND hWnd );
	void PlaySound(IDirectMusicSegment8* snd);
	void StopSound(IDirectMusicSegment8* snd);
	IDirectMusicSegment8 * LoadSound( WCHAR * filename);
	~Csound(void);
};

typedef IDirectMusicSegment8* SoundPtr;
