/// @desc 

#region settings for layers & depth
depthDialogue = -3000;
depth = depthDialogue;
depthCg = depthDialogue;
depthFrameBottom  = depthDialogue-5;
depthLayer9Tachi = depthDialogue-10;
depthLayer8Tachi = depthDialogue-20;
depthLayer7Tachi = depthDialogue-30;
depthLayer6Tachi = depthDialogue-40;
depthLayer5Tachi = depthDialogue-50;
depthLayer4Tachi = depthDialogue-60;
depthLayer3Tachi = depthDialogue-70;
depthLayer2Tachi = depthDialogue-80;
depthLayer1Tachi = depthDialogue-90;
depthLayer0Tachi = depthDialogue-100;

depthTextBox = depthDialogue-110;
depthCharNameBox = depthDialogue-111;
depthText = depthDialogue-112;

depthFrameTop = depthDialogue-115;
depthButtons = depthDialogue-120;
depthDebug = depthDialogue-121;

layerCg = layer_create(depthDialogue);
layerTextBoxDialogue = layer_create(depthTextBox);
layerCharNameBoxDialogue = layer_create(depthCharNameBox);
layerText = layer_create(depthText);
layerButtons = layer_create(depthButtons);

layersTachi = array_create();
layersTachi[9] = layer_create(depthLayer9Tachi);
layersTachi[8] = layer_create(depthLayer8Tachi);
layersTachi[7] = layer_create(depthLayer7Tachi);
layersTachi[6] = layer_create(depthLayer6Tachi);
layersTachi[5] = layer_create(depthLayer5Tachi);
layersTachi[4] = layer_create(depthLayer4Tachi);
layersTachi[3] = layer_create(depthLayer3Tachi);
layersTachi[2] = layer_create(depthLayer2Tachi);
layersTachi[1] = layer_create(depthLayer1Tachi);
layersTachi[0] = layer_create(depthLayer0Tachi);


#endregion

#region dynamic datas, DO NOT EDIT
elementCg = -1;//sprite element id
dialogueCurrent = {};//current dialogue sentence & settings
#endregion

function Set_Dialogue(_filename = "dialogue.csv"){//public
    dialogue = load_csv(_filename);
    return;
}

Reload = function(_filename = "dialogue.csv"){//public
    if(variable_instance_exists(id, "dialogue")){
        ds_grid_destroy(dialogue);
        dialogue = -1;
    }

    Set_Dialogue(_filename);
    effect_create_above(ef_ellipse,x,y,1,c_yellow);
}

Check_Csv = function(){
    
}

Play = function(_idDialogue){//public
    if(!is_numeric(_idDialogue)){show_error("Err: Invalid idDialogue",true);}
    dialogueCurrent = Get_Dialogue(_idDialogue);
    Set_Cg(dialogueCurrent.cg);
    //Set_Frame(sprFrame);
    //Play_VFX(dialogueCurrent.vfx);
    //Play_SFX(dialogueCurrent.sfx);
    Set_Printer();
    
    stage.Set_Stage(dialogueCurrent.id,dialogueCurrent.tachis,dialogueCurrent.settings);
    //cmd.Do(dialogueCurrent.cmd);
}

Play_Next = function(){
    if(dialogueCurrent.id == undefined){show_error("Err: Invalid idDialogue",true);}
    var _idDialogue = real(dialogueCurrent.id);
    _idDialogue++;
    Play(_idDialogue);
}

