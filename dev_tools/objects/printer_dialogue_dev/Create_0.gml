/// @desc 
#region settings for printer, modify after new one

widthSentence = 700;
heightSentence = 300;
spdTypewriting = 3;//unit:alphabets per sec
halign = fa_left;
valign = fa_top;
showByAlphabet = true;
autowrap = true;
sndWriting = false;

xTextBox = view_get_wport(0)/2;
yTextBox = view_get_hport(0)*2/3;
sprTextBox = spr_text_box_dialogue;
layerTextBoxDialogue = 0;
xSentence = xTextBox - (sprite_get_width(sprTextBox)/2) + 20;
ySentence = yTextBox + 50;
    
xCharNameBox = 20;
yCharNameBox = view_get_hport(0)*2/3-30;
xSpeaker = xCharNameBox;
ySpeaker = yCharNameBox;
sprCharNameBox = spr_char_name_box_dialogue;
layerCharNameBoxDialogue = 0;
isOpened = false;
#endregion

#region dynamic data for printer, DO NOT EDIT during runtime
bufferSentence = "";
idCharCurrent = 1;
sentence ="";
speaker = "";
reqTypewriting = false;
skipTypewriting = false;
stateText = "PAUSE";
isEnabled = true;
#endregion

Set_Sentence = function(_s){//public
    sentence = _s;
    idCharCurrent = 1;
    bufferSentence = "";
}

Clear_Sentence = function(){//public
    sentence = "";
    reqTypewriting = false;
    bufferSentence = "";
    speaker = "";
}

Skip_Typewriting = function(){//public
    bufferSentence = sentence;
    idCharCurrent = string_length(sentence);
    stateText = "PAUSE";
}


Close = function(){//public
    isOpened = false;
    Clear_Layer_Element(layerTextBoxDialogue);
    Clear_Layer_Element(layerCharNameBoxDialogue);
}

Open = function(){//public
    isOpened = true;
    Clear_Layer_Element(layerTextBoxDialogue);
    layer_sprite_create(layerTextBoxDialogue,xTextBox,yTextBox,sprTextBox);
    Clear_Layer_Element(layerCharNameBoxDialogue);
    layer_sprite_create(layerCharNameBoxDialogue,xCharNameBox,yCharNameBox,sprCharNameBox);
}

Pause_Typewriting = function(){//public
    reqTypewriting = false;
}

Play_Typewriting = function(){//public
    reqTypewriting = true;
}

Get_Pos_Typewriting = function(){//public
    return idCharCurrent;
}

Check_Finished_Typewriting = function(){//public
    return idCharCurrent == string_length(sentence);
}

Draw_Text_Buffer = function(){//private
    draw_set_valign(valign);
    draw_set_halign(halign);
    draw_text(xSentence, ySentence, bufferSentence);
    Reset_Draw_Text();
    return;
}

Update_Text_Buffer = function(){//private
    var _lenS = string_length(sentence);
    var _lenB = string_length(bufferSentence);
    if(0 == _lenS){
        bufferSentence = "";
    }
    else if(_lenS == _lenB){
        return;
    }
    else if(_lenB < _lenS){
        bufferSentence = bufferSentence + string_char_at(sentence, _lenB + 1 );
        return;
    }
    else if(_lenS<_lenB){
        show_error("Err: illegal length of buffer",true);
    }
}

Draw_Speaker = function(){//private
    draw_text(xSpeaker, ySpeaker, speaker);
}

Play_Snd_Writing = function(){//private
    //controller_snd.Play_Snd(WRITING_DIALOGUE);//TODO: establish controller_snd obj
}