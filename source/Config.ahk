﻿#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.
FileEncoding , UTF-8
#SingleInstance, force
#NoTrayIcon


;IniRead, PsCSver, %A_scriptdir%\Data\Config.ini, Setting, Psver, CS5

G_ReadLanguage()

V_CurrentVer()
ConfigTitle=Adobe Photoshop assistant v%f_CurrentVer%

V_Trans()

gosub ConfigRead

stringStartNum=2
gui_Language = 
loop,%LangTotal%
{
	LangName:=CSV_ReadCell(CSV_Identifier, 1, stringStartNum)
	gui_Language .=LangName . "|"
	stringStartNum:=++stringStartNum
}
Github:="https://github.com/millionart/Apssistant"
DeviantArt:="https://www.deviantart.com/deviation/160950828"

; ============================================================================
; 添加控件 第一步
Gui, +Toolwindow ;+LastFound +AlwaysonTop
Gui, Font, S%fontsize%, %fontname%

Gui, Add, ListBox, x10 y10 w120 h450 vFChoice gFChoicecheck, %Lang_General%|%Lang_ColorPicker%|%Lang_Hotkey%|%Lang_Autosave%|%Lang_Other%|%Lang_Donate%

Gui, Add, GroupBox, x140 y10 w310 h250 vGB_General, %Lang_General%
	Gui, Add, Text, x150 y40 w200 h25 vGuiText4, %Lang_Your_language%
	Gui, Add, DropDownList, x361 y40 w80 vG_Language gLangtip Choose%LangNum%, %gui_Language%
	Gui, Add, Text, x150 y70 w200 h25 vGuiText5, %Lang_Your_Photoshop_version%
	Gui, Add, DropDownList, x361 y70 w80 vPsCSver Choose%PsCSverNo% gVerChoose, %PSCSverList%
	Gui, Add, Edit, x150 y100 w211 h25 vPsPath Readonly, %PsPath%
	Gui, Add, Button, x361 y100 w80 h25 vBrowse1 gBrowse1, %Lang_Config_Browse%
	Gui, Add, Checkbox, x150 y130 w200 h25 vCheck4 %Checkd4% %psexist%, %Lang_P_I_LaunchPs%
	Gui, Add, Checkbox, x150 y160 w190 h25 vCheck2 %Checkd2%, %Lang_P_I_Hidehelptip%
;===========================

Gui, Add, GroupBox, x140 y10 w310 h250 vGB_ColorPicker, %Lang_ColorPicker%
	Gui, Add, CheckBox, x150 y40 w230 h25 vCheck7 %Checkd7% gHUDToggle, %Lang_Set_hotkey_HUD_Color_Picker%
		Gui, Add, Hotkey, x400 y40 w40 h25 vHUDCP %enableHUDCP%, %HUDCP%
		Gui, Add, Checkbox, x165 y65 w60 h25 vCheck5 %Checkd5%, %Lang_Set_hotkey_Precise%
		Gui, Add, Checkbox, x225 y65 w60 h25 vCheck9 %Checkd9%, %Lang_Set_hotkey_Center%
		Gui, Add, Radio, x295 y65 w70 h25 vhotkeyFastMode -Wrap Group, %Lang_hotkeyFastMode%
		Gui, Add, Radio, x375 y65 w70 h25 vhotkeyStableMode -Wrap, %Lang_hotkeyStableMode%
		;Gui, Add, Checkbox, x285 y65 w100 h25 vCheck12 %Checkd12%, %Lang_hotkeyFastMode%

	Gui, Add, CheckBox, x150 y100 w15 h25 vCheck8 %Checkd8% gChooseMapAltmode,
		Gui, Add, DropDownList, x165 y103 w275 vMapAlt Choose%MapAltmode% AltSubmit gChooseMapAltmode,
		Gui, Add, Text, x165 y125 w235 h100 vFastColorPickerCS5Tip, %Lang_fastColorPickerCS5Tip%
		Gui, Add, Text, x165 y225 w235 h25 vFastColorPickerCS5Tip2, %Lang_fastColorPickerCS5Tip2%
		Gui, Add, Hotkey, x400 y225 w40 h25 vFCPk %enableFCP%, %FCPk%
