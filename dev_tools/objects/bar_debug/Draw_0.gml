/// @desc 

//DO NOT EDIT ALL CODE BELOW:

CHECK_DEBUG_SWITCH
//compute bar length
valueCurrent = clamp(valueCurrent, prv.valueMin, prv.valueMax);
var _x = (valueCurrent-prv.valueMin) / (prv.valueMax-prv.valueMin) * prv.width;

//draw all
draw_self();
draw_roundrect_color_ext(x,y,x+prv.width,y+prv.height, 5,5,prv.c_Frame, prv.c_Frame, false);
draw_rectangle_color(x,y+(prv.height/10),x+_x,y+prv.height,prv.c_Bar,prv.c_Bar,prv.c_Bar,prv.c_Bar,false);

var _text = prv.name + " : " + string(valueCurrent);
draw_text(x,y,_text);