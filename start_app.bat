' SENTINEL Drone Fleet Manager - Windows VBScript Launcher
' Double-click this file to launch the application

Set objShell = CreateObject("WScript.Shell")
strPath = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName)
strIndexPath = strPath & "\index.html"

' Launch in default browser
objShell.Run strIndexPath

' Display success message
Set objFSO = CreateObject("Scripting.FileSystemObject")
If objFSO.FileExists(strIndexPath) Then
    MsgBox "🛸 SENTINEL Drone Fleet Manager is launching..." & vbCrLf & vbCrLf & _
            "Your browser will open automatically." & vbCrLf & vbCrLf & _
            "Enjoy!", 64, "Sentinel Fleet Manager"
Else
    MsgBox "Error: Could not find index.html" & vbCrLf & _
            "Path: " & strIndexPath, 16, "Sentinel - Error"
End If
