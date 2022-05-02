CHECK_DEBUG_SWITCH

text[0] = "x of obj: " + string(inst_button_debug_light.x);

//WARNING : DO NOT EDIT ALL CODE BELOW
draw_self();
for(var _iLine=0; _iLine<array_length_1d(text); _iLine++;){
    draw_text(x, y +prv.height_Line*_iLine, text[_iLine]);
}