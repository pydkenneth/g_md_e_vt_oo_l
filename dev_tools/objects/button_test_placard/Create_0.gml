/// @desc 

//public attributes
isPressed = false;  //read only

//triggered when (isPressed == true)
TriggerAction = function(){ 
    draw_text(x, y+24, "button is pressed");
    inst_placard.SetText("BUTTON IS PREESED");
    return;
}

TriggerAction_NOT = function(){
    inst_placard.SetText("NOT PRESSED");
}

prv = {
    toggle : 0, //DO NOT EDIT
    push_button : 1, //DO NOT EDIT
    
    //USER DEFINE STYLE:
    typeButton : 0, //0:toggle, 1:pushbutton
    width : 96,
    height : 48,
    c_NotPressed : c_green,
    name : object_get_name(object_index)
}