;===========================

Gui, Add, GroupBox, x140 y10 w310 h250 vGB_Hotkey, %Lang_Hotkey%
	Gui, Add, Checkbox, x150 y40 w190 h25 vCheck10 %Checkd10%, %Lang_P_I_DisableAltMenu%
	Gui, Add, Checkbox, x150 y70 w200 h25 vCheck11 %Checkd11% gModifyBrushKeyToggle, %Lang_Set_hotkey_ModifyBrushKey%
		Gui, Add, Hotkey, x361 y70 w80 h25 vModifyBrushKey %enableModifyBrushKey%, %ModifyBrushKey%

	Gui, Add, Checkbox, x150 y100 w200 h25 vCheck6 %Checkd6% gQCLayerToggle, %Lang_Set_hotkey_QCLayer%
		Gui, Add, Hotkey, x361 y100 w80 h25 vQCLayer %enableQCLayer%, %QCLayer%

	Gui, Add, Checkbox, x150 y130 w200 h25 vCheck13 %Checkd13% gSHLayerToggle, %Lang_Set_hotkey_SHLayer%
		Gui, Add, Hotkey, x361 y130 w80 h25 vSHLayer %enableSHLayer%, %SHLayer%

	Gui, Add, Checkbox, x150 y160 w280 h25 vCheck1 %Checkd1%, %Lang_Set_hotkey_Undo%

;===========================
Gui, Add, GroupBox, x140 y10 w310 h250 vGB_Autosave, %Lang_Autosave%
	Gui, Add, DropDownList, x150 y40 w190 vAutosave Choose%Autosavenum% AltSubmit gAScheck, %Lang_Autosave_no%|%Lang_Autosave_tip%|%Lang_Autosave_yes%
		;Gui, Add, Text, x310 y40 w40 vGuiText1, %Lang_Autosave_Every%
		Gui, Add, Edit, x345 y40 w50 h25 vSavesleep Number Center, %Savesleep%
		Gui, Add, Text, x401 y40 w40 h25 vGuiText2, %Lang_Autosave_Min%
		Gui, Add, Text, x150 y70 w130 h25 vGuiText3, %Lang_Autosave_Optional%
		Gui, Add, Edit, x271 y70 w160 h40 vTiptext Limit28, %Tiptext%

;===========================
;Gui, Add, GroupBox, x140 y10 w310 h250 vGB_P_I, %Lang_P_I%


;===========================
Gui, Add, GroupBox, x140 y10 w310 h250 vGB_Other, %Lang_Other%
	Gui, Add, Checkbox, x150 y40 w190 h25 vCheck15 %Checkd15%, %Lang_Other_3dsMaxSync%
	Gui, Add, Checkbox, x150 y70 w190 h25 vCheck3 %Checkd3%, %Lang_P_I_LockIME%
	Gui, Add, Checkbox, x150 y100 w280 h25 vCheck14 %Checkd14%, %Lang_C_TempFiles% ;Clean up temporary files
;===========================
Gui, Add, GroupBox, x140 y10 w310 h250 vGB_Donate, %Lang_Donate%

	Gui, Add, Picture, x140 y59 w150 h-1 vDonateAlipay, %A_scriptdir%\Data\Images\alipay.png
	Gui, Add, Picture, x300 y59 w150 h-1 vDonateWechat, %A_scriptdir%\Data\Images\wechat.png

	Gui, Add, Picture, x170 y59 w246 h-1 vDonatePaypal gDonateNow, %A_scriptdir%\Data\Images\paypal.png
	Gui, Add, Text, x150 y290 w290 h180 vDonateText, %Lang_Donate_text%

;===========================
Gui, Add, GroupBox, x140 y270 w310 h250 vHelpTip, %Lang_HelpTip%
	Gui, Add, Text, x150 y290 w290 h225 vHelpTipText,%Lang_HelpTip_text%

