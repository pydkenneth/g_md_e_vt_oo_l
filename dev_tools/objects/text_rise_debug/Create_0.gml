/// @desc 

prv = {
    stackable : false,
    life : 60,  //ticks
    yStep : -1,
    height_Line : 18
}

//WARNING : DO NOT EDIT
function structText(_text, _life) constructor{
    text = _text;
    life = _life;
    lifeCurrent = _life;
}

//WARNING : DO NOT EDIT, call this constructor to add text into queue
function PushText(_text, _life){
    var _lifeSet = is_undefined( _life) ? prv.life : _life;
    var _structText = new structText(_text, _lifeSet);
    array_push(texts,_structText);
}

//USER DEFINE: Preset texts
//public signal, call PushText() to add queue member
texts[0] = new structText("",prv.life);
texts[1] = new structText("1",prv.life);
texts[2] = new structText("2",prv.life);