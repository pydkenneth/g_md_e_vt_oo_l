/// @desc 
CHECK_DEBUG_SWITCH

//WARNING : DO NOT EDIT ALL CODE BELOW
//draw_self
var _iDigit = 1;
for (_iDigit =1; _iDigit <= prv.digit; _iDigit++){
    draw_sprite(sprite_index, image_index,x+sprite_width*(_iDigit-1),y);
}

var _w = sprite_width, _h =sprite_height;
if(Detect_Mouse_Area()){
    //detect which digit mouse stays
    var _digitMouse = Detect_Digit_Mouse();
    if(_digitMouse != 0){
        draw_roundrect(x+_w*(prv.digit -_digitMouse+1),y,x+_w*(prv.digit-_digitMouse),y+_h,true);
    }
    
    if(_digitMouse == prv.digit_dec_point){
        //skip the dec point
    }
    else if(mouse_wheel_up()   //if mouse wheel up, increase the digit
    ||((mouse_check_button_pressed(mb_left))&& (mouse_y < y+sprite_height/2))){ //if mouse click up half, increase the digit
        Increase_Digit(_digitMouse);
    }
    else if(mouse_wheel_down()  //if mouse wheel down, decrease the digit
    ||((mouse_check_button_pressed(mb_left))&& (y+sprite_height/2 < mouse_y))){ //if mouse click down half, decrease the digit
        Decrease_Digit(_digitMouse);
    }
}


//draw value
draw_set_font(fnt_consolas_32pt);
draw_set_halign(fa_right);

draw_text(x,y,prv.name);

//locate dec point
//prv.digit_dec_point;
var _textDecPoint ="";
if(1 < prv.digit_dec_point){
    _textDecPoint = ".";
}

var _posDecPoint = string_pos(".", string(value));
var _numZeros = 0; var _textZeros = "";
//get text lefter from dec point
var _textLeft = string_copy(string(value), 1, (1<_posDecPoint?_posDecPoint-1:string_length(string(value))));
var _lenTextLeft = string_length(_textLeft);

if (prv.digit_dec_left < _lenTextLeft){  //if too long, truncate
    _textLeft = string_copy(_textLeft, _lenTextLeft-prv.digit_dec_left+1, _lenTextLeft);
}
else if(_lenTextLeft < prv.digit_dec_left){  //if too short, push zeros
    _numZeros = prv.digit_dec_left - _lenTextLeft;  //calc how many zeros needed
    _textZeros = string_repeat("0", _numZeros); //generate zeros
    _textLeft = string_insert(_textZeros, _textLeft, 0); //push zeros to string
}
else{}

//get text righter from dec point
var _textRight = string_copy(string(value), _posDecPoint+1, (1<_posDecPoint?string_length(string(value)):0))
var _lenTextRight = string_length(_textRight);
if(prv.digit_dec_right < _lenTextRight){  //if too long, truncate
    _textRight = string_copy(_textRight, 1, prv.digit_dec_right);
}
else if(_lenTextRight < prv.digit_dec_right){  //if too short, push zeros
    _numZeros = prv.digit_dec_right - _lenTextRight;
    _textZeros = string_repeat("0", _numZeros);
    _textRight = string_insert(_textZeros, _textRight, 0);
}
else{}
prv.textValue = _textLeft+_textDecPoint+_textRight

draw_text(x + sprite_width*prv.digit, y, prv.textValue);

draw_set_halign(fa_left);

if(value == prv.valueMax){
    draw_line_color(x,y,x+_w*prv.digit,y,c_red,c_yellow);
}
else if(value == prv.valueMin){
    draw_line_color(x,y+_h,x+_w*prv.digit,y+_h,c_red,c_yellow);
}

//Reset Button
draw_set_color(c_dkgray);
draw_roundrect(x+_w*(prv.digit),y,x+_w*(prv.digit+1),y+_h,false);
if((x + _w*prv.digit < mouse_x)&&(mouse_x < x + _w*(prv.digit+1))
&&(y < mouse_y)&&(mouse_y < y+_h)
){   //mouse in R
    draw_set_color(c_white);
    draw_roundrect(x+_w*(prv.digit),y,x+_w*(prv.digit+1),y+_h,true);
    if(mouse_check_button_pressed(mb_left)){
        value = clamp(prv.valueDefault,prv.valueMin, prv.valueMax);
        
    }
}
else{}
draw_text(x + _w*prv.digit,y,"R");

Draw_Reset();
draw_set_font(fnt_default);