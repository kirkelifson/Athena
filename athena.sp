#include <sourcemod>
#include <clients.inc>



public Plugin:myinfo =
{
	name = "Athena",
	author = "Saigon",
	description = "Gamestate relaying to an online scoreboard",
	version = "2.1.0.0",
	url = "https://github.com/sedley/Athena"
}

new tscore,ctscore,outcome,team,players,maxclients,clientdeaths,clientfrags;
new String:clientname[12];

public bool:OnClientConnect(client, String:rejectmsg[], maxlen)
{
	PrintToServer("Connection detected");
	maxclients=GetMaxClients();
	//for(new i=1;i<maxclients;i++)
	//{
	//if(IsClientConnected(client)) 
	//players++
	//}
	players++
	PrintToServer("%d Players detected",players);
	return true;
}
	


public OnClientDisconnect(client)
{
	if(players!=0){players--;}
}
		


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
	for(new i=1;i<players;i++)
	{
		GetClientName(i,clientname,12)
		clientdeaths=GetClientDeaths(i);
		clientfrags=GetClientFrags(i);
		PrintToServer("%s %d %d", clientname,clientfrags,clientdeaths);
		LogToFileEx("./test.log", "%s %d %d", clientname,clientfrags,clientdeaths);
	}

}	





	
