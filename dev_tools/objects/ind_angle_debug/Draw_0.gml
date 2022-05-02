/// @desc 

CHECK_DEBUG_SWITCH

//DO NOT EDIT :
var _angle = angle;
var _dx = lengthdir_x(prv.radius, _angle);
var _dy = lengthdir_y(prv.radius, _angle);

draw_self();
draw_circle_color(x+prv.radius,y+prv.radius,prv.radius,c_dkgray, c_dkgray, true);
draw_line_color(x+prv.radius, y+prv.radius, x+prv.radius+_dx, y+prv.radius+_dy, prv.c_Pointer, prv.c_Pointer);
draw_text(x+2*prv.radius,y,string(_angle));