/**
* Disable Logging in Warmup
*
* @author crinis
* @version 0.1.0
* @link https://www.crinis.org
*/

#pragma semicolon 1
#pragma newdecls required

#include <sourcemod>
#include <sdktools>

#define VERSION	"0.1.0"

#if 0
	#define _DEBUG
#endif

public Plugin myinfo =
{
    name        = "Disable Logging in Warmup",
    author      = "crinis",
    description = "Sets 'log off' during warmup and enables it for regular rounds",
    version     = VERSION,
    url         = "https://www.crinis.org"
};

public void OnPluginStart()
{
    HookEvent("round_start", Event_OnRoundStart, EventHookMode_PostNoCopy); 
}

public void Event_OnRoundStart(Event event, const char[] name, bool dontBroadcast)
{
	if (isWarmup())
	{
		ServerCommand("log off");
	}
	else
	{
		ServerCommand("log on");
	}
}

public bool isWarmup()
{
	int warmupPeriod = GameRules_GetProp("m_bWarmupPeriod");
	if (warmupPeriod == 1)
	{
		#if defined _DEBUG
			PrintToServer("Is Warmup: %d", warmupPeriod);
		#endif
		return true;
	}
	#if defined _DEBUG
		PrintToServer("Is no Warmup: %d", warmupPeriod);
	#endif
	return false;
}
