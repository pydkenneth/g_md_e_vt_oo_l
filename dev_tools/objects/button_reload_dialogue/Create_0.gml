/// @desc 

//public attributes
isPressed = false;  //read only

//triggered when (isPressed == true)
TriggerAction = function(){ 
    inst_controller_dialogue_dev.Reload();
    inst_text_check_csv.PushText(".csv is reloaded",60);
    return;
}

prv = {
    toggle : 0, //DO NOT EDIT
    push_button : 1, //DO NOT EDIT
    
    //USER DEFINE STYLE:
    typeButton : 1, //0:toggle, 1:pushbutton
    width : 96,
    height : 48,
    c_NotPressed : c_green,
    name : "Reload .csv"
}