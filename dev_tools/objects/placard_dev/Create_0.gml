/// @desc 
isEnable = true;
text="";
font=draw_get_font();
alignX = "RIGHT";//LEFT, MIDDLE, RIGHT
alignY = "MIDDLE";//ABOVE, MIDDLE, BENEATH

function TurnOn(){visible = true;}
function TurnOff(){visible = false;}

function SetText(_text){
    if(is_string(_text)){
        text=_text;
    }
}

function SetFont(_font){
    font = _font;
}

VisibleCondition = function(){return true;}