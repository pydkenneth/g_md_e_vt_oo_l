//observer pattern
function signal_dev() constructor{
    observers = array_create();
    name_var = 0;
    value = 0;
    
    static Add_Slot = function(){}
    static Del_Slot = function(){}
    static emit = function(_val){
        var _data = Get_Value(_val);
        var _len = array_length(observers);
        for(var _i=0; _i<_len; _i++){
            observers[_i].Update(_val);
        }
    }
    
    static notify = function(){
        var _len = array_length(observers);
        for(var _i=0; _i<_len; _i++){
            observers[_i].React();
        }
    }
    
    static Get_Value = function(_val){
        value = _val;
        return value;
    }
}

function slot_dev() constructor{
    subject = -1;
    Update = function(){}
}
