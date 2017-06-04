scriptName def Native Hidden

bool Function exe(String command) global native

bool Function openmenu(String command) global
  exe("showmenu "+command)
EndFunction

bool Function addexp(int value) global
  exe("player.modav 000002C9 "+value)
EndFunction
