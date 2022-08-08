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

function psysSynth() constructor{
    psys = part_system_create();
    ptypesPlaying = array_create();
    function Particle_Create(_x,_y,_ptype){
        part_particles_create(psys,_x,_y,_ptype,1);
        var _index = array_length(ptypesPlaying);
        array_insert(ptypesPlaying, _index, _ptype);
        return;
    }
}

function ptypeText_Creator(_spr, _setting) constructor{
    spr = _spr;
    setting = _setting;
    function create(_text){
        var _ptype = part_type_create();
        var _sprSynth = String2Sprite(_text, spr);
        setting(_ptype,_sprSynth);
        return _ptype;
    }
}

function Text_Particle_Create(_psysText, _x, _y, _ptypeText_Creator, _text){
    var _ptype = _ptypeText_Creator.create(_text);
    _psysText.Particle_Create(_x, _y, _ptype);
}

function Recycle_Psys_Synth(_psysSynth){
    if(part_particles_count(_psysSynth) != 0){return;}
    var _len = array_length(_psysSynth.ptypesPlaying);
    for (var _i = _len-1; _i >= 0; _i--){
            part_type_destroy(_psysSynth.ptypesPlaying[_i]);
            array_delete(_psysSynth.ptypesPlaying, _i, 1);
    }
    part_system_clear(_psysSynth.psys);
}