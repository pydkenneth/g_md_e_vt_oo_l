/// @desc 
CHECK_DEBUG_SWITCH
inst_bar_debug.valueCurrent = mouse_x;
inst_bar_debug.prv.valueMin = 0;
inst_bar_debug.prv.valueMax = room_width;

with(inst_button_debug){
    TriggerAction = function(){
        instance_create_layer(x-48, y,"layer_debug_tools", ind_timer_debug);
        return;
    }
}

with(inst_ind_angle_debug){
    angle = point_direction(x, y, mouse_x, mouse_y);
}

with(inst_single_choice_debug){
    Signal = function(){
        instance_create_layer(x-48, y,"layer_debug_tools", ind_timer_debug);
    }
}

with(inst_button_debug_light){
}