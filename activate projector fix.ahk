; Settings
global Name := "Fullscreen Projector" ; Fullscreen Projector Name
global Key := "U" ; in game Reset HotKey
global Delay := 50 ; Fullscreen Projector Activate Delay (probably 50 ~ 100)

Loop {
    GetKeyState, Key, %Key%
    IF (Key = "D") {
        IfWinActive, Minecraft 
        {
            Sleep, %Delay%
            Loop {
                WinActivate, %Name%
                IfWinActive, %Name%
                {
                    break
                }
            }
        }
    }
}