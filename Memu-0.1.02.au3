;BUGS:
;IF THE ADS PLAYED BUT DIDN'T SHOW IT WON'T COUNT ----- FIXED
;BLANK SCREEN ----------------------------------------- FIXED
;FACEBOOK RELOGIN ------------------------------------- FIXED
;CAN'T CONNECT TO SERVERS ----------------------------- FIXED
;NO MORE BOOST OR MAXED OUT --------------------------- FIXED
;MINIMIZE SOURCE CODE FOR BETTER DEBUGGING ------------ FIXED
;1280x1024 RESOLUTION ADJUSTMENTS --------------------- PROGRESS

$VERSION = "Atlas Earth Bot ver[0.1.02]"

Opt("WinWaitDelay", 250)
Opt('CaretCoordMode', 0)
Opt('WinTitleMatchMode', 3)
Opt('MouseCoordMode', 0)
Opt('PixelCoordMode', 0)

HotKeySet("{F7}", "_X")

$TIME = IniRead("SETTINGS.INI", "SETTINGS", "ADS", 60)
$NOBOOST = IniRead("SETTINGS.INI", "SETTINGS", "ADS", 300)
$MEmu = IniRead("SETTINGS.INI", "SETTINGS", "MEMU0", "MEmu Atlas 1")
$LOGIN = IniRead("SETTINGS.INI", "SETTINGS", "LOGIN", "GOOGLE")

While 1

   If WinGetTitle("[active]") == $MEmu Then

	  ToolTip("MEmu Automation ON", 0, 0)
	  Sleep(2000)
	  WinMove($MEmu,"", 0, 0, 575, 983, 2)
	  _Atlas()

   ElseIf WinGetTitle("[active]") == "MEmu" Then

	  ToolTip("MEmu Automation ON", 0, 0)
	  Sleep(2000)
	  Local $hWnd = WinGetHandle("[active]")
	  WinSetTitle("[Handle:" & $hWnd & "]", "", $MEmu)
	  Sleep(100)
	  WinMove($MEmu,"", 0, 0, 575, 983, 2)
	  Sleep(100)
	  _Atlas()

   Else
	  ToolTip("MEmu not found please click on MEmuPlay APP", 0, 0)
	  Sleep(1000)
   EndIf

WEnd

Func _Atlas()

Local $hWnd = WinWait($MEmu, "", 10)
Local $aClientSize = WinGetClientSize($hWnd)

If $aClientSize[0] <> 575 And $aClientSize[1] <> 983 Then MsgBox(0,"ERROR","Problem with your resolution. Contact Support")

If ProcessExists("MEmuHeadless.exe") Then
   WinMove($MEmu,"", 0, 0, 575, 983, 2)