Gui, Add, Button, x460 y10 w100 h50 vCSave gConfigSave, %Lang_Config_Save%
Gui, Add, Button, x460 y70 w100 h30 vCCancel gGuiClose, %Lang_Config_Cancel%

Gui Add, Link, x10 y470 w100 h20, <a href="%Github%">Github</a>
Gui Add, Link, x10 y495 w100 h20, <a href="%DeviantArt%">DeviantArt</a>
Gui Font

Gui Font, s20 Bold q5 c0x0080FF, %Fontname%
Gui Add, Button, x150 y160 w290 h60 vDonateButton gDonateNow, %Lang_Donate%
Gui Font

Gui Add, Picture, x460 y275 w100 h-1 vShareTwitter gShareTwitter,  %A_scriptdir%\Data\Images\Twitter.png
Gui Add, Picture, x460 y315 w100 h-1 vShareFacebook gShareFacebook,  %A_scriptdir%\Data\Images\Facebook.png
Gui Add, Picture, x460 y355 w100 h-1 vShareReddit gShareReddit,  %A_scriptdir%\Data\Images\Reddit.png

Gui Add, Picture, x460 y275 w100 h-1 vShareWeibo gShareWeibo,  %A_scriptdir%\Data\Images\Weibo.png


;=============================================================
; 添加控件 第二步

If (hotkeyMode=2)
	GuiControl,,hotkeyStableMode,1
Else
	GuiControl,,hotkeyFastMode,1

Loop 15
{
If (Check%A_Index%=1)
	GuiControl,,Check%A_Index%,1
}

gosub ModifyBrushKeyToggle

gosub QCLayerToggle

gosub SHLayerToggle

gosub 3dsMaxSyncCheck

gosub VerChoose

gosub GuiHideGB

If Regver>=12
{
	Gosub HUDToggle
	Gui, Show, AutoSize Center,%ConfigTitle%
}
else
{
	GuiControl,Disable,Check5
	GuiControl,Disable,Check7
	GuiControl,Disable,Check9
	GuiControl,Disable,hotkeyFastMode
	GuiControl,Disable,hotkeyStableMode
	GuiControl,Disable,HUDCP
	Gui, Show, AutoSize Center,%ConfigTitle% *** ***%Lang_Config_CS5mark%*** ***
}

OnMessage(0x200, "WM_MOUSEMOVE")

GuiControl, Choose, FChoice, 1
Return


AScheck:
	SetTimer, lockAutosaveMinTime, 50 
	GuiControlGet,txt,,Autosave, Text
	If (txt=Lang_Autosave_no)
	{
		SetTimer, lockAutosaveMinTime, off 
		GuiControl,Hide,Savesleep
		GuiControl,Hide,GuiText2
		GuiControl,Hide,GuiText3
		GuiControl,Hide,Tiptext
	}
	Else If (txt=Lang_Autosave_tip)
	{
		GuiControl,Show,Savesleep
		GuiControl,Show,GuiText2
		GuiControl,Show,GuiText3
		GuiControl,Show,Tiptext
	}
	Else If (txt=Lang_Autosave_yes)
	{
		GuiControl,Show,Savesleep
		GuiControl,Show,GuiText2
		GuiControl,Hide,GuiText3
		GuiControl,Hide,Tiptext
	}
	Return

lockAutosaveMinTime:
	GuiControlGet,txt,,FChoice,
	If (txt!=Lang_Autosave)
 	   SetTimer, lockAutosaveMinTime, off 
	Else
	{
		GuiControlGet, autoSaveTime,, Savesleep,
		If (autosavetime<2)
		{
			GuiControl,, Savesleep, 2
		}
	}
Return

3dsMaxSyncCheck:
	Return

Browse1:
	If PsPath=NULL
		ProgramFilesDir:="A_ProgramFiles"
	else
		ProgramFilesDir:="PsDir"
	FileSelectFile, Dir , 1, %ProgramFilesDir%\Photoshop.exe, %Lang_PsDir%, Photoshop (*.exe)
	Dir:=StrReplace(Dir, "`n", "`r`n")
	If dir<>
		ControlSetText,Edit1,%Dir%
	Return

