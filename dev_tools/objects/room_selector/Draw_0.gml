/// @desc 
CHECK_DEBUG_SWITCH
Draw_Base();

switch(Check_MousePressedButton()){
case prv.buttonLeft:
    Draw_LeftButton(prv.c_ButtonPressed);   //re-draw left button
    choiceCurrent--;
    break;
case prv.buttonRight:
    Draw_RightButton(prv.c_ButtonPressed);  //re-draw left button
    choiceCurrent++;
    break;
case prv.buttonNone:
default:
}


if(choiceCurrent < 0){
    choiceCurrent = prv.numChoices-1;
}
else if(prv.numChoices <= choiceCurrent){
    choiceCurrent = 0;
}

Draw_ChoiceArea();

if(choiceCurrent!=prv.choicePrevious){
    TriggerAction();
}

prv.choicePrevious = choiceCurrent;