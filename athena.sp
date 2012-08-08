#include <sourcemod>
#include <clients.inc>

new tscore,ctscore;
new String:debugstring[10]	= "#ATHENA#\t";
new String:ctstring[18]		= "COUNTERTERRORIST";
new String:tstring[18]		= "TERRORIST";

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
	PrintToServer("%s Plugin loaded",debugstring);
	HookEvent("round_end", Event_Round_End);
	HookEvent("player_death", Event_PlayerDeath, EventHookMode_Pre);
	PrintToServer("%s Round End + Player Death Hooked",debugstring);
}

public updateScores(counterscore,terrscore){
	new String:filename[10] = "./match.log";
	
	// Temporary string buffer used to format log strings
	new String:temp[255]="";
	
	// Init file handler for log
	new Handle:fout=OpenFile(filename,"w");
	
	new clientdeaths,clientfrags;
	new String:clientname[50];
	
	// COUNTERTERRORISTS {SCORE}
	Format(temp, sizeof(temp), "%s %d\n",ctstring,counterscore);
	WriteFileString(fout,temp,false);
	
	for(new i=1;i<=GetClientCount()+1;i++)
	{
		if (IsClientConnected(i)){
			GetClientName(i,clientname,49);
			clientdeaths = GetClientDeaths(i);
			clientfrags  = GetClientFrags(i);
			
			if(GetClientTeam(i)==3)
			{
				Format(temp, sizeof(temp), "%s,%d,%d\n",clientname,clientfrags,clientdeaths);
				WriteFileString(fout,temp,false);
			}
		}
	}
	
	// TERRORISTS {SCORE}
	Format(temp, sizeof(temp), "%s %d\n",tstring,terrscore);
	WriteFileString(fout,temp,false);
	for(new i=1;i<=GetClientCount()+1;i++)
	{
		if (IsClientConnected(i)){
			GetClientName(i,clientname,49);
			clientdeaths = GetClientDeaths(i);
			clientfrags  = GetClientFrags(i);
			
			if(GetClientTeam(i)==2)
			{
				Format(temp, sizeof(temp), "%s,%d,%d\n",clientname,clientfrags,clientdeaths);
				WriteFileString(fout,temp,false);
			}
		}
	}
	FlushFile(fout);
}

public Action:Event_Round_End(Handle:event, const String:name[], bool:dontBroadcast)
{
	new team = GetEventInt(event,"winner");

	if(team==3) ctscore++;
	if(team==2) tscore++;
	
	updateScores(ctscore, tscore);
}

public Action:Event_PlayerDeath(Handle:event, const String:name[], bool:dontBroadcast)
{
	updateScores(ctscore,tscore);
}