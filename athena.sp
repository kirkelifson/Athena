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
	if(FileExists("./test.log")){DeleteFile("./test.log");}
	new Handle:fout=OpenFile("./test.log","w");
	team = GetEventInt(event, "winner");
	outcome = GetEventInt(event, "reason");
	PrintToServer("********ATHENA DEBUG MESSAGE***********\nTeam %d won for reason %d",team,outcome);
	if(team==3){ctscore++;}
	if(team==2){tscore++;}
	new String:ctstring[18]="COUNTERTERRORIST ";
	new String:ctscorestring[3];
	new String:tstring[18]="\nTERRORIST ";
	new String:tscorestr[3];
	IntToString(tscore,tscorestr,3);
	IntToString(ctscore,ctscorestring,3);
	WriteFileString(fout,ctstring,0);
	WriteFileString(fout,ctscorestring,0);
	for(new i=1;i<players+1;i++)
	{
		GetClientName(i,clientname,12)
		clientdeaths=GetClientDeaths(i);
		new String:deathsstr[3];
		IntToString(clientdeaths,deathsstr,3);
		clientfrags=GetClientFrags(i);
		new String:fragsstr[3];
		IntToString(clientfrags,fragsstr,3);
		if(GetClientTeam(i)==3){PrintToServer("%s, %d, %d", clientname,clientfrags,clientdeaths);}
		if(GetClientTeam(i)==3)
		{
			WriteFileString(fout,"\n",0)
			WriteFileString(fout,clientname,0);
			WriteFileString(fout,",",0);
			WriteFileString(fout,fragsstr,0);
			WriteFileString(fout,",",0);
			WriteFileString(fout,deathsstr,0);
		}
	}
	WriteFileString(fout,tstring,0)
	WriteFileString(fout, tscorestr,0)
	for(new i=1;i<players+1;i++)
	{
		GetClientName(i,clientname,12)
                clientdeaths=GetClientDeaths(i);
                new String:deathsstr[3];
                IntToString(clientdeaths,deathsstr,3);
                clientfrags=GetClientFrags(i);
                new String:fragsstr[3];
                IntToString(clientfrags,fragsstr,3);
		if(GetClientTeam(i)==2){PrintToServer("%s, %d, %d", clientname,clientfrags,clientdeaths);}
		if(GetClientTeam(i)==2)
        	        {
                	         WriteFileString(fout,"\n",0)
                	       	 WriteFileString(fout,clientname,0);
                 	         WriteFileString(fout,",",0);
                	         WriteFileString(fout,fragsstr,0);
                       		 WriteFileString(fout,",",0);
                       		 WriteFileString(fout,deathsstr,0);
                	}

		
		
	}
	FlushFile(fout);

}	





	
