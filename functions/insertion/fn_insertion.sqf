/*--------------------------------------------------------------------------------------------------------------------

Description: 
      Plays back a vehicle flightpath and allows the insertion of units via rappel.
	  To be used only with helicopters used as transport vehicles.
	  Note that the rappel function can only be used with the ACE mod.
	
Usage:
	  1. use BIS_fnc_UnitCapture to record the flightpath of your helicopter
	  2. copy the given flightpath to a variable
	  3. pass all needed parameters to the called function in your script

Parameters:
      0: must be:
          variable of the vehicle name
          ex: blackhawk
	  1: must be:
	  	  a variable containing an array of coordinates obtained by using BIS_fnc_UnitCapture
		  ex: data1, movData
	  2: must be:
	  	  variable of the trigger that finishes the script
		  ex: trigger1, trigg1
	  3: may be:
	  	  boolean that determines if the units will or wont rappel, false by default(do not use without the ACE mod)
		  ex: true, false

Example:
      handleName = [blackhawk, movData, trigg1, true] call TG_fnc_countdown;
      handleName = [blackhawk, movData, trigg1] call TG_fnc_countdown;

---------------------------------------------------------------------------------------------------------------------*/


params ["_vName", "_mData", "_triggerName", ["_willRappel", false]];

_movementdata = _mData ;

_sequence = [_vName, _movementdata] spawn BIS_fnc_UnitPlay;
_vName engineOn true;
waitUntil {scriptDone _sequence};

if(_willRappel) then
{
	[_vName] call ace_fastroping_fnc_deployAI;

};

_position = getPos _vName;
while{!(triggerActivated _triggerName)} do
{
	_vName setPos _position;
	sleep 0.01;

};