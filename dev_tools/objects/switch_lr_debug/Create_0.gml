/// @desc 
//public attributes
value = false;


//private method
function Detect_Mouse(){
    var _pos = -1;
    if((y <= mouse_y) && (mouse_y <= y+sprite_height)){
        if(x <= mouse_x) && (mouse_x <= x+(sprite_width/2)){
            _pos = 0;
            value = (mouse_check_button_pressed(mb_left)) ? false : value;
        }
        else if(x+(sprite_width/2) <= mouse_x) && (mouse_x <= x+(sprite_width)){
            _pos = 1;
            value = (mouse_check_button_pressed(mb_left)) ? true : value;
        }
        else{}//mouse_x is out of range
    }
    else{}//mouse_x is out of range

    return _pos;
}