Get_Dialogue = function(_idDialogue){//private
    var _w = ds_grid_width(dialogue);
    var _h = ds_grid_height(dialogue);
    var _y = ds_grid_value_y(dialogue, 0, 0,_w-1,_h-1,_idDialogue);
    var _str = {};
    //Check_Dialogue_Validation(_y);
    _str.id = dialogue[# 0, _y];
    _str.tachis = array_create();
    _str.settings = array_create();
    _str.tachis[1] = dialogue[# 1, _y];
    _str.settings[1] = dialogue[# 2, _y];
    _str.tachis[2] = dialogue[# 3, _y];
    _str.settings[2] = dialogue[# 4, _y];
    _str.tachis[3] = dialogue[# 5, _y];
    _str.settings[3] = dialogue[# 6, _y];
    _str.tachis[4] = dialogue[# 7, _y];
    _str.settings[4] = dialogue[# 8, _y];
    _str.tachis[5] = dialogue[# 9, _y];
    _str.settings[5] = dialogue[# 10, _y];
    _str.tachis[6] = dialogue[# 11, _y];
    _str.settings[6] = dialogue[# 12, _y];
    _str.tachis[7] = dialogue[# 13, _y];
    _str.settings[7] = dialogue[# 14, _y];
    _str.tachis[8] = dialogue[# 15, _y];
    _str.settings[8] = dialogue[# 16, _y];
    _str.tachis[9] = dialogue[# 17, _y];
    _str.settings[9] = dialogue[# 18, _y];
    _str.cg = dialogue[# 19, _y];
    _str.vfx = dialogue[# 20, _y];
    _str.sfx = dialogue[# 21, _y];
    _str.speaker = dialogue[# 22, _y];
    _str.dialogueContent = dialogue[# 23, _y];
    _str.showByAlphabet = dialogue[# 24, _y];
    _str.cmd = dialogue[# 25, _y];
    return _str;
}

function Check_Dialogue_Validation(_y){
    var _str;
    _str.id = dialogue[# 0, _y];
    _str.tachis = array_create();
    _str.settings = array_create();
    _str.tachis[1] = dialogue[# 1, _y];
    _str.settings[1] = dialogue[# 2, _y];
    _str.tachis[2] = dialogue[# 3, _y];
    _str.settings[2] = dialogue[# 4, _y];
    _str.tachis[3] = dialogue[# 5, _y];
    _str.settings[3] = dialogue[# 6, _y];
    _str.tachis[4] = dialogue[# 7, _y];
    _str.settings[4] = dialogue[# 8, _y];
    _str.tachis[5] = dialogue[# 9, _y];
    _str.settings[5] = dialogue[# 10, _y];
    _str.tachis[6] = dialogue[# 11, _y];
    _str.settings[6] = dialogue[# 12, _y];
    _str.tachis[7] = dialogue[# 13, _y];
    _str.settings[7] = dialogue[# 14, _y];
    _str.tachis[8] = dialogue[# 15, _y];
    _str.settings[8] = dialogue[# 16, _y];
    _str.tachis[9] = dialogue[# 17, _y];
    _str.settings[9] = dialogue[# 18, _y];
    _str.cg = dialogue[# 19, _y];
    _str.vfx = dialogue[# 20, _y];
    _str.sfx = dialogue[# 21, _y];
    _str.speaker = dialogue[# 22, _y];
    _str.dialogueContent = dialogue[# 23, _y];
    _str.showByAlphabet = dialogue[# 24, _y];
    _str.cmd = dialogue[# 25, _y];
}

Set_Cg = function(_nameSprite){//private
    if(_nameSprite =""){
        //dont change
    }
    else if(_nameSprite = "clear"){
        layer_set_visible(layerCg, false);
    }
    else{
        var _spr = asset_get_index(_nameSprite);
        if(_spr == -1|| (!sprite_exists(_spr))){
            show_debug_message("Err: invalid sprite name");
            layer_set_visible(layerCg, false);
        }
        else{
            Clear_Layer_Element(layerCg);
            layer_sprite_create(layerCg,0,0,_spr);
            layer_set_visible(layerCg, true);
        }
    }

}

Set_Frame = function(){
    Clear_Layer_Element(strFrameDialogue.layer, layerelementtype_sprite);
    layer_sprite_create(strFrameDialogue.layer,strFrameDialogue.x,strFrameDialogue.y,strFrameDialogue.spr);
    layer_set_visible(strFrameDialogue.layer, true);
}

Set_Printer = function(){
    printer.Clear_Sentence();
    printer.speaker = dialogueCurrent.speaker;
    printer.Set_Sentence(dialogueCurrent.dialogueContent) ;
    printer.showByAlphabet = dialogueCurrent.showByAlphabet;
    printer.Play_Typewriting();
    if(!printer.isOpened){printer.Open();}
}


#region initialization
buttonSkip = instance_create_layer(1140,600,layerButtons,button_skip_dialogue_dev);
buttonSkip.ActionReleased = Play_Next;

printer = instance_create_layer(x,y,layerText,printer_dialogue_dev);
printer.layerTextBoxDialogue = layerTextBoxDialogue;
printer.layerCharNameBoxDialogue = layerCharNameBoxDialogue;

stage = instance_create_depth(x, y, depthLayer9Tachi, stage_dialogue_dev);
stage.Set_Layers(layersTachi);

Set_Dialogue("dialogue.csv");
Play(1);


#endregion