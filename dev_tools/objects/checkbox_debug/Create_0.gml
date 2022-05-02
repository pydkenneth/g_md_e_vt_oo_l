/// @desc 

//Public attributes
isChecked = false;  //read only

//triggered when (isChecked == true)
TriggerAction = function(){ 
    draw_text(x + prv.width, y+24, "I'm checked.");
    return;
}


prv = {
    //USER DEFINE STYLE
    width : 24,
    height : 24, 
    c_Checked : c_green,
    c_NotChecked : c_dkgrey,
    text : "checkbox"
}
