/// @desc 
CHECK_DEBUG_SWITCH

//WARNING : DO NOT EDIT ALL CODE BELOW
draw_self();

for(var _i=0; _i<array_length(prv.xposs); _i++){
    if(_i == 3){
        Draw_Middle();
        continue;
    }
    Draw_Button(prv.xposs[_i],y,prv.texts[_i],prv.cols[_i]);
    prv.cols[_i] = prv.c_Button; //reset all button color
}

