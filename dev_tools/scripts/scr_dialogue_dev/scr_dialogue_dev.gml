function printer_dialogue(_x,_y) constructor{
    #region settings for printer, modify after new one
    xSentence = _x + 20;
    xSpeaker = _x;
    ySentence = _y + 100;
    ySpeaker = _x;
    widthSentence = 700;
    heightSentence = 300;
    spdTypewriting = 3;//unit:alphabets per sec
    halign = fa_left;
    valign = fa_top;
    showByAlphabet = true;
    autowrap = true;
    sndWriting = false;
    xFrame = _x;
    yFrame = _y;
    sprFrame = spr_text_box_dialogue;
    #endregion
    
    #region dynamic data for printer, DO NOT EDIT during runtime
    bufferSentence = "";
    idCharCurrent = 1;
    sentence ="";
    speaker = "";
    reqTypewriting = false;
    skipTypewriting = false;
    state = "PAUSE";
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
        state = "PAUSE";
    }

    Draw = function(){//public, put this function in draw event
        if(isEnabled){Draw_Frame();}
        
        switch(state){
        default:
        case "PAUSE":
            if(reqTypewriting && !Check_Finished_Typewriting()){
                Update_Text_Buffer();
                Draw_Text_Buffer();
                Draw_Speaker();
                Play_Snd_Writing();
                stateText = "WRITING"
            }
            else{
                Draw_Text_Buffer();
                Draw_Speaker();
            }
            break;
            
        case "WRITING":
            if(!reqTypewriting || Check_Finished_Typewriting()){
                Draw_Text_Buffer();
                Draw_Speaker();
                stateText = "PAUSE";
            }
            else{
                Update_Text_Buffer();
                Draw_Text_Buffer();
                Draw_Speaker();
                Play_Snd_Writing();
            }
        
        }
    }

    Close = function(){//public
    }

    Open = function(){//public
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

    Draw_Frame = function(){//private
        draw_sprite(sprFrame, 0, xFrame, yFrame);
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
}