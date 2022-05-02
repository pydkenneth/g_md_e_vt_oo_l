/// @desc 

prv = {
    digit: 10,
    digit_dec_point:2, //0~3: no dec point, from right to left
    
    valueDefault : 12345678.1,   //NOTICE: you should pair value with digit and dec point
    valueMax:100,
    valueMin:0,
    //style
    name : "name", //string
    
    //DO　NOT EDIT
    digit_dec_left:0,
    digit_dec_right:0,
    textValue : ""
}
//public attributes
value = clamp(prv.valueDefault,prv.valueMin, prv.valueMax);  //read only, Do NOT EDIT


//update digit_dec_left, digit_dec_right //DO NOT EDIT
if(prv.digit_dec_point>1){
    prv.digit_dec_left = prv.digit - prv.digit_dec_point;
    prv.digit_dec_right = prv.digit_dec_point-1;
}
else{
    prv.digit_dec_left = prv.digit;
    prv.digit_dec_right = 0;
}

//private functions below, DO NOT EDIT
function Detect_Mouse_Area(){
    if(
    //(mouse_check_button_pressed(mb_left))
    (x <= mouse_x)    &&(mouse_x <= x + sprite_width * prv.digit)
    &&(y <= mouse_y)    &&(mouse_y <= y + sprite_height)
    ){
        return true;
    }
    else{
        return false;
    }
}

function Detect_Digit_Mouse(){
    var _iDigit;
    for(_iDigit = 1; _iDigit <=prv.digit; _iDigit++){
        if(x+sprite_width*(prv.digit-_iDigit) < mouse_x){
            return _iDigit;
        }
    }
    return 0;
}

function Increase_Digit(_digitMouse){
    var _p = _digitMouse - prv.digit_dec_point -(_digitMouse>prv.digit_dec_point);
    var _dif = power(10,_p);
    value = clamp(value + _dif, prv.valueMin, prv.valueMax);
}

function Decrease_Digit(_digitMouse){
    var _p = _digitMouse - prv.digit_dec_point -(_digitMouse>prv.digit_dec_point);
    var _dif = power(10,_p);
    value = clamp(value - _dif, prv.valueMin, prv.valueMax);
}