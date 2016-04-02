 //Idea by: JimmySpaceTravel1337. 
#include <a_samp>
#include <crashdetect>

new Animations= 0;
new Shop= 0; 
new ShopWeapons= 0; 
new ShopVehicles= 0; 
new SafeSpawn= 0; 
new Fix= 1; 
new Flip= 1; 

#define RACE_VEH 475

#define MapName "RACE:Fat N Furious 2012"
#define RACE_COLOR 0x00b159FF //Different color for each maps!

#undef MAX_OBJECTS
#define MAX_OBJECTS (70)

main() {}

new Object[MAX_OBJECTS];

#define MAX_CPs (22)
enum race_cp_enum
{
	Float:race_cp_x,
	Float:race_cp_y,
	Float:race_cp_z,
	race_cp_type,
	Float:race_cp_size
};

forward Float:map_RaceCPs(CP_ID,DATA);
forward map_GetCPType(CP_ID,DATA);
forward map_GetMaxCPs();
forward Float:map_GetSpawn(id,coord);
forward map_CommandsInfo(data);
forward map_ChangeCommandsInfo(ToChange,NewValue);
forward map_GetRaceVehicle();
forward map_GetRaceColor();

new race_cp[MAX_CPs][race_cp_enum] =
{
	{2401.9263,-1849.5790,1.4878,0,10.0},
	{2264.4475,-1850.0889,-0.1345,0,10.0},
	{2072.6184,-1851.8551,3.9910, 0,10.0},
	{1878.8970,-1824.3098,3.9844, 0,10.0},
	{1626.5961,-1765.1340,3.9531, 0,10.0}, 
	{1395.1971,-1715.5662,8.0526, 0,10.0},
	{1359.6703,-1703.8370,8.5982, 0,10.0},
	{1360.8770,-1601.4047,8.6094, 0,10.0},
	{1375.6768,-1548.1200,11.8860,0,10.0},
	{1397.8450,-1399.2578,13.3828,0,10.0},
	{1194.7255,-1401.0759,13.2399,0,10.0},
	{1010.3960,-1404.2449,13.0156,0,10.0},
	{918.3365,-1400.0817,13.2679, 0,10.0},
	{914.5586,-1324.2485,13.5328, 0,10.0},
	{636.2028,-1318.3900,13.3717, 0,10.0},
	{506.4973,-1343.8748,15.9609, 0,10.0},
	{422.6868,-1462.9189,30.4063, 0,10.0},
	{338.2437,-1552.4907,33.0610, 0,10.0},
	{330.8843,-1629.2592,33.1704, 0,10.0},
	{322.1732,-1732.1613,19.7591, 0,10.0},
	{291.1890,-1956.2056,14.1414, 3,10.0},
	{291.6175,-1984.4327,3.3688,  1,10.0}
};

new Float:spawns[][4] =
{
	{2442.8079,-1863.8376,1.2415,87.8521},
	{2442.9280,-1860.6193,1.2426,87.8520},
	{2443.0662,-1856.9230,1.2439,87.8520},
	{2443.2837,-1851.1206,1.2458,87.8520},
	{2443.4250,-1847.3544,1.2471,87.8520},
	{2443.6614,-1841.0397,1.2492,87.8520}
};
   

public Float:map_GetSpawn(id,coord)
{
	if(coord < 0 || coord > 3) return -1.0; 
	return spawns[id][coord];
}
   
