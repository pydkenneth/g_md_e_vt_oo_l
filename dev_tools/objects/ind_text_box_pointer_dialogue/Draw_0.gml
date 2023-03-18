/// @desc 
draw_self();

var _w = view_get_wport(view_current);
x = _w/2 + ((mouse_x - _w/2)/2);
var _ang;
_ang = point_direction(x, y, mouse_x, mouse_y);

image_xscale = 1 + abs(dcos(image_angle)/2);
image_angle = _ang;


var _x = camera_get_view_width(0)/2;
Draw_Cross(_x,y-150);

draw_text(_x,y-150,string(image_angle));