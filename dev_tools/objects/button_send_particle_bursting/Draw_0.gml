/// @desc 
CHECK_DEBUG_SWITCH

//WARNING : DO NOT EDIT ALL CODE BELOW:

if(prv.typeButton == prv.push_button){
    isPressed = false;
}

//if button is clicked, update 
if(mouse_check_button_pressed(mb_left)
    &&(x <= mouse_x) && ( mouse_x <= x + prv.width)
    &&(y <= mouse_y) && ( mouse_y <= y + prv.height)
){
    isPressed = !isPressed;
}

//draw all
draw_self();

var _c_button = (isPressed == true) ? (prv.c_NotPressed + c_gray) : prv.c_NotPressed;
draw_roundrect_color_ext(x,y,x+prv.width,y+prv.height, 10, 10, _c_button, _c_button, false);

draw_text(x,y,prv.name);

//call slot function
if(isPressed){TriggerAction();}
