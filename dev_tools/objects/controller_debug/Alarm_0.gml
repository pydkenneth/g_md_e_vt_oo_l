/// @desc 
var _life = floor(60 * random_range(0, 10));
inst_text_rise_debug.PushText("New Text!!" + string(_life), _life);

alarm_set(0, 10);