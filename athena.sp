#include <sourcemod>
#include <clients.inc>
#include <sdktools_functions.inc>

new String:debugstring[10]  = "[Athena]\t";
new String:ctstring[18]     = "COUNTERTERRORIST";
new String:tstring[18]      = "TERRORIST";

public Plugin:myinfo =
{
    name        = "Athena",
    author      = "Saigon and xtc",
    description = "Gamestate relaying to an online scoreboard",
    version     = "1.1",
    url         = "https://github.com/sedley/Athena"
}

public OnPluginStart()
{
    HookEvent("round_end", Event_Round_End);
    HookEvent("player_death", Event_Player_Death);
}

public updateScores(counterscore,terrscore){
    // Place match.log relative to /cstrike/
    new String:filename[10] = "match.log";

    // Temporary string buffer used to format log strings
    new String:temp[255] = "";

    // Open match.log and erase contents
    new Handle:fout = OpenFile(filename, "w");

    new clientdeaths,clientfrags;
    new String:clientname[50];

    // Print Counter-Terrorist score
    Format(temp, sizeof(temp), "%s %d\n", ctstring, counterscore);
    WriteFileString(fout, temp, false);

    for(new i = 1; i <= GetClientCount() + 1; i++)
    {
        // Print each player + score
        if (IsClientInGame(i)){
            GetClientName(i, clientname, 49);
            clientdeaths = GetClientDeaths(i);
            clientfrags  = GetClientFrags(i);

            if(GetClientTeam(i) == 3)
            {
                Format(temp, sizeof(temp), "%s,%d,%d\n", clientname, clientfrags, clientdeaths);
                WriteFileString(fout, temp, false);
            }
        }
    }

    // Print Terrorist score
    Format(temp, sizeof(temp), "%s %d\n", tstring, terrscore);
    WriteFileString(fout, temp, false);

    for(new i = 1; i <= GetClientCount() + 1; i++)
    {
        // Print each player + score
        if (IsClientInGame(i)){
            GetClientName(i, clientname, 49);
            clientdeaths = GetClientDeaths(i);
            clientfrags  = GetClientFrags(i);

            if(GetClientTeam(i) == 2)
            {
                Format(temp, sizeof(temp), "%s,%d,%d\n", clientname, clientfrags, clientdeaths);
                WriteFileString(fout, temp, false);
            }
        }
    }

    FlushFile(fout);
    CloseHandle(fout);
}

public Action:Event_Round_End(Handle:event, const String:name[], bool:dontBroadcast)
{
    updateScores(GetTeamScore(3), GetTeamScore(2));
}

public Action:Event_Player_Death(Handle:event, const String:name[], bool:dontBroadcast)
{
    updateScores(GetTeamScore(3),GetTeamScore(2));
}

