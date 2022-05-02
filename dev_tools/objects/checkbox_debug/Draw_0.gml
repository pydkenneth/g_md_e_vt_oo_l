/// @desc 
CHECK_DEBUG_SWITCH

//WARNING : DO NOT EDIT ALL CODE BELOW

//if this is clicked, update 
if(mouse_check_button_pressed(mb_left)
    &&(x <= mouse_x) && ( mouse_x <= x + prv.width)
    &&(y <= mouse_y) && ( mouse_y <= y + prv.height)
){
    isChecked = !isChecked;
}

//draw all
draw_self();

var _c_Checkbox = (isChecked == true) ? (prv.c_Checked) : prv.c_NotChecked;
draw_roundrect_color_ext(x, y, x+prv.width, y+prv.height, 10, 10, _c_Checkbox, _c_Checkbox, false);
draw_roundrect_color_ext(x, y, x+prv.width, y+prv.height, 10, 10, c_white, c_white, true);

if(isChecked == true){
    draw_line_width_color(x+(prv.width/4), y+(prv.height/2), x+(prv.width/2), y+(prv.height*3/4), 4, c_white, c_white);
    draw_line_width_color(x+(prv.width/2), y+(prv.height*3/4), x+prv.width, y, 1, c_white, c_green);
}

draw_text(x + prv.width,y,prv.text);

//call slot function
if(isChecked){TriggerAction();}