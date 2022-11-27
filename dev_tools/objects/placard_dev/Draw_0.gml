/// @desc 
if(!isEnable){return;}

draw_self();

var _fontCurrent = draw_get_font();

draw_set_font(font);
//align...
var _wString = string_width(text);
var _yString = string_height(text);
var _xBias,_yBias;

switch(alignX){
    case "LEFT":
        _xBias = 0;break;
    default:    //fallthrough
    case "MIDDLE":
        _xBias = -_wString/2;break;
    case "RIGHT":
        _xBias = -_wString;break;
}
switch(alignY){
    default://fallthrough
    case "ABOVE":
        _yBias = -_yString;break;
    case "MIDDLE":
        _yBias = -_yString/2;break;
    case "BENEATH":
        _yBias=0;break;
}

draw_text(x+_xBias,y+_yBias,text);

draw_set_font(_fontCurrent);//reset font