Else
   MsgBox(0,'Process Not Found','MemuPlay does not exist.'
EndIf

$LOAD = 1
$ADS = 0
$STATUS = "Loading..."

;~ $ADS = 1
;~ $LOAD = 0

While 1

   ToolTip($STATUS, 0, 0)
   Select

	  Case $LOAD = 1 And $ADS = 0

		 If PixelChecksum(205, 1, 219, 15) <> 557562232 Then

			$STATUS = "Searching for Atlas Earth"
			Local $aCoord = PixelSearch(22, 198, 388, 521, 8113733)

			If Not @error Then

			   While PixelChecksum(205, 1, 219, 15) <> 557562232
				  $STATUS = "Launching Atlas Earth..."

				  ;ControlClick($MEmu, "", "", "left", 1, $aCoord[0], $aCoord[1]) ;App Location
				  MouseClick("left", $aCoord[0], $aCoord[1], 1)
				  Sleep(1000)
			   WEnd

			EndIf

		 ElseIf PixelChecksum(49, 276, 132, 303) == 2119294149 Then
			$STATUS = "CAN'T CONNECT TO SERVERS"
			Sleep(5000)

			ControlClick($MEmu, "", "", "left", 1, 264, 838) ;OK

		 ElseIf PixelChecksum(45, 270, 135, 305) = 1571131792 Then

			While PixelChecksum(45, 270, 135, 305) = 1571131792
			   $STATUS = "CAN'T CONNECT TO SERVERS"

			   ControlClick($MEmu, "", "", "left", 263, 836, 7)
			   Sleep(1000)
			WEnd

		 ElseIf PixelChecksum(120, 604, 154, 632) == 2512054048 Then

			If $LOGIN = "FACEBOOK" Then
			   ControlClick($MEmu, "", "", "left", 1, 276, 625) ;LOGIN FB
			Else
			   ControlClick($MEmu, "", "", "left", 1, 260, 737) ;LOGIN GOOGLE
			EndIf

		 ElseIf PixelChecksum(80, 400, 130, 430) = 3984993045 Then

			ControlClick($MEmu, "", "", "left", 1, 276, 616) ;OK

		 ElseIf PixelChecksum(460, 75, 475, 90) == 4287796555 Or PixelChecksum(460, 75, 475, 90) == 907253190 Then

			$STATUS = "Atlas Earth Home"
			$LOAD = 0

		 Else
			$STATUS = "Loading Atlas Earth..."
		 EndIf

	  ;=============================================================================================================
	  Case PixelChecksum(460, 75, 475, 90) = 4287796555 And $LOAD = 1 And $ADS = 0 ;NO BOOST

		 $STATUS = "NO BOOST AVAILABLE!" ;dldl
		 If PixelChecksum(415, 130, 425, 145) = 928827608 Then
			ToolTip("5 Hours of Boost", 0, 0) ;SLEEP CODE NEEDED
		 EndIf

	  Case PixelChecksum(460, 75, 475, 90) = 907253190 And $LOAD = 0 And $ADS = 0 ;BOOST

		 $STATUS = "Boosting..."

		 MouseClick("LEFT", 470, 80, 1, 10)

		 While 1
			$STATUS = "Boost Meter"
			Sleep(1000)
			If PixelChecksum(480, 125, 490, 140) == 485039203 Then
			   $STATUS = "BOOST RENT"
			   ExitLoop
			EndIf

		 WEnd

		 Sleep(5000)
		 ;ControlClick($MEmu, "", "", "left", 1, 87, 858) ;Play
		 MouseClick("LEFT", 87, 858, 1, 10)

		 While PixelChecksum(480, 125, 490, 140) == 485039203
			$STATUS = "Waiting for ADS"
			Sleep(2000)
		 WEnd

		 $ADS = 1

	  Case $ADS = 1 And $LOAD = 0

		 $i = 0
		 While 1
			ToolTip($STATUS, 0, 0)

			$i += 1
			$STATUS = "Waiting for ADS to Finish" & "," & $i

			If $i = $TIME Then
			   $STATUS = "ADS FINISHED"

			   If PixelChecksum(205, 1, 219, 15) <> 557562232 Then
				  $STATUS = "ATLAS Tab"
				  ToolTip($STATUS, 0, 0)

				  While PixelChecksum(205, 1, 219, 15) <> 557562232
					 ToolTip($STATUS, 0, 0)
					 ControlClick($MEmu, "", "", "left", 1, 220, 16) ;Atlas Tab
					 Sleep(1000)
				  WEnd

				  $LOAD = 1
				  $ADS = 0

			   EndIf

			ElseIf PixelChecksum(460, 75, 475, 90) = 4287796555 And $LOAD = 1 Then

			   MsgBox(0,'','NO MORE BOOST')

			ElseIf PixelChecksum(205, 1, 219, 15) <> 557562232 And $LOAD = 0 Then

			   While PixelChecksum(205, 1, 219, 15) <> 557562232
				  MouseClick("LEFT", 220, 20, 1)
				  Sleep(2000)
			   WEnd

			ElseIf PixelChecksum(31, 380, 73, 400) == 4138675011 Then
			   $STATUS = "ALREADY WATCHED ADS 2"

			   While PixelChecksum(31, 380, 73, 400) == 4138675011
				  ToolTip($STATUS, 0, 0)
				  ControlClick($MEmu, "", "", "left", 1, 229, 7)
				  Sleep(1000)
			   WEnd

			   $LOAD = 1
			   $ADS = 0

			ElseIf PixelChecksum(36, 382, 68, 403) == 2205806780 Then

			   While PixelChecksum(36, 382, 68, 403) == 2205806780
				  $STATUS = "UNABLE TO SHOW AD"
				  ToolTip($STATUS, 0, 0)
				  MouseClick("left", 275,578, 1)
				  Sleep(1000)
			   WEnd

			   While PixelChecksum(205, 1, 219, 15) == 557562232 ;CLOSE TAB
				  ToolTip($STATUS, 0, 0)
				  ControlClick($MEmu, "", "", "left", 1, 229, 7)
				  Sleep(1000)
			   WEnd

			   $LOAD = 1
			   $ADS = 0

			ElseIf PixelChecksum(480, 125, 490, 140) == 485039203 Then
			   $STATUS = "CLOSE BOOST RENT"

			   While PixelChecksum(480, 125, 490, 140) == 485039203
				  ToolTip($STATUS, 0, 0)
				  ControlClick($MEmu, "", "", "left", 1, 464, 155) ;CLOSE BOOST RENT
				  Sleep(1000)
			   WEnd

			   While PixelChecksum(205, 1, 219, 15) == 557562232 ;CLOSE TAB
				  ToolTip($STATUS, 0, 0)
				  ControlClick($MEmu, "", "", "left", 1, 229, 7)
				  Sleep(1000)
			   WEnd

			   $LOAD = 1
			   $ADS = 0

			ElseIf PixelChecksum(7, 44, 510, 945) = 3499884545 Then ;NO ADS BUGGED
			   ToolTip("NO ADS BUG", 0, 0)
			   While PixelChecksum(205, 1, 219, 15) == 557562232 ;CLOSE TAB
				  ToolTip($STATUS, 0, 0)
				  ControlClick($MEmu, "", "", "left", 1, 229, 7)
				  Sleep(1000)
			   WEnd

			   $LOAD = 1
			   $ADS = 0

			EndIf

			Local $aCoord = PixelSearch(469, 35, 526, 110, 16645629) ;CASE 2

			If Not @error And $LOAD = 0 Then
			   $STATUS = "Close Icon 2"
			   ToolTip($STATUS, 0, 0)
			   ControlClick($MEmu, "", "", "left", 1, $aCoord[0], $aCoord[1]) ;Close Icon
			   Sleep(5000)
			   If PixelChecksum(205, 1, 219, 15) <> 557562232 Then
				  While PixelGetColor(213, 15) <> 527636 ;CLOSE TAB
					 ToolTip("2 Playstore/Browser", 0, 0)
					 MouseClick("left", 213, 15, 1)
					 Sleep(500)
					 ControlClick($MEmu, "", "", "left", 1, 229, 7)
					 Sleep(2000)
				  WEnd

				  $LOAD = 1
				  $ADS = 0
			   EndIf

			EndIf

			Local $aCoordd = PixelSearch(469, 35, 525, 110, 16777215) ;CASE 1

			If Not @error And $LOAD = 0 Then
			   ToolTip("Close Icon 1", 0, 0)
			   ToolTip($STATUS, 0, 0)
			   ControlClick($MEmu, "", "", "left", 1, $aCoordd[0], $aCoordd[1]) ;Close Icon
			   Sleep(5000)
			   If PixelChecksum(205, 1, 219, 15) <> 557562232 Then
				  While PixelGetColor(213, 15) <> 527636 ;CLOSE TAB
					 ToolTip("1 Playstore/Browser", 0, 0)
					 MouseClick("left", 213, 15, 1)
					 Sleep(500)
					 ControlClick($MEmu, "", "", "left", 1, 229, 7)
					 Sleep(2000)
				  WEnd

				  $LOAD = 1
				  $ADS = 0
			   EndIf

			EndIf

			If $LOAD = 1 And $ADS = 0 Then ExitLoop

			Sleep(1000)
		 WEnd

	  Case Else

   EndSelect

WEnd


EndFunc

Func _X()
   Exit
EndFunc

