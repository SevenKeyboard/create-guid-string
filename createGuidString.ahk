#Requires AutoHotkey v1.1.0+
;==============================================================
; createGuidString — Create a GUID string via CoCreateGuid/StringFromGUID2
;
; GitHub: https://github.com/SevenKeyboard/create-guid-string
; Author: SevenKeyboard Ltd. (2025)
; License: The Unlicense
;
; Documentation / References:
;   CoCreateGuid function (combaseapi.h)
;     https://learn.microsoft.com/en-us/windows/win32/api/combaseapi/nf-combaseapi-cocreateguid
;   StringFromGUID2 function (combaseapi.h)
;     https://learn.microsoft.com/en-us/windows/win32/api/combaseapi/nf-combaseapi-stringfromguid2
;==============================================================
class VersionManager_createGuidString
{
    static _ := VersionManager_createGuidString._init()
    _init()    {
        global
        CREATEGUIDSTRING_VERSION := "1.0.0"
    }
}
createGuidString()    {
    static S_OK := 0x00000000
    varSetCapacity(pguid, 16, 0)
    if (dllCall("Ole32.dll\CoCreateGuid", "Ptr",&pguid, "Ptr") == S_OK)    {
        varSetCapacity(lpsz, (A_IsUnicode ? 2 : 1) * 39, 0)
        if (dllCall("Ole32.dll\StringFromGUID2", "Ptr",&pguid, "Ptr",&lpsz, "Int",39, "Int"))
            return strGet(&lpsz, "UTF-16")
    }
}