; Settings
global name := "Fullscreen Projector" ; Fullscreen Projector name
global key := "U" ; in game Reset HotKey
global delay := 300 ; monitoring start delay (probably around 100 ~ 300 ms)
global monitoring := 1000 ; Fullscreen Projector monitoring activation (probably 1000 ms)
global mousetrigger := True ; include mouse movement to the monitoring close

; Extension Settings
global dummy_key := "I" ; Reset HotKey in multi instances tool
global fullscreen_togglekey := "F11" ; literally
global key_interval := 10 ; key send interval (ms but idk)
global fr_interval := 30 ; fullscreen toggle and reset interval (ms but idk)

#Persistent

; Main
Loop {
    IfWinActive, Minecraft,, {
        GetKeyState, key, %key%
        IF (key = "D") {
            WinGetPos, wx, wy ,ww ,wh, A
            If (ww =1920 and wh = 1080) {
                Send, {%fullscreen_togglekey% down}
                Sleep, %key_interval%
                Send, {%fullscreen_togglekey% up}
                Sleep, %fr_interval%
            }
            Send, {%dummy_key% down}
            Sleep, %key_interval%
            Send, {%dummy_key% up}
            WinSet, AlwaysOnTop, On, %name%
            Sleep, %delay%
            IfWinNotActive, Minecraft,, {
                MouseGetPos, dummy_x, dummy_y
                time_past = % A_Now A_MSec
                Loop {
                    IfWinActive, Minecraft
                        break      
                    MouseGetPos, x, y
                    If (mousetrigger and (dummy_x != x or dummy_y != y))
                        break
                    time_now = % A_Now A_MSec
                    If (time_difference + 40001 <= time_now - time_past)
                        time_difference := time_now - time_past - 40001
                    Else
                        time_difference := time_now - time_past
                    If (time_now - time_past >= monitoring)
                        break
                }
            }
            WinSet, AlwaysOnTop, Off, %name%
        }
    }
}
