# Random-Arma-3-functions
An assortement of Arma 3 functions useful for modded and vannila missions

This is a project to which i will be adding more functions as i need them in my missions so it will be updated irregularly.

# Included functions
- Countdown timer - in game hint and returns a value of "true" upon completion.
- Helicopter insertion/extraction - supports ACE fast roping, can be used both as insertion and as extraction. Adjust the triggers accordingly.
- Airstrike - scripted airstrike or close air support that deletes the vehicle upon completion to save resources. Script is simmilar to the insertion/extraction script                 but shouldn't be used for transport.
- Paradrop - scripted flightpath to airdrop units, automatic ramp opening onfigured for USAF and RHSUSAF mods, change animation sources if using different mods.

# Installation
1. Add the "functions" folder to your mission folder
2. Add the below lines to your description.ext file
     >```
     >class cfgFunctions
     >{
     >    #include "functions\cfgfunctions.hpp"
     >};
2. Thats it go use the functions
