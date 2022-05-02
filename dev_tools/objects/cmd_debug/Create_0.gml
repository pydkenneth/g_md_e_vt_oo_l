/// @desc 
//User Define:
KEYS_OPEN = ["Z", "X", "C"];//keys for open cmd, only capital A-Z and 0-9 are acceptable
image_blend = c_green;
DELAY_DELETE = -30; //delay time for holding backspace to start delete letters continueously

//TODO:move to outside of object
////////////////////////////////////////////////////////////////////////////
//User Define: functions
Draw123 = function(){
    draw_text(x,y-100,"123");
}
Draw456 = function(){
    draw_text(x,y-100,"456");
}

Push = function(){
    with(inst_text_rise_debug){PushText("CMD is working", 30);}
}

////////////////////////////////////////////////////////////////////////////
//User Define: Register command - function pair
enum CMDTYPE{STEP = 0,DRAW = 1}
cmds[0] =   ["123",     Draw123, CMDTYPE.DRAW];
cmds[1] =   ["456",     Draw456, CMDTYPE.DRAW];
cmds[2] =   ["push",    Push, CMDTYPE.STEP];


////////////////////////////////////////////////////////////////////////////
//DO NOT EDIT: for State_OpenClose
function CmdClosed(){
    if(array_length(KEYS_OPEN)<=id_KEYS_OPEN){
        State_OpenClose = CmdOpened;
        id_KEYS_OPEN = 0;
        return;
    }
    
    //get key from keyboard
    if(keyboard_check_pressed(vk_anykey)
    && keyboard_check_pressed(ord(KEYS_OPEN[id_KEYS_OPEN]))){   //if correct key is pressed, wait next correct key
        id_KEYS_OPEN++;
        return;
    }
    else if(keyboard_check_pressed(vk_anykey)){ //if wrong key is pressed, restart key detemination
        id_KEYS_OPEN = 0;
        return;
    }
}

//DO NOT EDIT: for State_OpenClose
function CmdOpened(){
    if(keyboard_check_pressed(vk_escape)){
        State_OpenClose = CmdClosed;
    }
}

//DO NOT EDIT: for State_Commands
function WaitingOpen(){
    if(State_OpenClose == CmdOpened){
        State_Commands = ReceivingInput;
        keyboard_string = "";
    }
}

function Draw_NoMatchCmd(){
    draw_text(x,y-24,"WARNING: This command is NOT supported, please try another or add new one.");
    var _inst = instance_create_depth(x,y-24,depth,text_rise_age_debug);
    _inst.PushText("WARNING: This command is NOT supported, please try another or add new one.", 60);
}

//DO NOT EDIT: for State_Commands
function ReceivingInput(){
    //transitions://////////////////////////////////////////////////////////////////
    if(State_OpenClose == CmdClosed){
        State_Commands = WaitingOpen;
        stringEntering = "";
        return;
    }
    else if(keyboard_check_pressed(vk_enter)){
        for(var _i=0; _i < array_length(cmds); _i++){
            if(!(stringEntering == cmds[_i][0])){continue;} //skip if not matching
            switch(cmds[_i][2]){
            case CMDTYPE.STEP:
                cmds[_i][1]();  break;
            case CMDTYPE.DRAW:
                Cmd_Draw = cmds[_i][1]; break;  //pass function to draw event
            }
            //close cmd
            State_Commands = WaitingOpen;
            State_OpenClose = CmdClosed;
            stringEntering = "";
            return;
        }
        //no command matches string
        Cmd_Draw = Draw_NoMatchCmd;
    }
    
    //during:///////////////////////////////////////////////////////////////////////
    if(keyboard_check(vk_anykey) && !keyboard_check(vk_backspace) && string_length(stringEntering)<200){  //entering text
        stringEntering = stringEntering + string(keyboard_string);
        keyboard_string = "";
    }
    else if(keyboard_check_pressed(vk_backspace)){  //delete 1 character
        stringEntering = string_delete(stringEntering,string_length(stringEntering),1);
        keyboard_string = "";
        delete_timer = DELAY_DELETE;
    }
    else if(keyboard_check(vk_backspace) && !keyboard_check_pressed(vk_backspace) && delete_timer == 2){  //delete by hodling backspace
        stringEntering = string_delete(stringEntering, string_length(stringEntering),1);
        keyboard_string = "";
        delete_timer = 0;
    }

    if(delete_timer != 2){ delete_timer++; }    //Handle Timer Update
}

//Initializing, DO NOT EDIT
stringEntering = "";    //input buffer for user
id_KEYS_OPEN = 0;
State_OpenClose = CmdClosed;
State_Commands = WaitingOpen;
delete_timer = 2;
Cmd_Draw = -1;