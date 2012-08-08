#include <sourcemod>
#include <clients.inc>

new players,tscore,ctscore;
new String:debugstring[10]="#ATHENA#\t";

public Plugin:myinfo =
{
	name 		= "Athena",
	author		= "Saigon",
	description	= "Gamestate relaying to an online scoreboard",
	version		= "2.1.0.0",
	url 		= "https://github.com/sedley/Athena"
}

public OnPluginStart()
{
	PrintToServer("Athena loaded");
	HookEvent("round_end", Event_Round_End);
	PrintToServer("Athena: Round Hooked");
}

public bool:OnClientConnect(client, String:rejectmsg[], maxlen)
{
	PrintToServer("%s Connection detected",debugstring);
	PrintToServer("%s %d Players detected",debugstring,++players);
	return true;
}

public OnClientDisconnect(client)
{
	if(players!=0) players--;
}

public Action:Event_Round_End(Handle:event, const String:name[], bool:dontBroadcast)
{
	new String:clientname[12];
	new outcome,team,clientdeaths,clientfrags;
	
	// Filename used for logging purposes
	new String:filename[10]="./match.log";
	
	// Team variables (output)
	new String:ctstring[18]	= "COUNTERTERRORIST";
	new String:tstring[18]	= "TERRORIST";
	
	// Init file handler for log
	if(FileExists(filename)) DeleteFile(filename);
	new Handle:fout=OpenFile(filename,"w");
	
	// Temporary string buffer used to format log strings
	new String:temp[255]="";

	team 	= GetEventInt(event,"winner");
	outcome = GetEventInt(event,"reason");
	PrintToServer("%s Team %d won for reason %d",debugstring,team,outcome);

	// Add to overall team score
	if(team==3) ctscore++;
	if(team==2) tscore++;

	// COUNTERTERRORISTS {SCORE}
	Format(temp, sizeof(temp), "%s %d\n", ctstring,ctscore);
	WriteFileString(fout,temp,false);
	
	for(new i=1;i<=players;i++)
	{
		GetClientName(i,clientname,12);
		clientdeaths = GetClientDeaths(i);
		clientfrags  = GetClientFrags(i);
		
		if(GetClientTeam(i)==3)
		{
			Format(temp, sizeof(temp), "%s,%d,%d\n", clientname,clientfrags,clientdeaths);
			WriteFileString(fout,temp,false);
		}
	}
	
	// TERRORISTS {SCORE}
	Format(temp, sizeof(temp), "%s %d\n", tstring, tscore);
	WriteFileString(fout,temp,false);
	
	for(new i=1;i<=players;i++)
	{
		GetClientName(i,clientname,12);
		clientdeaths = GetClientDeaths(i);
		clientfrags  = GetClientFrags(i);
		
		if(GetClientTeam(i)==2)
		{
			Format(temp, sizeof(temp), "%s,%d,%d\n", clientname,clientfrags,clientdeaths);
			WriteFileString(fout,temp,false);
		}
	}
	
	FlushFile(fout);
}