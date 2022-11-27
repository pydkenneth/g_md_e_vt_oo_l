/// @desc 
#region public vars
isEnabled = false;
alignX = "LEFT";//LEFT, MIDDLE, RIGHT
alignY = "BENEATH";//ABOVE, MIDDLE, BENEATH

psysText = new psysSynth();
var _sprFont = spr_font_SourceCodeVariable_Semibold_48_31x53_mashiro;
var _setting = pSetting_move_up;
ptypeCreator = new ptypeText_Creator(_sprFont, _setting);

#endregion

#region public functions
function Emit(_text){
    var _wString = sprite_get_width(ptypeCreator.spr) * string_length(_text);
    var _yString = sprite_get_height(ptypeCreator.spr);
    var _xBias=0; var _yBias=0;
    switch(alignX){
        case "LEFT":
            _xBias = 0;break;
        default:    //fallthrough
        case "MIDDLE":
            _xBias = -_wString/2;break;
        case "RIGHT":
            _xBias = -_wString;break;
    }
    switch(alignY){
        default://fallthrough
        case "ABOVE":
            _yBias = -_yString;break;
        case "MIDDLE":
            _yBias = -_yString/2;break;
        case "BENEATH":
            _yBias=0;break;
    }

    Text_Particle_Create(psysText, x + _xBias, y + _yBias, ptypeCreator, _text);
    effect_create_above(ef_spark, x + _xBias, y + _yBias,0.1,c_yellow);
//    Text_Particle_Create(psysText, x, y, ptypeCreator, _text);
}
#endregion

