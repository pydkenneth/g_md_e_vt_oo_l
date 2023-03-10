/// @desc 
Draw_Cross(x,y);
//draw_text(x,y,"I'm here.");
draw_text(xSentence, ySentence, bufferSentence);

//Draw_Text_Buffer();
switch(stateText){
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