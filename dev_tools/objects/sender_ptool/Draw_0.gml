/// @desc 
//if !spr_create
//{
//    spr_create = true;
//    spr = String2Sprite("Errriiiiiiiiiiiiiiiiiiiic",spr_font_SourceCodeVariable_Semibold_48_31x53_mashiro);
//}

//draw_sprite(spr, 1, x, y);
draw_self();

if (trigger == true){
    var _x = x;
    var _y = y;
    Text_Particle_Create(psysText, _x, _y, ptypeCreator, text);
    trigger = false;
    effect_create_above(ef_ring, _x, _y,0,c_red);
}