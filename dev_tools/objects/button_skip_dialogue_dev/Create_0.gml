#region public attributes
isEnabled = false;
delayHold = 3*60;//sec

width = 96;
height = 48;
c_NotPressed = c_green;
name = object_get_name(object_index);

//input
stateText = " ";
stateTextPrev = " ";
#endregion

#region private attributes
prv = {
    isPressed : false,
    state : "Waiting_Release"//DO NOT EDIT
}
eleSeq = -1;
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

Show = function(){
    eleSeq = layer_sequence_create(layer,x,y,seq_button_skip);
    layer_sequence_xscale(eleSeq, 0.8);
    layer_sequence_yscale(eleSeq, 0.8);
}

Hide = function(){
    layer_sequence_destroy(eleSeq);
}


function Check_Printer_StateText(){//private
    if((stateText == "PAUSE")&&(stateTextPrev != "PAUSE")){
        Show();
    }
    else if((stateText != "PAUSE")&&(stateTextPrev == "PAUSE")){
        Hide();
    }
    
    stateTextPrev = stateText;
}
