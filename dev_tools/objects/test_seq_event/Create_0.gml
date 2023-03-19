/// @desc 
    var _ele = layer_sequence_create(layer, x, y, seq_tachi_default_stage);
    var _seqStruct = layer_sequence_get_instance(_ele);
    //_seqStruct.sequence.event_step = method(_seqStruct.sequence, Mirror_Seq_All_Track);
    _seqStruct.sprite_index = spr_char03;
    _seqStruct.isMirrored = true;
    _seqStruct.name = "trying";
    ele = _ele;
    str = _seqStruct;