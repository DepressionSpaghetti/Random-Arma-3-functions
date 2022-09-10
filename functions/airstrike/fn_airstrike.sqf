/*-------------------------------------------------------------------------------------------------------------------------------------------

Description: 
      Plays back a scripted airstrike.
	
Usage:
	  1. use BIS_fnc_UnitCapture(add true at the end when calling) to record the flightpath and weapon firing data of your jet or helicopter
	  2. copy the given flightpath and firing data to their respective variables
	  3. pass all needed parameters to the called function in your script

Parameters:
      0: must be:
          variable of the vehicle name
          ex: blackhawk
	  1: must be:
	  	  a variable containing an array of coordinates obtained by using BIS_fnc_UnitCapture
		  ex: data1, movData
	  2: must be:
	  	  a variable containing an array of firing data obtained by using BIS_fnc_UnitCapture
		  ex: data2, firData

Example:
      handleName = [wasp, movData, firData] call TG_fnc_airstrike;

-------------------------------------------------------------------------------------------------------------------------------------------*/


params["_vName", "_mData", "_fData" ];

_movementdata = _mData; ;
_firingdata = _fData ; 

_sequence = [_vName, _movementdata] spawn BIS_fnc_UnitPlay;
_vName engineOn true;
[_vName, _firingdata] spawn BIS_fnc_UnitPlayFiring;
waitUntil {scriptDone _sequence};

{deleteVehicle _x} forEach (crew _vName);
deleteVehicle _vName;

_returnValue = true;
_returnValue;