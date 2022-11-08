/// @desc 
#region declare functions
function Add_Room(_idRoom, _nameRoom="-"){
    array_push(namesChoice, _nameRoom);
    array_push(roomsChoice, _idRoom);
}
#endregion

//names of choices
namesChoice = array_create();roomsChoice = array_create();//DO NOT EDIT

Add_Room(Room1,"Room1");
Add_Room(rm_particle, "rm_particle");
Add_Room(rm_statemachine, "statemachine");
choiceCurrent = 0;

prv = {
    //style
    height : 48,
    widthMid : 240,
    widthButton : 48,
    c_ButtonStatic : c_gray,
    c_ButtonPressed : c_green,
    
    //DO NOT EDIT:
    choicePrevious : choiceCurrent,
    numChoices : array_length_1d(namesChoice),
    
    //DO NOT EDIT : constants
    buttonNone : 0,
    buttonLeft : 1,
    buttonRight : 2
}

TriggerAction = function(){
    room_goto(roomsChoice[choiceCurrent]);
    return;
}

//DO NOT EDIT : private funcitons
function Draw_LeftButton(_c_Button){
    draw_roundrect_color(x,y,x+prv.widthButton, y+prv.height, _c_Button, _c_Button, false);   //left button
    draw_triangle_color(x,y+prv.height*0.5, x+prv.widthButton-5, y, x+prv.widthButton-5, y+prv.height, c_white, c_white, c_white, false);
}

function Draw_RightButton(_c_Button){
    draw_roundrect_color(x+prv.widthMid,y,x+prv.widthMid+prv.widthButton, y+prv.height, _c_Button, _c_Button, false);   //right button
    draw_triangle_color(x+prv.widthMid+prv.widthButton,y+prv.height*0.5, x+prv.widthMid+5, y, x+prv.widthMid+5, y+prv.height, c_white, c_white, c_white, false);
}

function Draw_ChoiceArea(){
    draw_roundrect_color(x+prv.widthButton,y,x+prv.widthMid, y+prv.height, c_dkgray, c_dkgray, false);   //right button
    draw_text(x+prv.widthButton, y, namesChoice[choiceCurrent]);
}

function Draw_Base(){
    Draw_LeftButton(prv.c_ButtonStatic);
    Draw_RightButton(prv.c_ButtonStatic);
    Draw_ChoiceArea();
}

function Check_MousePressedButton(){
    if(!mouse_check_button_pressed(mb_left)){ return 0;}  //mouse is not clicked;
    
    //check if button is clicked
    if(point_in_rectangle(mouse_x, mouse_y, x, y, x+prv.widthButton, y+prv.widthButton)){
        return prv.buttonLeft;   //left button is clicked;
    }
    else if(point_in_rectangle(mouse_x, mouse_y, x+prv.widthMid, y, x+prv.widthMid+prv.widthButton, y+prv.widthButton)){
        return prv.buttonRight;   //right button is clicked;
    }
    else{
        return prv.buttonNone;   //no button is pressed
    }
}