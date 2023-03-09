CHECK_DEBUG_SWITCH
text[0] = "mousex: " + string(mouse_x);
text[1] = "mousey: " + string(mouse_y);
//WARNING : DO NOT EDIT ALL CODE BELOW
draw_self();
for(var _iLine=0; _iLine<array_length_1d(text); _iLine++;){
    draw_text(x, y +prv.height_Line*_iLine, text[_iLine]);
}