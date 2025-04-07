; Cliborがなぜか Win+v が使えないので、AWKで差し替え

; Cliborメイン起動
#v:: { ; Win+v
    SendInput("^!v") ; ホットキーに登録した Ctrl+Alt+v
    ; アクティブウィンドウがCliborから外れるので対策
    if WinWait("ahk_class TFrm_Clibor", "", 0.5) {
        WinActivate()
    }
    return
}

; Windowsのクリップボード履歴
Ctrl:: { ; Ctrlキー2回
    KeyWait("Ctrl")
    if !KeyWait("Ctrl", "D T0.3") { ; もう一度Ctrlが押されなかった場合
        SendInput("{Ctrl}") ; 単体のCtrlを送信
        return
    }
    SendInput("#v") ; Win+v を送信
    return
}
