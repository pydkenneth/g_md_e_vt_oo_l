/// @desc 


if(State_OpenClose == CmdOpened){
    draw_rectangle_colour(x, y, x+room_width, y+sprite_height, c_dkgray, c_dkgray, c_dkgray, c_black, false);
    draw_self();
    draw_text_color(x+sprite_width,y,stringEntering,c_white,c_white,c_white,c_white,1);
}
if(!(Cmd_Draw == -1)){
    Cmd_Draw(); Cmd_Draw = -1;
}
