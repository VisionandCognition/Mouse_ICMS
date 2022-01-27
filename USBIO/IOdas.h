
#ifdef USBIO_EXPORTS
#define USBIO_API __declspec(dllexport)
#else
#define USBIO_API __declspec(dllimport)
#endif

extern "C"	USBIO_API bool InitIO( WORD BoardNum);

extern "C"	USBIO_API void WritePortA(WORD val);
extern "C"	USBIO_API void WritebitA(WORD bitn, WORD val);
extern "C"	USBIO_API void WritePortB(WORD val);
extern "C"	USBIO_API void WritebitB(WORD bitn, WORD val);
//extern "C"	USBIO_API WORD Readbit(WORD bitn);




