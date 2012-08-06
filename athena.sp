#include <sourcemod>



public Plugin:myinfo =
{
	name = "Athena",
	author = "saigon",
	description = "Gamestate relaying to an online scoreboard",
	version = "0.0.0.1",
	url = "https://github.com/sedley/Athena"
}

new tscore=0,ctscore=0,winningteam;

public OnPluginStart()
{
	PrintToServer("Athena loaded");
	HookEvent("cs_win_panel_round", Event_Cs_Win_Panel_Round)
	PrintToServer("Athena: Win pannel hooked");
}

public Action:Event_Cs_Win_Panel_Round(Handle:event, const String:name[], bool:dontBroadcast)
{
	winningteam = GetEventInt(event, "final_event"); //8 for ct win 9 for t win 1 for target bombed 12 for defuse
	if(winningteam==8 || winningteam==12){ctscore++;}
	if(winningteam==9 || winningteam==1){tscore++;}
	PrintToServer("******ATHENA DEBUG REPORT******\nCT score: %d T score: %d",tscore,ctscore);
}	




	