ModifyBrushKeyToggle:
	GuiControlGet, Check11

	If Check11=0
	{
		GuiControl,Disable,ModifyBrushKey
	}
	else If Check11=1
	{
		GuiControl,Enable,ModifyBrushKey
	}
	Return

ChooseMapAltmode:
	GuiControlGet, leftTag, , FChoice,
	GuiControlGet, Check8
	GuiControlGet, mapAltTxt, , MapAlt, Text

	If (Check8=1)
	{
		GuiControl, Enable, MapAlt

		If (leftTag=Lang_ColorPicker)
		{
			GuiControl, Show, FCPk
			If (mapAltTxt=Lang_hotKeyMapCS5Plus)
			{
				GuiControl, Enable, Check10
				GuiControl, Show, FastColorPickerCS5Tip
				GuiControl, Show, FastColorPickerCS5Tip2
			}

			If (mapAltTxt=Lang_Set_hotkey_mapalt_1)
			{
				GuiControl, Enable, Check10
				GuiControl, Move, MapAlt, x165 y103 w230
			}

			If (mapAltTxt=Lang_Set_hotkey_mapalt_3)
			{
				GuiControl, Disable, Check10
				GuiControl, Show, FastColorPickerCS5Tip
				GuiControl, Show, FastColorPickerCS5Tip2
			}
		}
	}
	Else
	{
		GuiControl, Hide, FCPk
		GuiControl, Disable, MapAlt
		GuiControl, Hide, FastColorPickerCS5Tip
		GuiControl, Hide, FastColorPickerCS5Tip2
	}

	If (mapAltTxt=Lang_Set_hotkey_mapalt_2)
	{
		GuiControl, Hide, FCPk
		GuiControl, Disable, Check10
		GuiControl, Hide, FastColorPickerCS5Tip
		GuiControl, Hide, FastColorPickerCS5Tip2
		GuiControl, Move, MapAlt, x165 y103 w275
	}
	Return

HUDToggle:
	GuiControlGet, Check7
	If Check7=0
	{
		GuiControl,Disable,HUDCP
		GuiControl,Disable,Check5
		GuiControl,Disable,Check9
		GuiControl,Disable,hotkeyFastMode
		GuiControl,Disable,hotkeyStableMode
	}
	else If Check7=1
	{
		GuiControl,Enable,HUDCP
		GuiControl,Enable,Check5
		GuiControl,Enable,Check9
		GuiControl,Enable,hotkeyFastMode
		GuiControl,Enable,hotkeyStableMode
	}
	Return

Langtip:
	Gui, Submit
	IniWrite, %Langlist%, %A_scriptdir%\Data\Config.ini, General, langlist
	IniWrite, %Fontsize%, %A_scriptdir%\Data\Config.ini, General, fontsize
	IniWrite, %Fontname%, %A_scriptdir%\Data\Config.ini, General, fontname
	IniWrite, %G_Language%, %A_scriptdir%\Data\Config.ini, Setting, lang
	Process,Close,Apssistant.exe
	;MsgBox, 0,, %Lang_Langtip%
	If A_IsCompiled=1
		run %A_scriptdir%\Apssistant.exe
	Reload
	return

QCLayerToggle:
	GuiControlGet, Check6
	If Check6=0
	{
		GuiControl,Disable,QCLayer
	}
	else If Check6=1
	{
		GuiControl,Enable,QCLayer
	}
	Return

SHLayerToggle:
	GuiControlGet, Check13
	If Check13=0
	{
		GuiControl,Disable,SHLayer
	}
	else If Check13=1
	{
		GuiControl,Enable,SHLayer
	}
	Return
