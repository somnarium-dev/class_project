if (!global.debug_data_enabled)
{ exit; }

//Show croc's current speed next to its head.
displayCrocodileCurrentSpeed();

//needs fixed below.
//displayCrocodileCurrentState();

//Display state of all currently existing fish.
updateArrayOfAllFish();
displayStateOfAllFish();

//Display behavior of all currently existing fish.
displayBehaviorOfAllFish();