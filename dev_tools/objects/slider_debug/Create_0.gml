/// @desc 
//privates
prv = {
    valueDefault : 0,
    valueMin : 0,
    valueMax : 100,
    stepWheel : 1,

    widthSelf : 96,
    heightSelf : 24,
    widthHandler : 2,
    heightHandler : 28,
    c_Self : c_dkgray,
    c_Handler : c_green,
    c_Outline : c_gray,

    mb_Reset : mb_middle,
    mb_Set : mb_right,
    
    //style:
    name : "SLIDER",
    enable_DrawName : 2,//0: hide, 1: alway show name, 2: show only hovered
    enable_Draw_Value : true,
    enable_Draw_Value_Normal : true,
    isVertical : true,
}

//initialize attributes, DO NOT EDIT
if(prv.isVertical){ //transpose to vertical
    prv.posSelf[0] = x;
    prv.posSelf[1] = y;
    prv.posSelf[2] = x + prv.heightSelf;
    prv.posSelf[3] = y + prv.widthSelf;
    prv.posHandler[0] = x + prv.heightSelf/2 - prv.heightHandler/2;
    prv.posHandler[1] = y + prv.heightSelf/2 - prv.widthHandler/2
    prv.posHandler[2] = x + prv.heightSelf/2 + prv.heightHandler/2;
    prv.posHandler[3] = y + prv.widthSelf/2 + prv.widthHandler/2
}
else{
    prv.posSelf = array_create(4,0);
    prv.posSelf[0] = x;
    prv.posSelf[1] = y;
    prv.posSelf[2] = x + prv.widthSelf;
    prv.posSelf[3] = y + prv.heightSelf;
    //compute bar from center of self, DO NOT EDIT
    prv.posHandler = array_create(4,0);
    prv.posHandler[0] = x + prv.widthSelf/2 - prv.widthHandler/2;
    prv.posHandler[1] = y + prv.heightSelf/2 - prv.heightHandler/2;
    prv.posHandler[2] = x + prv.widthSelf/2 + prv.widthHandler/2;
    prv.posHandler[3] = y + prv.heightSelf/2 + prv.heightHandler/2;
}

//publics
value = prv.valueDefault; //DO NOT EDIT


//DO NOT EDIT
WaitingDrag = function(){
    Draw_Self();
    if(prv.isVertical){
        var _x = prv.posHandler[1] + prv.widthHandler/2;
    }
    else{
        var _x = prv.posHandler[0] + prv.widthHandler/2;
    }
    
    if(point_in_rectangle(mouse_x, mouse_y, prv.posSelf[0], prv.posSelf[1], prv.posSelf[2], prv.posSelf[3])){
        Draw_OutlineSelf();
        if(mouse_check_button_pressed(mb_left)){
            Do_State = Dragging;
        }
        else if(mouse_check_button_pressed(prv.mb_Reset)){
            value = prv.valueDefault;
        }
        else if(mouse_wheel_up()){
            value= clamp(value+prv.stepWheel,prv.valueMin, prv.valueMax);
        }
        else if(mouse_wheel_down()){
            value=clamp(value-prv.stepWheel, prv.valueMin, prv.valueMax);
        }
        else if(mouse_check_button_pressed(prv.mb_Set)){
            var _inst = instance_create_depth(x,y-prv.heightSelf, depth-1, inputtext_debug);
            _inst.target.instance_id = id;
            _inst.target.name = "value";
        }
        
        
        //update _x
        if(mouse_check_button_pressed(mb_left)){
            if(prv.isVertical){
                _x = mouse_y;
            }
            else{
                _x = mouse_x;
            }
        }
        else if(mouse_check_button_pressed(prv.mb_Reset)
        || mouse_wheel_up()
        || mouse_wheel_down()
        ){
            if(prv.isVertical){
                _x = Convert_Unit(value, prv.valueMin, prv.valueMax, prv.posSelf[3], prv.posSelf[1]);
            }
            else{
                _x = Convert_Unit(value, prv.valueMin, prv.valueMax, prv.posSelf[0], prv.posSelf[2]);
            }
        }
        
    }else{
        if(prv.isVertical){
            _x = Convert_Unit(value, prv.valueMin, prv.valueMax, prv.posSelf[3], prv.posSelf[1]);
        }
        else{
            _x = Convert_Unit(value, prv.valueMin, prv.valueMax, prv.posSelf[0], prv.posSelf[2]);
        }
    }

    if(prv.isVertical){
        prv.posHandler[1] = _x - prv.widthHandler/2;
        prv.posHandler[3] = _x + prv.widthHandler/2;
    }
    else{
        prv.posHandler[0] = _x - prv.widthHandler/2;
        prv.posHandler[2] = _x + prv.widthHandler/2;
    }
}

