//How to use particle tool:
//1.create "psysSynth" in create event. And psysSynth.psys can be adjusted with GM part_system_xxx funcitons.
//2.create "ptypeText_Creator" in create event
//3.In step event, call "Recycle_Psys_Synth(...)" for preventing memory leak.
//4.In draw event, call "Text_Particle_Create(...)" when you need it.
//NOTE: Call Text_Particle_Create too fast may cause performance issue.

//WARNING: DO NOT EDIT CODE BELOW
function psysSynth() constructor{
    psys = part_system_create();
    ptypesPlaying = array_create();//private
    sprsSynth = array_create();//private
    function Particle_Create(_x,_y,_ptype){
        part_particles_create(psys,_x,_y,_ptype,1);
        var _index = array_length(ptypesPlaying);
        array_insert(ptypesPlaying, _index, _ptype);
        return;
    }
    function AddSprPlaying(_spr){
        array_push(sprsSynth, _spr);
    }
}

function ptypeText_Creator(_spr, _setting) constructor{
    spr = _spr;
    setting = _setting;
    function create(_text){
        var _ptype = part_type_create();
        var _sprSynth = String2Sprite(_text, spr);
        setting(_ptype,_sprSynth);
        return [_ptype, _sprSynth];
    }
}

function Text_Particle_Create(_psysText, _x, _y, _ptypeText_Creator, _text){
    var _config = _ptypeText_Creator.create(_text);
    var _ptype = _config[0]; var _sprSynth = _config[1];
    _psysText.Particle_Create(_x, _y, _ptype);
    _psysText.AddSprPlaying(_sprSynth);
}

//Clear dynamic particle types, dynamic sprite for preventing memory leak
function Recycle_Psys_Synth(_psysSynth){
    var _MAX_LENGTH = 120;//maximum amount of dynamic sprites
    var _count = part_particles_count(_psysSynth.psys);
    var _len = array_length(_psysSynth.ptypesPlaying);
    
    if((_count == 0)&&(_len == 0)){return;}

    if (_count < _len){//some particles has finished playing
        for (var _i = _len-_count; _i > 0; _i--){
            part_type_destroy(_psysSynth.ptypesPlaying[0]);
            array_delete(_psysSynth.ptypesPlaying, 0, 1);
            sprite_delete(_psysSynth.sprsSynth[0]);
            array_delete(_psysSynth.sprsSynth, 0, 1);
        }
    }
    else if(_MAX_LENGTH <=_len){//prevent user calling too fast
        var _len = array_length(_psysSynth.ptypesPlaying);
        for (var _i = _len-(_MAX_LENGTH/2); _i >= 0; _i--){
            part_type_destroy(_psysSynth.ptypesPlaying[0]);
            array_delete(_psysSynth.ptypesPlaying, 0, 1);
            sprite_delete(_psysSynth.sprsSynth[0]);
            array_delete(_psysSynth.sprsSynth, 0, 1);
        }
    }
}