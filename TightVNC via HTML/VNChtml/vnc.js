var destination=(WScript.Arguments(0))
var search='vnch://'
var rdpexe="C:\\Program Files\\TightVNC\\tvnviewer.exe"
//WScript.Echo(destination)
destination=destination.replace(search, '')
destination=destination.replace('/', '')
var ws = new ActiveXObject("WScript.Shell")
//WScript.Echo(rdpexe +" -host="+destination +" -port=5900" +" -password=")
ws.Exec(rdpexe +" -host="+destination +" -port=5900" +" -password=")
