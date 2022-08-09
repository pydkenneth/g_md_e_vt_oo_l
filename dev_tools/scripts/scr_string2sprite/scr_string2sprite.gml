function String2Sprite(_str, _sprAsset){
    var _len = string_length(_str);
    var _h_char = sprite_get_height(_sprAsset);
    var _w_char = sprite_get_width(_sprAsset);
    var _surface_synth = surface_create(_w_char*_len,_h_char);
    surface_set_target(_surface_synth);
    
    var _c, _uni, _subimage;
    for(var _i=1;_i<=_len;_i++;){
        _c = string_char_at(_str, _i);
        _subimage = ord(_c)-32;//from unicode
        draw_sprite(_sprAsset, _subimage, (_i-1)*_w_char,0);
    }
    
    var _sprite_synth = sprite_create_from_surface(_surface_synth, 0, 0, _w_char*_len, _h_char, true, false, 0, 0);
    draw_clear_alpha(c_black,0);
    surface_reset_target();
    
    surface_free(_surface_synth);
    return _sprite_synth;
}