//DO NOT EDIT
Dragging = function(){
    Draw_Self();
    Draw_OutlineSelf();
    if(prv.isVertical){
        var _x = prv.posHandler[1] + prv.widthHandler/2;
    }
    else{
        var _x = prv.posHandler[0] + prv.widthHandler/2;
    }
    
    if(mouse_check_button(mb_left)){
        if(prv.isVertical){
            _x = clamp(mouse_y, prv.posSelf[1], prv.posSelf[3]);
            value = Convert_Unit(_x, prv.posSelf[3], prv.posSelf[1],prv.valueMin, prv.valueMax);
        }
        else{
            _x = clamp(mouse_x, prv.posSelf[0], prv.posSelf[2]);
            value = Convert_Unit(_x, prv.posSelf[0], prv.posSelf[2],prv.valueMin, prv.valueMax);
        }
    }
    else{
        Do_State = WaitingDrag;
    }
    
    if(prv.isVertical){
        prv.posHandler[1] = _x - prv.widthHandler/2;
        prv.posHandler[3] = _x + prv.widthHandler/2;
    }
    else{
        prv.posHandler[0] = _x - prv.widthHandler/2;
        prv.posHandler[2] = _x + prv.widthHandler/2;
    }
}

Do_State = WaitingDrag;

//DO NOT EDIT
function Draw_Self(){
    draw_set_color(prv.c_Self);
    draw_rectangle(prv.posSelf[0], prv.posSelf[1], prv.posSelf[2], prv.posSelf[3], false);
    draw_set_color(c_white);
}

//DO NOT EDIT
function Draw_OutlineSelf(){
    draw_set_color(prv.c_Outline);
    draw_roundrect(prv.posSelf[0], prv.posSelf[1], prv.posSelf[2], prv.posSelf[3], true);
    draw_set_color(c_white);
}

function Draw_Handler(){
    draw_set_color(prv.c_Handler);
    draw_rectangle(prv.posHandler[0], prv.posHandler[1], prv.posHandler[2], prv.posHandler[3], false);
    draw_set_color(c_white);
}

function Draw_Value(){
    var _textValue = "";
    var _textVauleNormal = "";
    var _textSlash = "";
    
    if(prv.enable_Draw_Value_Normal){
        _textVauleNormal = string(value/prv.valueMax);
    }
    
    if(prv.enable_Draw_Value){
        _textValue = string(value);
    }
    
    if(prv.enable_Draw_Value && prv.enable_Draw_Value_Normal){
        _textSlash = " / ";
    }
    
    //draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    if(prv.isVertical){
        draw_text_transformed(x + prv.heightSelf/2, y,(_textValue + _textSlash + _textVauleNormal),1,1,-90);
    }
    else{
        draw_text(x, y + prv.heightSelf/2,(_textValue + _textSlash + _textVauleNormal));
    }
    
    if(prv.enable_DrawName == 1){   //always show name
        draw_set_halign(fa_right);
        draw_text(x, y + prv.heightSelf/2, prv.name);
    }
    else if (
    point_in_rectangle(mouse_x, mouse_y, prv.posSelf[0], prv.posSelf[1], prv.posSelf[2], prv.posSelf[3])
    || Do_State == Dragging)
    &&(prv.enable_DrawName == 2){
        draw_set_halign(fa_right);
        draw_text(x, y + prv.heightSelf/2, prv.name);
    }
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
}