/*--------------------------------------------------------------------------------------------------------------------------

Description: 
      Plays back a flightpath of a plane of your choosing and airdrops the passengers after a trigger is activated.
	
Usage:
	  1. use BIS_fnc_UnitCapture to record the flightpath of your transport plane
	  2. copy the given flightpath to a variable
	  3. set a trigger in your editor
	  4. in your editor place a marker to serve as a rally point (when passing the name to the function enclose it in "")
	  5. pass all needed parameters to the called function in your script
	  6. optionally, if you're not using either the USAF mod C130J or the RHSUSAF mod C130J planes,
	     configure the animation source names for your specific case

Parameters:
      0: must be:
          variable of the vehicle name
          ex: C130
	  1: must be:
	  	  a variable containing an array of coordinates obtained by using BIS_fnc_UnitCapture
		  ex: data1, movData
	  2: must be:
	  	  variable of the trigger that triggers the paradrop
		  ex: trigger1, trigg1
	  3: must be:
	  	  name of the marker you placed as a rally point
		  ex: RVpoint

Example:
      handleName = [C130, movData, trigg1, RVpoint] call TG_fnc_paradrop;

--------------------------------------------------------------------------------------------------------------------------*/


params["_vName", "_mData", "_triggerName", "_markerName" ];
private _passengers = assignedCargo _vName;
_passengers set [count _passengers + 1, player];
private _eDelay = -1;

_movementdata = _mData;

_sequence = [_vName, _movementdata] spawn BIS_fnc_UnitPlay;
_vName engineOn true;
waitUntil {triggerActivated _triggerName};
if(_eDelay isEqualTo -1) then
{
	_eDelay = (1/(((speed _vName) max 40)/150));

};
if(triggerActivated _triggerName) then
{
	_vName animateSource["ramp", 0.65];				//RHSUSAF mod C130 leveled ramp
	_vName animateSource ["ramp_top", 1];			//USAF mod ramp top open
	_vName animateSource ["ramp_bottom", 0.5];		//USAF mod ramp bottom leveled
	sleep 6;

};
{
	_x disableAI "MOVE";
	_x disableCollisionWith _vName;
	unassignVehicle _x;
	_x action ["eject", vehicle _vName];
	[_x] allowGetIn false;
	_x setDir (-getDir _vName);
	sleep _eDelay;

}forEach _passengers;

_vName animateSource["ramp", 0.65];					//RHSUSAF mod C130 closed ramp
_vName animateSource ["ramp_top", 0];				//USAF mod ramp top closed
_vName animateSource ["ramp_bottom", 0];			//USAF mod ramp bottom closed
waitUntil {scriptDone _sequence};

{
	_x enableAI "MOVE";
	[_x] allowGetIn true;

}forEach _passengers;
group player addWaypoint [getMarkerPos _markerName, 0, 0];
{deleteVehicle _x} forEach (crew _vName);
deleteVehicle _vName;

_returnValue = true;
_returnValue;