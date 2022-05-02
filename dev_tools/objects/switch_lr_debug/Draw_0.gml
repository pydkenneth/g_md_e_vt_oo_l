/// @desc 
var _posMouse = Detect_Mouse();

//draw shape of switch
draw_set_color(c_dkgray);
draw_rectangle(x, y, x+sprite_width, y+sprite_height, false);
var _w2 = sprite_width/2;
draw_line_width_color(x+_w2+(_w2/4), y+(sprite_height/2), x+_w2+(_w2/2), y+(sprite_height*3/4), 4, c_white, c_white);
draw_line_width_color(x+_w2+(_w2/2), y+(sprite_height*3/4), x+_w2+_w2, y, 1, c_white, c_gray);
draw_line_width_color(x, y, x+_w2, y+sprite_height, 1, c_white, c_gray);
draw_line_width_color(x+_w2, y, x, y+sprite_height, 1, c_white, c_gray);
Draw_Reset();

//darken the side of not pressed
if(value == true){
    draw_set_colour(c_black);
    draw_set_alpha(0.75);
    draw_rectangle(x,y,x+sprite_width/2,y+sprite_height, false);
}
else if(value == false){
    draw_set_colour(c_black);
    draw_set_alpha(0.75);
    draw_rectangle(x+sprite_width/2,y,x+sprite_width,y+sprite_height, false);
}
Draw_Reset();

//draw frame while mouse in
draw_set_colour(c_yellow);
switch(_posMouse){
case 0:
    draw_roundrect(x,y,x+sprite_width/2,y+sprite_height, true);
    break;
case 1:
    draw_roundrect(x+sprite_width/2,y,x+sprite_width,y+sprite_height, true);
    break;
}

Draw_Reset();