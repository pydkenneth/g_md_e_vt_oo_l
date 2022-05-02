/// @desc 
CHECK_DEBUG_SWITCH

//WARNING : DO NOT EDIT ALL CODE BELOW
draw_self();

draw_roundrect_color(x, y, x+prv.widthCheck, y+prv.heightCheck, c_dkgray, c_dkgray, false);

var _c_Check = prv.isStepping ? c_white : c_dkgray;
draw_line_width_color(x+5, y+prv.heightCheck/2, x+prv.widthCheck/3, y+prv.heightCheck*4/5, 4, _c_Check, _c_Check);
draw_line_width_color(x+prv.widthCheck/3, y+prv.heightCheck*4/5, x+prv.widthCheck, y, 1, _c_Check, _c_Check);

draw_text(x+prv.widthCheck,y,prv.name);

var _text = string(period) + " : " + string(prv.stepCurrent);
draw_text(x,y+24, _text);

