/// @desc 
Close_And_Send();
ReceivingInput();

draw_set_color(prv.c_Self);
draw_rectangle(prv.posSelf[0], prv.posSelf[1], prv.posSelf[2], prv.posSelf[3], false);
draw_set_color(prv.c_Outline);
draw_roundrect(prv.posSelf[0], prv.posSelf[1], prv.posSelf[2], prv.posSelf[3], true);
draw_set_color(c_white);

draw_set_valign(fa_middle);
draw_text(prv.posSelf[0], prv.posSelf[1] + prv.height/2, stringEntering);

Draw_Reset();