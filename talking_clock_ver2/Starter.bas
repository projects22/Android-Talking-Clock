﻿B4A=true
Group=Default Group
ModulesStructureVersion=1
Type=Service
Version=9.801
@EndOfDesignText@
#Region  Service Attributes 
	#StartAtBoot: False
	#ExcludeFromLibrary: True
#End Region

Sub Process_Globals
	'These global variables will be declared once when the application starts.
	'These variables can be accessed from all modules.
	Public TTS1 As TTS
	Public timer1 As Timer
End Sub

Sub Service_Create
	'This is the program entry point.
	'This is a good place to load resources that are not specific to a single activity.
	TTS1.Initialize("TTS1")
	timer1.Initialize("timer1", 500)
	timer1.Enabled=False
	TTS1.SpeechRate = 0.75
End Sub

Sub TTS1_Ready (Success As Boolean)
	If Success=False Then
		ToastMessageShow("Error initializing TTS engine.", "")
	End If
End Sub

Sub timer1_Tick
	'DateTime.DateFormat = "HH:mm:ss"
	DateTime.DateFormat = "mm:ss"	'
	If DateTime.date(DateTime.now)= "00:00" Then
		timer1.Enabled=False
		Sleep(500)
		DateTime.DateFormat = "H"
		TTS1.Speak("the time is " & DateTime.date(DateTime.now) & " hours", True)
		timer1.Enabled=True
	End If

End Sub

Sub Service_Start (StartingIntent As Intent)
	Service.StopAutomaticForeground 'Starter service can start in the foreground state in some edge cases.
End Sub

Sub Service_TaskRemoved
	'This event will be raised when the user removes the app from the recent apps list.
End Sub

'Return true to allow the OS default exceptions handler to handle the uncaught exception.
Sub Application_Error (Error As Exception, StackTrace As String) As Boolean
	Return True
End Sub

Sub Service_Destroy

End Sub
