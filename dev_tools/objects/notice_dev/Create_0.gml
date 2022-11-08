/// @desc 
#region public vars
isEnabled = false;

psysText = new psysSynth();
var _sprFont = spr_font_SourceCodeVariable_Semibold_48_31x53_mashiro;
var _setting = pSetting_move_up;
ptypeCreator = new ptypeText_Creator(_sprFont, _setting);

#endregion

#region public functions
function Emit(_text){
    Text_Particle_Create(psysText, x, y, ptypeCreator, _text);
}
#endregion

