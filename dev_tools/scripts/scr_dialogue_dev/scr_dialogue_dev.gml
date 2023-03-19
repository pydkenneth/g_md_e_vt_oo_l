function Layer_Sequence_Tachi_Create(_layer, _x, _y, _sequenceId, _spr, _isMirrored){
    var _ele = layer_sequence_create(_layer, _x, _y, _sequenceId);
    var _seqStruct = layer_sequence_get_instance(_ele);
    _seqStruct.sequence.event_step = method(_seqStruct.sequence, Mirror_Seq_All_Track);
    _seqStruct.sprite_index = _spr;
    _seqStruct.isMirrored = _isMirrored;
    _seqStruct.stage = id;

    var _k = array_create(1);
    _k[0] = sequence_keyframe_new(seqtracktype_moment);
    _k[0].frame = 0;
    var _d = array_create(1);
    _d[0] = sequence_keyframedata_new(seqtracktype_moment);
    _d[0].channel = 0;
    _d[0].event = method(_d[0], Event_0_Seq_Tachi);
    _k[0].channels = _d;
    _seqStruct.sequence.momentKeyframes = _k;
    global.seqStruct = _seqStruct;
    return _ele;
}

function Event_0_Seq_Tachi(){
    Seq_Switch_Sprite();
    stage.Clear_Elements_Old();
}

function Seq_Switch_Sprite(){
    //NOTICE: we have to wait 1st frame of seq, because when seq is created, instances on tracks are not created yet.
    if(!variable_struct_exists(self,"sprite_index")){return;}

    var _type = self.sequence.tracks[0].type;
    if(_type == seqtracktype_instance){
        var _inst = self.activeTracks[0].instanceID;
        _inst.sprite_index = sprite_index;
    }
    else{
        show_error("Err: track type is no instance track.", true);
    }
}

function Mirror_Seq_All_Track(){
    //desc Let seq to mirror by self according to isMirrored.
    if(!variable_struct_exists(self,"isMirrored")||!isMirrored){
        return;
    }

    var _x = layer_sequence_get_x(elementID);
    var _activeTracks = self.activeTracks;
    var _trackCount = array_length(_activeTracks);
    var _inst, _type;
    
    if(!self.finished){
        for(var _i=0; _i<_trackCount; _i++){
            _type = self.sequence.tracks[_i].type;
            if(_type == seqtracktype_graphic){
                _activeTracks[_i].scalex *= -1;
                _activeTracks[_i].posx *= -1;
                _activeTracks[_i].rotation *= -1;
            }
            else if(_type == seqtracktype_instance){
                _inst = _activeTracks[_i].instanceID;
                _inst.x = _x - self.activeTracks[_i].posx;
                _inst.image_xscale = -self.activeTracks[_i].scalex;
                _inst.image_angle = -self.activeTracks[_i].rotation;
            }
        }
    }
    else{
        if(!self.paused){
            #region Explaination
            /* Because When seq is finished, GM will not update active track anymore,
            we don't need to inverse scalex, pos, rotation by every frame after seq element is finished.
            Another fact is that "finished" is NOT equal to "paused",
            so "paused" can be used as a flag to indicate whether active tracks had been mirrored at the final position,
            and no need to create a "mirrored flag" for every finished seq element. */
            #endregion
            layer_sequence_pause(elementID);
            for(var _i=0; _i<_trackCount; _i++){
                _type = self.sequence.tracks[_i].type;
                if(_type == seqtracktype_graphic){
                    _activeTracks[_i].scalex *= -1;
                    _activeTracks[_i].posx *= -1;
                    _activeTracks[_i].rotation *= -1;
                }
                else if(_type == seqtracktype_instance){
                    _inst = _activeTracks[_i].instanceID;
                    _inst.x = _x - self.activeTracks[_i].posx;
                    _inst.image_xscale = -self.activeTracks[_i].scalex;
                    _inst.image_angle = -self.activeTracks[_i].rotation;
                }
            }
        }
    }

    //if(self.finished && self.paused){
    //    show_debug_message("seq is finished & paused");
    //}
}