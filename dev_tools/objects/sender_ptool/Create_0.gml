/// @desc 
psys = part_system_create();
ptyp_triangle = part_type_create();
spr_create = false;
trigger = false;

psysText = new psysSynth();
var _sprFont = spr_font_SourceCodeVariable_Semibold_48_31x53_mashiro;
var _setting = pSetting_Up;
ptypeCreator = new ptypeText_Creator(_sprFont, _setting);
text = "1000";