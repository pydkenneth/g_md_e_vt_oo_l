//macros for particle type creators
function pSetting_Up(_ptype, _spr){
    part_type_sprite(_ptype, _spr, false, false, false);
    part_type_size(_ptype, 1, 1, -0.01, 0);
    part_type_speed(_ptype, 10, 10, 0, 0);
    part_type_direction(_ptype, 75, 75, 0, 0);
    part_type_orientation(_ptype, 0, 0, 0, 0, false);
    part_type_gravity(_ptype, 0.3, 270);
    part_type_alpha3(_ptype, 1, 0.3, 0);
    part_type_life(_ptype, 60, 60);
    
}

function pSetting_burst_right(_ptype, _spr){
    part_type_sprite(_ptype, _spr, false, false, false);
    part_type_size(_ptype, 1, 1, 0.001, 0);
    part_type_speed(_ptype, 10, 10, -0.3, 0);
    part_type_direction(_ptype, 15, 45, 0, 0);
    part_type_orientation(_ptype, 0, 0, 0, 0, true);
    part_type_alpha3(_ptype, 1, 0.01, 0);
    part_type_life(_ptype, 60, 60);
    
}

function pSetting_move_up(_ptype, _spr){
    part_type_sprite(_ptype, _spr, false, false, false);
    part_type_size(_ptype, 1, 1, 0.001, 0);
    part_type_speed(_ptype, 10, 10, -0.3, 0);
    part_type_direction(_ptype, 90, 90, 0, 0);
    part_type_orientation(_ptype, 0, 0, 0, 0, false);
    part_type_alpha3(_ptype, 1, 0.3, 0);
    part_type_life(_ptype, 60, 60);
    
}