; 保存配置
; 添加控件 第三步
ConfigSave:
	Gui, Submit
	Tiptext:=StrReplace(Tiptext, "`r", "\r")
	Tiptext:=StrReplace(Tiptext, "`n", "\n")
	IniWrite, %PsPath%, %A_scriptdir%\Data\Config.ini, Setting, PsPath
	IniWrite, %PsCSver%, %A_scriptdir%\Data\Config.ini, Setting, Psver
	IniWrite, %HUDCP%, %A_scriptdir%\Data\Config.ini, Setting, hudcp
	IniWrite, %FCPk%, %A_scriptdir%\Data\Config.ini, Setting, fcp
	IniWrite, %Check1%, %A_scriptdir%\Data\Config.ini, Setting, undo
	IniWrite, %Autosave%, %A_scriptdir%\Data\Config.ini, Setting, autosave
	IniWrite, %Savesleep%, %A_scriptdir%\Data\Config.ini, Setting, savesleep
	IniWrite, %Tiptext%, %A_scriptdir%\Data\Config.ini, Setting, tiptext
	IniWrite, %Check2%, %A_scriptdir%\Data\Config.ini, Setting, helptip
	IniWrite, %Check3%, %A_scriptdir%\Data\Config.ini, Setting, lockIME
	IniWrite, %Check4%, %A_scriptdir%\Data\Config.ini, Setting, launchPs
	IniWrite, %Check5%, %A_scriptdir%\Data\Config.ini, Setting, Precisehudcp
	IniWrite, %Check6%, %A_scriptdir%\Data\Config.ini, Setting, enableQCLayer
	IniWrite, %Check7%, %A_scriptdir%\Data\Config.ini, Setting, enablehudcp
	IniWrite, %Check8%, %A_scriptdir%\Data\Config.ini, Setting, enablefcp
	IniWrite, %Check9%, %A_scriptdir%\Data\Config.ini, Setting, Centerhudcp
	IniWrite, %Check10%, %A_scriptdir%\Data\Config.ini, Setting, DisableAltMenu
	IniWrite, %Check11%, %A_scriptdir%\Data\Config.ini, Setting, enableModifyBrushRadius
	If (hotkeyStableMode=1)
		hotkeyMode=2
	Else
		hotkeyMode=1
	IniWrite, %hotkeyMode%, %A_scriptdir%\Data\Config.ini, Setting, hotkeyMode
	IniWrite, %Check13%, %A_scriptdir%\Data\Config.ini, Setting, SHLayerToggle
	IniWrite, %Check14%, %A_scriptdir%\Data\Config.ini, Setting, CleanUpTempFiles
	IniWrite, %SHLayer%, %A_scriptdir%\Data\Config.ini, Setting, SHLayer
	IniWrite, %QCLayer%, %A_scriptdir%\Data\Config.ini, Setting, QCLayer
	IniWrite, %ModifyBrushKey%, %A_scriptdir%\Data\Config.ini, Setting, ModifyBrushRadius
	IniWrite, %MapAlt%, %A_scriptdir%\Data\Config.ini, Setting, mapalt
	IniWrite, %Check15%, %A_scriptdir%\Data\Config.ini, Setting, 3dsMaxSync
	If A_IsCompiled
	{
		run %A_scriptdir%\Apssistant.exe
		ExitApp
	}
	Reload
	return

; 添加控件 第四步
GuiHideGB:
	loop 3
	{
	GuiControl,Hide,GuiText%A_Index%
	}

	GuiControl,Hide,GB_Hotkey
	GuiControl,Hide,Check7
	GuiControl,Hide,HUDCP
	GuiControl,Hide,Check5
	GuiControl,Hide,Check9
	GuiControl,Hide,hotkeyFastMode
	GuiControl,Hide,hotkeyStableMode
	GuiControl,Hide,Check13
	GuiControl,Hide,SHLayer
	GuiControl,Hide,Check8
	GuiControl,Hide,MapAlt
	GuiControl, Hide, FCPk
	GuiControl, Hide, FastColorPickerCS5Tip
	GuiControl, Hide, FastColorPickerCS5Tip2
	GuiControl,Hide,Check11
	GuiControl,Hide,ModifyBrushKey
	GuiControl,Hide,Check6
	GuiControl,Hide,QCLayer
	GuiControl,Hide,Check1

	GuiControl,Hide,GB_Autosave
	GuiControl,Hide,Autosave
	GuiControl,Hide,Savesleep
	GuiControl,Hide,Tiptext

	GuiControl,Hide,GB_ColorPicker
	GuiControl,Hide,Check10
	GuiControl,Hide,Check3
	GuiControl,Hide,Check14

	GuiControl,Hide,GB_Other
	GuiControl,Hide,Check15

	GuiControl, Hide, GB_Donate
	GuiControl, Hide, DonateAlipay
	GuiControl, Hide, DonateWechat
	GuiControl, Hide, DonatePaypal
	GuiControl, Hide, DonateButton
	GuiControl, Hide, DonateText

	GuiControl, Hide, ShareWeibo
	GuiControl, Hide, ShareTwitter
	GuiControl, Hide, ShareFacebook
	GuiControl, Hide, ShareReddit
