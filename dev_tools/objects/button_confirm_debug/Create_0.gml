/// @desc 

//public attributes
isPressed = false;  //read only

//triggered when confirm is pressed
Do_Pressed = function(){ 
    draw_text(x, y-24, "button is pressed");
    
    var _inst = instance_create_depth(x, y+prv.height+10,depth, inputtext_debug);
    _inst.target.instance_id = id;
    _inst.target.name = "name";
    _inst.target.nameStruct = "prv";
    return;
}

prv = {
    //USER DEFINE STYLE:
    name : "BUTTON_COFIRM",
    widthSelf : 96,
    widthConfirm : 24,
    height : 24,
    valueDefault : 0,
    

    //[ x1,y1,x2,y2]
    posSelf : [0,0,0,0],
    posConfirm : [0,0,0,0],
    c_Self : c_dkgray,
    c_Confirm : c_red,
    c_Frame : c_yellow
}

//initialize positions, DO NOT EDIT
prv.posSelf[0] = x;
prv.posSelf[1] = y;
prv.posSelf[2] = x + prv.widthSelf;
prv.posSelf[3] = y + prv.height;
prv.posConfirm[0] = x + prv.widthSelf;
prv.posConfirm[1] = y;
prv.posConfirm[2] = x + prv.widthSelf + prv.widthConfirm;
prv.posConfirm[3] = y + prv.height;

function Draw_buttonSelf(){ //DO NOT EDIT
    draw_set_color(prv.c_Self);
    draw_roundrect(prv.posSelf[0],prv.posSelf[1],prv.posSelf[2],prv.posSelf[3],false);
    draw_set_color(c_white);
}

function Draw_buttonConfirm(){ //DO NOT EDIT
    draw_set_color(prv.c_Confirm);
    draw_roundrect(prv.posConfirm[0],prv.posConfirm[1],prv.posConfirm[2],prv.posConfirm[3], false);
    draw_set_color(c_white);
}

function Draw_OutlineSelf(){ //DO NOT EDIT
    draw_roundrect_color(prv.posSelf[0],prv.posSelf[1],prv.posSelf[2],prv.posSelf[3], prv.c_Frame, prv.c_Frame, true);
}

function Draw_OutlineConfirm(){ //DO NOT EDIT
    draw_roundrect_color(prv.posConfirm[0],prv.posConfirm[1],prv.posConfirm[2],prv.posConfirm[3], prv.c_Frame, prv.c_Frame, true);
}

//private function, DO NOT EDIT
function WaitingPress(){
    Draw_buttonSelf();
    draw_text(x,y,prv.name);
    if(point_in_rectangle(mouse_x, mouse_y, prv.posSelf[0], prv.posSelf[1], prv.posSelf[2], prv.posSelf[3])){
        Draw_OutlineSelf();
        if(mouse_check_button_pressed(mb_left)){
            DoState = WaitingConfirm;
        }
    }
}

//private function, DO NOT EDIT
function WaitingConfirm(){
    Draw_buttonSelf();
    draw_text(x,y,prv.name);
    Draw_buttonConfirm();
    if(point_in_rectangle(mouse_x, mouse_y, prv.posConfirm[0], prv.posConfirm[1], prv.posConfirm[2], prv.posConfirm[3])){
        Draw_OutlineConfirm();
        if(mouse_check_button_pressed(mb_left)){
            DoState = WaitingPress;
            Do_Pressed();
        }
    }
    else{
        if(mouse_check_button_pressed(mb_left)){
            DoState = WaitingPress;
        }
    }
}

//initial state of statemachin, //DO NOT EDIT
DoState = WaitingPress;