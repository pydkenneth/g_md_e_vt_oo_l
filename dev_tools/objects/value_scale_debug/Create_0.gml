/// @desc 

prv = {
    stepSmall : 1,
    stepBig : 10,
    valueMin : 0,
    valueMax : 100,
    valueDefault : 0,
    //style
    name : "val: ", //string
    widthMid : 96,
    widthButton : 24,
    height : 24,
    c_Button : c_dkgray,
}

value = prv.valueDefault;  //read only, Do NOT EDIT

//set attributes of each button, from left to right
//style
prv.texts[0]="|<";
prv.texts[1]="<<";
prv.texts[2]="<";
prv.texts[3]="";    //space for middle
prv.texts[4]=">";
prv.texts[5]=">>";
prv.texts[6]=">|";

//WARNING : DO NOT EDIT
prv.xposs[0]=x+prv.widthButton*0;
prv.xposs[1]=x+prv.widthButton*1;
prv.xposs[2]=x+prv.widthButton*2;
prv.xposs[3]=x+prv.widthButton*3;   //space for middle
prv.xposs[4]=x+prv.widthButton*3 +prv.widthMid +(prv.widthButton*0);
prv.xposs[5]=x+prv.widthButton*3 +prv.widthMid +(prv.widthButton*1);
prv.xposs[6]=x+prv.widthButton*3 +prv.widthMid +(prv.widthButton*2);

//WARNING : DO NOT EDIT
prv.cols[0]=prv.c_Button;
prv.cols[1]=prv.c_Button;
prv.cols[2]=prv.c_Button;
prv.cols[3]=prv.c_Button;
prv.cols[4]=prv.c_Button;
prv.cols[5]=prv.c_Button;
prv.cols[6]=prv.c_Button;

//WARNING : DO NOT EDIT
//set actions for each button, from left to right
prv.actions_Buttons[0] = function(){value = prv.valueMin;}
prv.actions_Buttons[1] = function(){value -= prv.stepBig;}
prv.actions_Buttons[2] = function(){value -= prv.stepSmall;}
prv.actions_Buttons[3] = function(){value = prv.valueDefault;}
prv.actions_Buttons[4] = function(){value += prv.stepSmall;}
prv.actions_Buttons[5] = function(){value += prv.stepBig;}
prv.actions_Buttons[6] = function(){value = prv.valueMax;}

//private functions, DO NOT EDIT
function Draw_Middle(){
    var _xBias = 3*prv.widthButton;
    draw_rectangle_color(x+_xBias,y,x+_xBias+prv.widthMid,y+prv.height,c_dkgray,c_dkgray,c_dkgray,c_dkgray,false);
    
    var _text = prv.name + string(value);
    draw_text(x+_xBias,y, _text);
    return;
}

function Draw_Button(_x,_y,_text,_col){
    draw_roundrect_color(_x,_y,_x+prv.widthButton, _y+prv.height, _col, c_black, false);
    draw_text(_x,_y,_text);
    return;
}

function Detect_Mouse_Area(){
    if(
    (mouse_check_button_pressed(mb_left))
    &&(x <= mouse_x)    &&(mouse_x <= x+6*prv.widthButton + prv.widthMid)
    &&(y <= mouse_y)    &&(mouse_y <= y+prv.height)
    ){
        return true;
    }
    else{
        return false;
    }
}