Return

; 添加控件 第五步
FChoicecheck:
	GuiControlGet,leftTag,,FChoice,

	GuiControl,Hide,GB_General
	GuiControl,Hide,PsCSver
	GuiControl,Hide,G_Language
	GuiControl,Hide,Check4
	GuiControl,Hide,Check2
	GuiControl,Hide,GuiText4
	GuiControl,Hide,GuiText5
	GuiControl,Hide,PsPath
	GuiControl,Hide,Browse1

	gosub GuiHideGB

	If (leftTag=Lang_General)
	{
		GuiControl,Show,GB_General
		GuiControl,Show,PsCSver
		GuiControl,Show,G_Language
		GuiControl,Show,Check4
		GuiControl,Show,Check2
		GuiControl,Show,GuiText4
		GuiControl,Show,GuiText5
		GuiControl,Show,PsPath
		GuiControl,Show,Browse1

		GuiControl, Show, HelpTipText
	}
	Else If (leftTag=Lang_ColorPicker)
	{
		GuiControl,Show,GB_ColorPicker
		GuiControl,Show,Check7
		GuiControl,Show,HUDCP
		GuiControl,Show,Check5
		GuiControl,Show,Check9
		GuiControl,Show,Check8
		GuiControl,Show,hotkeyFastMode
		GuiControl,Show,hotkeyStableMode

		GuiControl,Show,MapAlt
		GuiControl,Show,FCPk
		Gosub, ChooseMapAltmode

		GuiControl, Show, HelpTipText
	}
	Else If (leftTag=Lang_Hotkey)
	{
		GuiControl,Show,GB_Hotkey
		GuiControl,Show,Check10
		GuiControl,Show,Check11
		GuiControl,Show,ModifyBrushKey
		GuiControl,Show,Check6
		GuiControl,Show,Check13
		GuiControl,Show,SHLayer
		GuiControl,Show,QCLayer
		GuiControl,Show,Check1

		GuiControl, Show, HelpTipText
	}
	Else If (leftTag=Lang_Autosave)
	{
		GuiControl,Show,GB_Autosave
		GuiControl,Show,Autosave
		gosub AScheck

		GuiControl, Show, HelpTipText
	}
	Else If (leftTag=Lang_Other)
	{
		GuiControl,Show,GB_Other
		GuiControl,Show,Check15
		GuiControl,Show,Check3
		GuiControl,Show,Check14

		GuiControl, Show, HelpTipText
	}
	Else If (leftTag=Lang_Donate)
	{
		GuiControl, Hide, HelpTipText
		GuiControl, Show, GB_Donate

		If (G_Language = "简体中文") || (G_Language = "繁体中文") 
		{
			GuiControl, Show, DonateAlipay
			GuiControl, Show, DonateWechat

			GuiControl, Show, ShareWeibo
		}
		else
		{
			GuiControl, Show, DonatePaypal
			GuiControl, Show, DonateButton

			GuiControl, Show, ShareTwitter
			GuiControl, Show, ShareFacebook
			GuiControl, Show, ShareReddit
		}
		GuiControl, Show, DonateText
	}


Return

