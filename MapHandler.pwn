//MAP HANDLER (FS)
#include <a_samp>
#include <crashdetect>
#include <stuff\Defines>
#include <stuff\MapName>

forward maphandler_reset(mapid);
forward maphandler_init(mapid);

public maphandler_init(mapid)
{
	new string[70];
	format(string,sizeof(string),"loadfs /Maps/%s",MapName[mapid]);
	SendRconCommand(string);
	format(string,sizeof(string),"gamemodetext %s",MapName[mapid]);
	SendRconCommand(string);
	CallRemoteFunction("GM_StartTimer","");
	format(string,sizeof(string),"<!> Mission %s has sucessfully intizlized.",MapName[mapid]);
	SendClientMessageToAll(COLOR_CYCLE,string);
	return 1;
}

public maphandler_reset(mapid)
{
	new string[70];
	format(string,sizeof(string),"unloadfs /Maps/%s",MapName[mapid]);
	SendRconCommand(string);
	return 1;
}