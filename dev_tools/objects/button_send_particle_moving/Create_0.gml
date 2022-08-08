/// @desc 

//test text particles
psysText = new psysSynth();
part_system_depth(psysText, depth-4);
var _sprFont = spr_font_SourceCodeVariable_Semibold_48_31x53_mashiro;
var _setting = pSetting_move_up;
ptypeCreator = new ptypeText_Creator(_sprFont, _setting);
text = "1000";

//public attributes
isPressed = false;  //read only

//triggered when (isPressed == true)
TriggerAction = function(){ 
    var _x = x;
    var _y = y;
    Text_Particle_Create(psysText, _x, _y, ptypeCreator, text);
    effect_create_above(ef_ring, _x, _y,0,c_red);

    return;
}

prv = {
    toggle : 0, //DO NOT EDIT
    push_button : 1, //DO NOT EDIT
    
    //USER DEFINE STYLE:
    typeButton : 1, //0:toggle, 1:pushbutton
    width : 96,
    height : 48,
    c_NotPressed : c_green,
    name : "MOVING_TEXT"//object_get_name(object_index)
}