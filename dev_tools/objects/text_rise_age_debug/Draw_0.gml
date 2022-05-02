/// @desc 
CHECK_DEBUG_SWITCH

//WARNING : DO NOT EDIT ALL CODE BELOW

draw_self();

//check any data in queue
var _len = array_length(texts);
if(0 == _len){instance_destroy();}

var _y, _text, _lifeDepleted;
for(var _iTexts = 0; _iTexts < _len; _iTexts++){
    _lifeDepleted = texts[_iTexts].life - texts[_iTexts].lifeCurrent;
    _y = y + prv.yStep * _lifeDepleted;
    _text = texts[_iTexts].text;
    draw_text(x, _y,_text);
    
    //advance timer
    texts[_iTexts].lifeCurrent -=1;
    
    //only draw first text if not stackable
    if(!prv.stackable){break;}
}

for(_iTexts = _len-1; 0 <= _iTexts; _iTexts--){
    //delete text when time out
    if(texts[_iTexts].lifeCurrent <=0 ){
        array_delete(texts,_iTexts,1);
    }
}