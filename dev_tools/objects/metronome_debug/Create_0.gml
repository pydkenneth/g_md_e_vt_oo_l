/// @desc 
period = 2; //tick

prv = {
    name : object_get_name(object_index),
    stepCurrent : 0,
    isStepping : false,
    widthCheck : 24,
    heightCheck : 24
}

function Update_Period(){
    //USER DEFINE PERIOD SOURCE
    period = period;
}

//WARNING : DO NOT EDIT ALL CODE BELOW

function Restart(){
    Update_Period();
    prv.stepCurrent = 0;
    prv.isStepping = true;
}

function Stop(){
    prv.isStepping = false;
    prv.stepCurrent = 0;
}

function Do_PeriodAction(){
    inst_text_rise_debug.PushText(prv.name, 30);
    return;
}

function Detect_Mouse_Click(){
    if(
    (mouse_check_button_pressed(mb_left))
    &&(point_in_rectangle(mouse_x, mouse_y, x, y, x+prv.widthCheck, y+prv.heightCheck))
    ){
        prv.isStepping = !prv.isStepping;
        if(prv.isStepping){
            Restart();
        }
        else{
            Stop();
        }
    }
}
