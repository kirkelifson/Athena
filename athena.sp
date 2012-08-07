#include <sourcemod>



public Plugin:myinfo =
{
	name = "Athena",
	author = "Saigon",
	description = "Gamestate relaying to an online scoreboard",
	version = "0.1.2.0",
	url = "https://github.com/sedley/Athena"
}

new tscore,ctscore,outcome,team;

public OnPluginStart()
{
	PrintToServer("Athena loaded");
	HookEvent("round_end", Event_Round_End)
	PrintToServer("Athena: Round Hooked");
}

public Action:Event_Round_End(Handle:event, const String:name[], bool:dontBroadcast)
{
	team = GetEventInt(event, "winner");
	outcome = GetEventInt(event, "reason");
	PrintToServer("********ATHENA DEBUG MESSAGE***********\nTeam %d won for reason %d",team,outcome);
	if(team==3){ctscore++;}
	if(team==2){tscore++;}
	LogToFileEx("./test.log", "%d,%d",ctscore,tscore);
}	




	
