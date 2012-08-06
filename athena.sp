#include <sourcemod>



public Plugin:myinfo =
{
	name = "Athena"
	author = "saigon"
	description = "Gamestate relaying to an online scoreboard"
	version = "0.0.0.1"
	url = "https://github.com/sedley/Athena"
};

public OnPluginStart()
{
	PrintToServer("Athena loaded");
	new tscore=0,ctscore=0;
}




	
