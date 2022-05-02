/// @desc 
CHECK_DEBUG_SWITCH

//WARNING : DO NOT EDIT ALL CODE BELOW

//detect mouse in instance range
if(!Detect_Mouse_Area()){return;}

//if mouse in range, detect button
var _len = array_length(prv.actions_Buttons)
for(var _i=0; _i<_len; _i++){
    var _ii = 6-_i; //scan from right to left
    if(mouse_x >= prv.xposs[_ii]){  //if mouse_x > left bond of each block
        prv.actions_Buttons[_ii]();
        prv.cols[_ii] = merge_color(prv.c_Button, c_white,0.5);
        break;
    }
    else if(_ii == _len){
        prv.actions_Buttons[_ii-1]();
        prv.cols[_ii-1] = merge_color(prv.c_Button, c_white,0.5);
    }
}

value = clamp(value, prv.valueMin, prv.valueMax);