public OnFilterScriptInit()
{
	print(""MapName" initialized");
	Object[0] = CreateObject(5333,1373.8000500,-1557.4000200,9.9900000,0.0000000,0.0000000,255.7450000); //
	Object[1] = CreateObject(4585,1198.6999500,-1364.0999800,36.0000000,0.0000000,80.0000000,0.0000000); //
	Object[2] = CreateObject(10948,909.2000100,-1445.5999800,23.0000000,0.0000000,18.0000000,20.0000000); //
	Object[3] = CreateObject(4602,1312.4000200,-1432.5999800,80.0000000,0.0000000,0.0000000,0.0000000); //
	Object[4] = CreateObject(1683,1333.0999800,-1408.6999500,61.2000000,0.0000000,24.0000000,240.0000000); //
	Object[5] = CreateObject(3988,1340.1999500,-1433.6999500,15.0000000,10.0000000,355.0000000,264.0000000); //
	Object[6] = CreateObject(4552,1310.0999800,-1347.5999800,15.0000000,0.0000000,14.0000000,74.0000000); //
	Object[7] = CreateObject(4552,1241.9000200,-1363.9000200,15.0000000,0.0000000,13.9970000,91.9980000); //
	Object[8] = CreateObject(3567,1196.1999500,-1430.6999500,13.0000000,0.0000000,0.0000000,72.0000000); //
	Object[9] = CreateObject(4060,1052.8000500,-1433.0000000,17.0000000,0.0000000,8.0000000,0.0000000); //
	Object[10] = CreateObject(4563,1002.7000100,-1331.3000500,20.0000000,0.0000000,68.0000000,270.0000000); //
	Object[11] = CreateObject(12932,949.2999900,-1316.5999800,15.7000000,0.0000000,0.0000000,102.0000000); //
	Object[12] = CreateObject(4117,1079.5000000,-1372.5000000,20.0000000,0.0000000,0.0000000,104.0000000); //
	Object[13] = CreateObject(1683,798.7000100,-1338.9000200,18.3000000,0.0000000,66.0000000,250.0000000); //
	Object[14] = CreateObject(1681,525.9000200,-1340.0999800,32.2000000,0.0000000,0.0000000,100.0000000); //
	Object[15] = CreateObject(6336,773.0999800,-1289.0000000,20.0000000,15.0000000,20.0000000,340.0000000); //
	Object[16] = CreateObject(6364,501.8999900,-1350.4000200,30.0000000,10.0000000,310.0000000,280.0000000); //
	Object[17] = CreateObject(6391,490.6000100,-1325.1999500,50.0000000,0.0000000,0.0000000,30.0000000); //
	Object[18] = CreateObject(6288,659.7999900,-1338.9000200,18.1000000,0.0000000,12.0000000,92.0000000); //
	Object[19] = CreateObject(5711,630.9000200,-1304.3000500,15.0000000,0.0000000,0.0000000,90.0000000); //
	Object[20] = CreateObject(17636,344.7000100,-1425.0999800,36.0000000,0.0000000,0.0000000,49.0000000); //
	Object[21] = CreateObject(17546,448.8999900,-1452.1999500,40.0000000,0.0000000,352.0000000,324.0000000); //
	Object[22] = CreateObject(17546,442.3999900,-1480.5000000,40.0000000,0.0000000,7.9960000,221.9980000); //
	Object[23] = CreateObject(17546,411.8999900,-1507.4000200,40.0000000,0.0000000,357.9930000,221.9950000); //
	Object[24] = CreateObject(17546,379.2999900,-1537.3000500,40.0000000,0.0000000,1.9900000,223.9900000); //
	Object[25] = CreateObject(17546,358.3999900,-1571.5000000,40.0000000,0.0000000,9.9890000,251.9890000); //
	Object[26] = CreateObject(17546,354.1000100,-1603.5999800,40.0000000,0.0000000,335.9870000,277.9880000); //
	Object[27] = CreateObject(6404,294.3999900,-1586.0000000,35.0000000,0.0000000,0.0000000,276.0000000); //
	Object[28] = CreateObject(6404,292.2999900,-1634.6999500,35.0000000,0.0000000,0.0000000,285.9990000); //
	Object[29] = CreateObject(4564,315.3999900,-1779.4000200,-21.7000000,80.0000000,180.0000000,174.0000000); //
	Object[30] = CreateObject(11011,330.3999900,-1642.0999800,35.0000000,0.0000000,0.0000000,178.0000000); //
	Object[31] = CreateObject(11010,356.0000000,-1645.9000200,37.8000000,0.0000000,0.0000000,30.0000000); //
	Object[32] = CreateObject(11010,306.7999900,-1654.6999500,38.1000000,0.0000000,0.0000000,341.9980000); //
	Object[33] = CreateObject(4564,313.5000000,-1817.8000500,-21.7000000,85.0000000,179.9950000,173.9960000); //
	Object[34] = CreateObject(1655,315.2999900,-1896.9000200,4.4000000,0.0000000,0.0000000,174.0000000); //
	Object[35] = CreateObject(1655,306.7000100,-1895.9000200,4.4000000,0.0000000,0.0000000,173.9960000); //
	Object[36] = CreateObject(1655,298.1000100,-1895.0999800,4.4000000,0.0000000,0.0000000,173.9960000); //
	Object[37] = CreateObject(9585,220.2000000,-2025.4000200,-40.0000000,32.8040000,31.2170000,226.5840000); //
	Object[38] = CreateObject(10230,327.6000100,-1955.8000500,-5.0000000,10.0000000,350.0000000,70.0000000); //
	Object[39] = CreateObject(9958,299.2000100,-1931.5000000,5.2000000,0.0000000,0.0000000,60.0000000); //
	Object[40] = CreateObject(17026,286.8999900,-1962.5000000,-12.0000000,0.0000000,0.0000000,50.0000000); //
	Object[41] = CreateObject(17026,314.7000100,-1977.0000000,0.0000000,0.0000000,0.0000000,340.0000000); //
	Object[42] = CreateObject(17026,257.7000100,-1987.3000500,0.0000000,0.0000000,0.0000000,119.9990000); //
	Object[43] = CreateObject(17026,282.7999900,-2007.5000000,0.0000000,0.0000000,0.0000000,199.9980000); //
	Object[44] = CreateObject(17026,302.5000000,-2005.5999800,0.0000000,0.0000000,0.0000000,259.9950000); //
	Object[45] = CreateObject(6959,288.7999900,-1981.0000000,2.4000000,0.0000000,0.0000000,0.0000000); //
	Object[46] = CreateObject(17026,296.7999900,-2011.6999500,16.5000000,0.0000000,320.0000000,242.0000000); //
	Object[47] = CreateObject(17026,267.5000000,-1999.9000200,16.5000000,0.0000000,319.9990000,191.9960000); //
	Object[48] = CreateObject(17026,318.3999900,-1987.8000500,16.5000000,0.0000000,319.9930000,309.9920000); //
	Object[49] = CreateObject(17026,284.1000100,-1993.5000000,40.0000000,345.0000000,150.0000000,90.0000000); //
	Object[50] = CreateObject(17026,261.3999900,-1980.5000000,16.5000000,0.0000000,323.9930000,169.9920000); //
	Object[51] = CreateObject(17026,317.2999900,-1983.8000500,16.5000000,0.0000000,323.9920000,331.9910000); //
	Object[52] = CreateObject(17026,284.7000100,-1984.5000000,40.0000000,345.6250000,145.9120000,112.9640000); //
	Object[53] = CreateObject(17026,285.2000100,-1977.5000000,40.0000000,345.6240000,145.9090000,112.9610000); //
	Object[54] = CreateObject(17026,280.2000100,-1962.3000500,-12.0000000,0.0000000,0.0000000,49.9990000); //
	Object[55] = CreateObject(3361,307.7999900,-1954.0000000,5.2000000,0.0000000,0.0000000,40.0000000); //
	Object[56] = CreateObject(3361,312.6000100,-1950.0999800,1.0000000,0.0000000,0.0000000,39.9960000); //
	Object[57] = CreateObject(10230,243.7000000,-1887.4000200,-5.0000000,9.7590000,343.9110000,113.0440000); //
	Object[58] = CreateObject(4563,2503.0000000,-1790.5999800,20.0000000,0.0000000,68.0000000,270.0000000); //
	Object[59] = CreateObject(17511,2608.0000000,-1857.0999800,0.0000000,0.0000000,0.0000000,346.0000000); //
	Object[60] = CreateObject(5463,2293.1001000,-1879.8000500,35.0000000,0.0000000,0.0000000,0.0000000); //
	Object[61] = CreateObject(5463,2287.6001000,-1850.0000000,30.0000000,0.0000000,300.0000000,96.0000000); //
	Object[62] = CreateObject(5463,2172.3999000,-1853.5999800,12.0000000,90.0000000,0.0000000,0.0000000); //
	Object[63] = CreateObject(4832,1970.0999800,-1865.6999500,30.0000000,0.0000000,28.0000000,68.0000000); //
	Object[64] = CreateObject(969,1622.8000500,-1753.9000200,3.0000000,0.0000000,0.0000000,6.0000000); //
	Object[65] = CreateObject(969,1614.0999800,-1754.8000500,3.0000000,0.0000000,0.0000000,5.9990000); //
	Object[66] = CreateObject(971,1368.8000500,-1698.5000000,10.0000000,0.0000000,0.0000000,300.0000000); //
	Object[67] = CreateObject(971,1430.4000200,-1435.1999500,15.0000000,0.0000000,0.0000000,260.0000000); //
	Object[68] = CreateObject(971,1427.5999800,-1443.4000200,15.0000000,0.0000000,0.0000000,241.9970000); //
	Object[69] = CreateObject(971,1422.0999800,-1449.8000500,15.0000000,0.0000000,2.0000000,217.9960000); //
	for(new i=0; i < 5; i++) AddPlayerClassEx(1,random(312),-2431.9709,-1619.5594,526.4762,297.8344,0,0,0,0,0,0); // 
	return 1;
}