VerChoose:
	GuiControlGet,GuiGetPsver,,PsCSver, Text
	V_Trans()

	If curPsver>=12
	{
		GuiControl,enable,Check4
		GuiControl,enable,Check5
		GuiControl,enable,Check7
		GuiControl,enable,Check9
		GuiControl,enable,Check11
		GuiControl,enable,hotkeyFastMode
		GuiControl,enable,hotkeyStableMode
		if check11=1
		{
			GuiControl,enable,ModifyBrushKey
		}
		GuiControl,enable,HUDCP

		GuiControl, Move, MapAlt, x165 y103 w275
		GuiControl, Move, FCPk, x400 y225 w40 h25
		GuiControl,,MapAlt,|%Lang_hotKeyMapCS5Plus%|%Lang_Set_hotkey_mapalt_2%|%Lang_Set_hotkey_mapalt_3%|
		GuiControl, Choose, MapAlt, |%MapAltmode%
		GuiControl,Hide,FastColorPickerCS5Tip
		GuiControl,Hide,FastColorPickerCS5Tip2
		WinSetTitle, %ConfigTitle%
	}
	else
	{
		GuiControl,Disable,Check5
		GuiControl,Disable,Check7
		GuiControl,Disable,Check9
		GuiControl,Disable,hotkeyFastMode
		GuiControl,Disable,hotkeyStableMode

		GuiControl,Disable,HUDCP

		GuiControl, Move, MapAlt, x165 y103 w230
		GuiControl, Move, FCPk, x400 y103 w40 h25
		GuiControl,,MapAlt,|%Lang_Set_hotkey_mapalt_1%|%Lang_Set_hotkey_mapalt_2%|
		if MapAltmode=1
			GuiControl, Choose, MapAlt, |1
		else
			GuiControl, Choose, MapAlt, |2

		WinSetTitle, %ConfigTitle% *** ***%Lang_Config_CS5mark%*** ***

		If curPsver=11
		{
			GuiControl,enable,Check4		;enable
			GuiControl,enable,Check11		;enable
			GuiControl,enable,ModifyBrushKey	;enable
		}
		else
		{
			GuiControl,Disable,Check4		;Disable
			GuiControl,Disable,Check11		;Disable
			GuiControl,Disable,ModifyBrushKey	;Disable
		}
	}
	Return

DonateNow:
	Run, https://www.paypal.me/millionart
return

ShareTwitter:
	Run, https://twitter.com/intent/tweet?text=%Lang_shareText%&url=%DeviantArt%&hashtags=Photoshop
return

ShareFacebook:
	Run, https://www.facebook.com/sharer/sharer.php?u=%DeviantArt%
return

ShareReddit:
	Run, https://www.reddit.com/submit?url=%DeviantArt%&title=%Lang_shareText%&text=%Lang_shareText%
return

ShareWeibo:
url=%Github%/releases
Lang_shareText:=StrReplace(Lang_shareText, "#", "%23")

If (G_Language = "简体中文")
	langTag=zh_cn
Else If (G_Language = "繁体中文") 
	langTag=zh_tw

	Run, https://service.weibo.com/share/share.php?url=%url%&language=%langTag%&title=%Lang_shareText%
return

; 当鼠标移动到控件上，显示帮助提示
WM_MOUSEMOVE()
{
	GuiControlGet,txt,,FChoice,
	If (txt!=Lang_Donate)
	{
		static Lang_HT_, CurrControl, PrevControl, ; HT means Help Tip
		CurrControl := A_GuiControl
		If (CurrControl <> PrevControl and not InStr(CurrControl, " "))
		{
			SetTimer, DisplayToolTip, 0
			PrevControl := CurrControl
		}
	}
	return

	DisplayToolTip:
	SetTimer, DisplayToolTip, Off
	Try
		GuiControl,,HelpTipText, % Lang_HT_%CurrControl% ; 第一个百分号表示后面是一个表达式
	return

}

;#include %A_scriptdir%\inc\Font.ahk
#include %A_scriptdir%\inc\Handle.ahk