/// @desc 

CHECK_DEBUG_SWITCH

//DO NOT EDIT ALL CODE BELOW:

//prevent time_total < 1
if(prv.time_total<1){ instance_destroy(); return;}

//advance timer;
time_current++;
if(prv.time_total <= time_current){
    TriggerAction();
    instance_destroy();
    return;
}

//calculate datas for drawing
var _progress_Normal = time_current / prv.time_total;
var _angle_Line = lerp(0,360, _progress_Normal);
_angle_Line += 90;  //add 90 degrees for more clearly
var _c_Color_Outline = merge_colour(c_white, c_black, _progress_Normal);

//draw all;
draw_self();

draw_circle_color(x+prv.radius,y+prv.radius,12,_c_Color_Outline,_c_Color_Outline,true);
draw_line_width_color(x+prv.radius,y+prv.radius,x+prv.radius,y, 1, c_black, c_dkgray);

var _dx = lengthdir_x(prv.radius, _angle_Line);
var _dy = lengthdir_y(prv.radius, _angle_Line);
draw_line_width_color(x+prv.radius,y+prv.radius,x+prv.radius+_dx,y+prv.radius+_dy, 1, c_dkgray, c_yellow);

var _text = prv.name + " : " + string(time_current) + " / " + string(prv.time_total);
draw_text(x + 2*prv.radius,y,_text);