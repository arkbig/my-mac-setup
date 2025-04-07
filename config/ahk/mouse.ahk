; 「進む」+マウス移動でスクロール

MouseReverse := -1 ; 1: マウス対応, -1: タッチタイプ

XButton2Down := false
MouseScrolled := false
MousePrevX := 0
MousePrevY := 0

TICK_PER := 20
MouseDeltaX := 0
MouseDeltaY := 0

Loop {
    if (XButton2Down) {
        MouseGetPos(&currentX, &currentY)
        if (MousePrevX != currentX || MousePrevY != currentY) {
            MouseScrolled := true
            ; ポインター移動をキャンセル
            MouseMove(MousePrevX, MousePrevY, 0)

            ; 移動方向判定
            n := 0
            deltaX := (currentX - MousePrevX) * MouseReverse
            deltaY := (currentY - MousePrevY) * MouseReverse
            if (Abs(deltaX) > Abs(deltaY)) {
                MouseDeltaX += deltaX
                n := Floor(Abs(MouseDeltaX) / TICK_PER)
                if (n > 0) {
                    MouseDeltaX := 0
                    MouseDeltaY := 0
                }
            } else {
                MouseDeltaY += deltaY
                n := Floor(Abs(MouseDeltaY) / TICK_PER)
                if (n > 0) {
                    MouseDeltaX := 0
                    MouseDeltaY := 0
                }
            }

            Loop n {
                if (Abs(deltaX) > Abs(deltaY)) {
                    if (deltaX < 0) {
                        Send("{WheelLeft}")
                    } else {
                        Send("{WheelRight}")
                    }
                } else {
                    if (deltaY < 0) {
                        Send("{WheelUp}")
                    } else {
                        Send("{WheelDown}")
                    }
                }
            }
        } else {
            Sleep(20)
        }
    } else {
        Sleep(200)
    }
}

XButton2:: { ; 進むボタン
    global XButton2Down, MouseScrolled
    global MousePrevX, MousePrevY
    XButton2Down := true
    MouseScrolled := false
    MouseGetPos(&MousePrevX, &MousePrevY)
}

XButton2 Up:: { ; 進むボタン離した
    global XButton2Down, MouseScrolled
    XButton2Down := false
    if (!MouseScrolled) {
        Send("{XButton2}")
    }
}
