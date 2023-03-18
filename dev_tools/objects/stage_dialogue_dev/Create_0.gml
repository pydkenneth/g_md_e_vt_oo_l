/// @desc 
#region public attributes
idSentence = -1;
sprsTachi = array_create(10);
settingsTachi = array_create(10);
settingsPos = array_create(10);
elementsPos = array_create(10);
#endregion

#region settings
var _wV = view_get_hport(view_current)/10;
XS_TACHI = array_create(10);
XS_TACHI[0] = _wV * 0;
XS_TACHI[1] = _wV * 1;
XS_TACHI[2] = _wV * 2;
XS_TACHI[3] = _wV * 3;
XS_TACHI[4] = _wV * 4;
XS_TACHI[5] = _wV * 5;
XS_TACHI[6] = _wV * 6;
XS_TACHI[7] = _wV * 7;
XS_TACHI[8] = _wV * 8;
XS_TACHI[9] = _wV * 9;
Y_TACHI = 800;
ORDER_DRAW = [0,3,7,2,8,1,9,4,6,5];
IDS_LAYER = array_create(10);//assigned by controller

#macro LAYER_DEFAULT_STAGE 9
#macro MIRROR_DEFAULT_STAGE false
#macro SEQ_DEFAULT_STAGE seq_tachi_default_stage
#endregion

#region public methods
function Clear_Stage(){
    sprsPos = array_create(10);
    settingsPos = array_create(10);
    Clear_Mannequins();
    elementsPos = array_create(10);
}

function Set_Layers(_idsLayer){
    IDS_LAYER = _idsLayer;
}

function Set_Stage(_id, _tachis, _settings){
    Check_Layers_Stage_Exist();
    Clear_Stage();
    idSentence = real(_id);
    sprsTachi = _tachis;
    settingsTachi = _settings;
    Tachi_To_Pos();
    Set_Mannequins();
}

#endregion

#region private attributes

#endregion

#region private methods
function Clear_Mannequins(){
    var _len = array_length(IDS_LAYER);
    for(var _iLayer=0; _iLayer < _len; _iLayer++){
        Clear_Layer_Element(IDS_LAYER[_iLayer]);
    }
}

function settingPos(_idSentence, _iTachi, _ss=["","",""]) constructor{
    orderLayer = LAYER_DEFAULT_STAGE;
    needMirror = MIRROR_DEFAULT_STAGE;
    seq = SEQ_DEFAULT_STAGE;
    
    var _len = array_length(_ss);
    switch(_len){
    default:
        show_error("Err: invalid length of setting", true);
    case 0:
        return;
    case 3:
        //deal with seq
        if(_ss[2] == ""){}
        else{
            var _a = asset_get_index(_ss[2]);
            if((_a == -1)||(asset_sequence != asset_get_type(_a))){
                show_error("Err: invalid seq, " + "sentence id: " + string(_idSentence) + ", tachi: " + string(_iTachi), true);
            }
            else{
                seq = _a;
            }
        }
    case 2:
        //deal with needMirror
        if(_ss[1] == ""){}
        else{
            switch(_ss[1]){
            case "":
            case "N":
            case "n":
                needMirror = false;
                break;
            case "M":
            case "m":
                needMirror = true;
                break;
            default:
                show_error("Err: illegal setting for needMirror, " + "sentence id: " + string(_idSentence) + ", Tachi: " + string(_iTachi),true);
            }
        }
        /*
        var _m = bool(real(_ss[1]));
        if(is_bool(_m)){
            needMirror = _m;
        }
        else{
            show_error("Err: illegal setting for needMirror, " + "sentence id: " + string(_idSentence) + ", Tachi: " + string(_iTachi),true);
        }
        */
    case 1:
        //deal with layer
        var _layer = floor(real(_ss[0]));
        if((1<= _layer)&& (_layer <=9)){
            orderLayer = _layer;
        }
        else{
            show_error("Err: illegal layer number, " + "sentence id: " + string(_idSentence) + ", Tachi: " + string(_iTachi),true);
        }
        break;
    }
}

function Check_Layers_Stage_Exist(){
    for(var _i=0; _i<=9; _i++){
        if(-1 == IDS_LAYER[_i]){
            show_error("Err: invalid layer id," + string(IDS_LAYER[_i]),true);
        }
    }
}

function Tachi_To_Pos(){
    var _ss = array_create();
    var _a;
    for (var _i = 1; _i<=9; _i++){
        if(0 == string_length(sprsTachi[_i])){
            //sprsPos = -1;
            continue;
        }
        
        _a = asset_get_index(sprsTachi[_i]);
        if((_a == -1)||(asset_sprite != asset_get_type(sprsTachi[_i]))){
            Show_Error("Err: invalid sprite, " + "sentence id: " + string(idSentence) + ", tachi: " + string(_i),true);
        }
        
        sprsPos[_i] = _a;
        if(0 == string_length(settingsTachi[_i])){
            settingsPos[_i] = new settingPos(idSentence,_i);
        }
        else{
            _ss = string_split(settingsTachi[_i]," ");
            settingsPos[_i] = new settingPos(idSentence,_i, _ss);
        }
    }
}

function Set_Mannequins(){
    var _spr, _setting, _seq;
    for(var _i = 1; _i<=9; _i++){
        _spr = sprsPos[_i];
        if(_spr == -1){continue;}
        if(!sprite_exists(_spr)){show_error("Err: invalid spr",true);}
        
        _setting = settingsPos[_i];
        if(!is_struct(_setting)){continue;}
        _seq = _setting.seq;
        if(_seq == -1){continue;}
        if(!sequence_exists(_seq)){continue;}
        elementsPos[_i] = layer_sequence_create(IDS_LAYER[_setting.orderLayer], XS_TACHI[_i], Y_TACHI, _seq);
        Change_Seq_Obj_Sprite(elementsPos[_i], _spr);
    }
}
#endregion



#region initial


#endregion