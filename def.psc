scriptName def Native Hidden

struct DEFCondition
  int functionId
  float compareValue
	Form form1
  int u321
  int s321
  float f321
  Form form2
  int u322
  int s322
  float f322
  int flags
  int op
EndStruct

String Function exe(String command) global native

String Function tracesmth() global native

DEFCondition[] Function traceperk(Perk aperk) global native

bool Function addpk(Perk aperk) global native

bool Function openmenu(String command) global
  exe("showmenu "+command)
EndFunction

String Function addexp(int value) global
  return exe("player.modav 000002C9 "+value)
EndFunction

bool Function SetLVLUPVars(FormList[] perklist,FormList[] skillslist, ActorValue SP, ActorValue PP) global native

bool Function SetPerksIDs(int ITPerkID,int NWPerkID,int APPerkID) global native