public OnPlayerRequestClass(playerid,classid)
{
	TogglePlayerControllable(playerid,false);
	GameTextForPlayer(playerid,"~g~~h~RACER",1000,3);
	SetPlayerColor(playerid,RACE_COLOR);
	SetPlayerPos(playerid,533.9351,-1338.4342,34.9412);
	SetPlayerFacingAngle(playerid,283.0057);
	SetPlayerCameraPos(playerid,537.182617 , -1338.024536 , 36.544498);
	SetPlayerCameraLookAt(playerid,533.9351,-1338.4342,34.9412);
	return 1;
}

public OnFilterScriptExit()
{
    for(new i=0;i<MAX_OBJECTS;i++) DestroyObject(i);
	return 1;
}

public map_GetCPType(CP_ID,DATA) return race_cp[CP_ID][race_cp_type];
public map_GetMaxCPs() return MAX_CPs;
public map_GetRaceVehicle() return RACE_VEH;
public map_GetRaceColor() return RACE_COLOR;

public Float:map_RaceCPs(CP_ID,DATA)
{
	if(CP_ID < 0 || CP_ID > MAX_CPs) return -1.0;
	switch(DATA)
	{
		case 0: return Float:race_cp[CP_ID][race_cp_x];
		case 1: return race_cp[CP_ID][race_cp_y];
		case 2: return race_cp[CP_ID][race_cp_z];
		case 4: return race_cp[CP_ID][race_cp_size];
	}
	return -1.0;
}

public map_CommandsInfo(data)
{
	switch(data)
	{
		case 0: return SafeSpawn;
		case 1: return Animations;
		case 2: return Fix;
		case 3: return Flip;
		case 4: return Shop;
		case 5: return ShopWeapons;
		case 6: return ShopVehicles;
	}
	return 1;
}

public map_ChangeCommandsInfo(ToChange,NewValue)
{
	switch(ToChange)
	{
		case 0: SafeSpawn=NewValue;
		case 1: Animations=NewValue;
		case 2: Fix=NewValue;
		case 3: Flip=NewValue;
		case 4: Shop=NewValue;
		case 5: ShopWeapons=NewValue;
		case 6: ShopVehicles=NewValue;
	}
	return 1;
}