///desc: practical code fragments, functions, examples...etc
///last edited: 2021.1022.2205

function Draw_Reset(){
    draw_set_colour(c_white);
    draw_set_alpha(1);
    draw_set_valign(fa_top);
    draw_set_halign(fa_left);
}

///desc compute phase value according to input values
function GetPhaseValue_EqualPropotion(_valueStart, _period, _valueZeroPhase, _proportionEqual, _phaseTarget){
    //determine target value while _valueStart == 0
    var _targetValue_0 = (_period / _proportionEqual) * _phaseTarget;
    
    //we have a value for zero phase
    
    //move forward with PorportionEqual, period
    var _valueForward = 0;
    _valueForward = _valueZeroPhase + ((_period / _proportionEqual) *_phaseTarget);
    _valueForward = _valueForward % _period;
    
    var _valueTarget = 0;
    _valueTarget = _valueStart + _valueForward;
    if(_valueTarget >= (_valueStart + _period)){
        _valueTarget = _valueTarget - _period;
    }
    
    return _valueTarget;
}

//example: brief judge at start line of a function
//#macro CHECK_DEBUG_MODE if(global.debug_mode==false){return;}

function Draw_Cross(_x,_y,_len,_w,_col1,_col2){
    draw_line_width_color(_x,_y,_x,_y-_len,_w,_col1,_col2);
    draw_line_width_color(_x,_y,_x-_len,_y,_w,_col1,_col2);
    draw_line_width_color(_x,_y,_x,_y+_len,_w,_col1,_col2);
    draw_line_width_color(_x,_y,_x+_len,_y,_w,_col1,_col2);
}

///desc: draw strings in array
function Draw_Strings(_strings, _height_Line = 24){
    for(var _iLine=0; _iLine<array_length(_strings); _iLine++;){
        draw_text(x, y +_height_Line*_iLine, _strings[_iLine]);
    }
}

function FollowMouse_ButtonHolded(_button = mb_none, _range = 48){
    //_button: mb_any, mb_left, mb_none, mb_right, mb_side1, mb_side2
    if(mouse_check_button(_button)&&(point_in_circle(mouse_x, mouse_y, x, y, 48))){
        x = mouse_x;y = mouse_y;
    }
}

function Animcurve_Get_Value(_idCurv, _nameChannel, _val){
    var _channelCurv = animcurve_get_channel(_idCurv, _nameChannel);
    var _result = animcurve_channel_evaluate(_channelCurv, _val);
    return _result;
}

function Draw_ArrowHead(_x = 0, _y = 0, _direction = 0, _width = 24, _length = 24, _color = c_white, _outline = false){
    var _x1,_y1,_x2,_y2,_x3,_y3;
    _x1 = _x + lengthdir_x(_width/2, 90+_direction)
    _y1 = _y + lengthdir_y(_width/2, 90+_direction)
    _x2 = _x + lengthdir_x(_length, _direction)
    _y2 = _y + lengthdir_y(_length, _direction)
    _x3 = _x + lengthdir_x(_width/2, -90 +_direction)
    _y3 = _y + lengthdir_y(_width/2, -90+_direction)
    draw_set_colour(_color);
    draw_triangle(_x1, _y1, _x2, _y2, _x3, _y3, _outline);
    draw_set_colour(c_white);
}

//Convert value into another unit, same as determine value 'F from know value in 'C.
function Convert_Unit(_c, _cMin, _cMax, _fMin, _fMax){
    return (_c-_cMin)/(_cMax-_cMin)*(_fMax-_fMin)+_fMin;
}
    
function Draw_Rectangle_Center(_x,_y,_width,_height, _color = c_white, _outlined = false){
    var _x1 = _x - _width/2;
    var _x2 = _x + _width/2;
    var _y1 = _y - _height/2;
    var _y2 = _y + _width/2;
    
    draw_set_color(_color);
    draw_rectangle(_x1,_y1,_x2,_y2,_outlined);
    Draw_Reset();
}

function Draw_Rectangle_Spr(_x,_y,_width,_height,_color, _centered = false){
    draw_set_color(_color);
    draw_sprite_stretched(spr_point, 0, _x-(_centered?_width/2:0), _y-(_centered?_width/2:0), _width, _height);
    Draw_Reset();
}

function Add_Vec_Cartesian(_x1,_y1,_x2,_y2){
    return [(_x1 + _x2), (_y1 + _y2)];
}

function Add_Vec_Polar(_r1,_phi1,_r2,_phi2){
    var _pReal = _r1*dcos(_phi1) + _r2*dcos(_phi2);
    var _pImage = _r1*dsin(_phi1) + _r2*dsin(_phi2);
    var _r = sqrt(sqr(_pReal) + sqr(_pImage));
    var _phi = darctan(_pImage / _pReal);
    return [_r, _phi];
}

function Dot_Vec_Cartesian(_x1,_y1,_x2,_y2){
    return (_x1*_x2) + (_y1*_y2);
}

function Dot_Vec_Polar(_r1,_dphi1,_r2,_dphi2){
    return (_r1 * _r2 * dcos(abs(angle_difference(_dphi1,_dphi2))));
}

function Cartesian2Polar(_x,_y){//NOTICE: for -y direction
    var _r = sqrt(sqr(_x) + sqr(_y));
    var _phi = darctan(-_y/_x);
    return [_r,_phi];
}

function Polar2Cartesian(_r, _phi){//NOTICE: for -y direction
    var _x = _r * dcos(_phi);
    var _y = -_r * dsin(_phi);
    return [_x,_y];
}

function DoNothing(){return 0;}