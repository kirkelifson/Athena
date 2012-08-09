#include <sourcemod>
#include <clients.inc>

new tscore,ctscore;
new String:debugstring[10]	= "#ATHENA#\t";
new String:ctstring[18]		= "COUNTERTERRORIST";
new String:tstring[18]		= "TERRORIST";

public Plugin:myinfo =
{
	name 		= "Athena",
	author		= "Saigon and XTC",
	description	= "Gamestate relaying to an online scoreboard",
	version		= "2.1.0.0",
	url 		= "https://github.com/sedley/Athena"
}

public OnPluginStart()
{
	PrintToServer("%s Plugin loaded",debugstring);
	HookEvent("round_end", Event_Round_End);				//Prepare to detect round end
	HookEvent("player_death", Event_PlayerDeath, EventHookMode_Pre);        //Prepare to detect player death
	PrintToServer("%s Round End + Player Death Hooked",debugstring);
}

public updateScores(counterscore,terrscore){
	new String:filename[10] = "match.log";					//Path to match.log in /cstrike
	
	// Temporary string buffer used to format log strings
	new String:temp[255]="";
	
	// Init file handler for log
	new Handle:fout=OpenFile(filename,"w");					//Open match.log and earase contents
	
	new clientdeaths,clientfrags;
	new String:clientname[50];
	
	// COUNTERTERRORISTS {SCORE}
	Format(temp, sizeof(temp), "%s %d\n",ctstring,counterscore);		//Report CT team score
	WriteFileString(fout,temp,false);
	for(new i=1;i<=GetClientCount()+1;i++)
	{
		if (IsClientInGame(i)){						//Report CT players scores
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
	
	// TERRORISTS {SCORE}							//Report T team score
	Format(temp, sizeof(temp), "%s %d\n",tstring,terrscore);
	WriteFileString(fout,temp,false);
	for(new i=1;i<=GetClientCount()+1;i++)
	{
		if (IsClientInGame(i)){						//Report T players scores
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

public Action:Event_Round_End(Handle:event, const String:name[], bool:dontBroadcast)		//Round end hook
{
	new team = GetEventInt(event,"winner");

	if(team==3) ctscore++;
	else if(team==2) tscore++;
	
	updateScores(ctscore, tscore);
}

public Action:Event_PlayerDeath(Handle:event, const String:name[], bool:dontBroadcast)		//Player death hook
{
	updateScores(ctscore,tscore);
}
