#region public attributes
isEnabled = false;
delayHold = 3*60;//sec

width = 96;
height = 48;
c_NotPressed = c_green;
name = object_get_name(object_index);
#endregion

#region private attributes
prv = {
    isPressed : false,
    state : "Waiting_Release"//DO NOT EDIT
}
#endregion

function Check_Button_Released(){
    return mouse_check_button_released(mb_left);
}

function Check_Button_Pressing(){
    if(mouse_check_button(mb_left)){
        prv.isPressed = true;
        return true;
    }
    prv.isPressed = false;
    return false;
}

ActionReleased = function(){

}

ActionHolding = function(){
    
}