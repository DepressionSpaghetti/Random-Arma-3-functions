/*------------------------------------------------------------------------- 

Description: 
      Displays a timer with an ammount of time equal to the given parameter

Parameters:
      0: must be:
          integer in format of seconds 
          ex: 3min = 180, 7min = 420 , 10min = 600 , 1hr = 3600.

Example:
      handleName = [180] call TG_fnc_countdown

--------------------------------------------------------------------------*/

TG_fnc_time = 
{
      params ["_playtime"];

      _h = (_playtime-(_playtime % 1));
      _m = ((_playtime % 1)*60)-((_playtime % 1)*60) % 1;
      _s = (((_playtime % 1)*3600)-((_playtime % 1)*3600) % 1) - (_m*60);
      _hh = "";
      if (_h < 10) then {_hh = "0"};
      _mm = "";
      if (_m < 10) then {_mm = "0"};
      _ss = "";
      if (_s < 10) then {_ss = "0"};
      _playtimeHMS = format ["%1%2:%3%4:%5%6",_hh,_h,_mm,_m,_ss,_s];
      _playtimeHMS;

};


sleep 0.01;
params["_timer"];
publicvariable "_timer";
 
waitUntil {!isnil "_timer"};
 
while {(_timer >= 0)} do 
{
      hintSilent parsetext format ["<t size=1.5' align='center'>%1</t>",[(_timer / 3600)] call TG_fnc_time];
            _timer = _timer - 1;
            publicvariable "_timer";
            sleep 1;
 
};
timer = 0;
hint "";

_returnValue = true;
_returnValue;