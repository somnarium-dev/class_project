if (!global.debug_data_enabled)
{ exit; }

//Show croc's current speed next to its head in white.
displayCrocodileCurrentSpeed();

//Show croc's current state next to its head in blue.
displayCrocodileCurrentState();

//Display state of all currently existing fish in white.
updateArrayOfAllConsumables();
displayStateOfAllConsumables();

//Display behavior of all currently existing fish in blue.
dispolayBehaviorOfAllConsumables();

//Show Fish panic trigger range around Croc.
displayCrocodileDangerRanges();