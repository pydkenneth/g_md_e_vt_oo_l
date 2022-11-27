CHECK_DEBUG_SWITCH

#region DONE
var _vec = array_create(2);
_vec = Add_Vec_Cartesian(1,2,3,4);
_vec = Add_Vec_Polar(-1, 0, 2, 60);
_vec[0] = Dot_Vec_Cartesian(-4,-2,3,-1);
_vec[0] = Dot_Vec_Polar(1,30,1.41,75);
#endregion

_vec = Cartesian2Polar(1,1.73);

_vec = Polar2Cartesian(2, 30);

/*
_vec = Add_Vec_Polar(1,0,1,90);

*/


text[0] = _vec[0];
text[1] = _vec[1];

//WARNING : DO NOT EDIT ALL CODE BELOW
draw_self();
for(var _iLine=0; _iLine<array_length_1d(text); _iLine++;){
    draw_text(x, y +prv.height_Line*_iLine, text[_iLine]);
}