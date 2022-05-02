/// @desc auto sync broadcasters' output to subscribers' input while end stop event
function Add_Subscription(_broadcaster, _nameOutput, _subscriber, _nameInput){  
    var _subscription = new subscription(_broadcaster, _nameOutput, _subscriber, _nameInput);
    var _size = ds_list_size(subscriptions);
    subscriptions[|_size] = _subscription;
}

function subscription(_broadcaster, _nameOutput, _subscriber, _nameInput) constructor{
    broadcaster = _broadcaster;
    nameOutput = _nameOutput;
    subscriber = _subscriber;
    nameInput = _nameInput;
}

function Delete_Subscription(_broadcaster, _nameOutput, _subscriber, _nameInput){
    var _size = ds_list_size(subscriptions);
    var _s;
    for(var _pos=0; _pos<_size; _pos++){
        _s = subscriptions[|_pos];
        if(_broadcaster == _s.broadcaster)
        &&(_nameOutput == _s.nameOutput)
        &&(_subscriber == _s.subscriber)
        &&(_nameInput == _s.nameInput){
                ds_list_delete(subscriptions, _pos);
        }
    }
}

function Clear_Subscriptions(){
    ds_list_clear(subscriptions);
}

function Broadcast_Subscriptions(){
    var _size = ds_list_size(subscriptions);
    if(_size == 0){return;}
    var _s, _val;
    for(var _pos = 0; _pos<_size; _pos++){
        _s = subscriptions[|_pos];
        if(Check_Legal(_s)){
            _val = variable_instance_get(_s.broadcaster, _s.nameOutput);
            variable_instance_set(_s.subscriber, _s.nameInput,_val);
        }
        else{continue;}
    }
}

function Check_Legal(_s){
    if(instance_exists(_s.broadcaster))
    &&(instance_exists(_s.subscriber))
    &&(variable_instance_exists(_s.broadcaster,_s.nameOutput))
    &&(variable_instance_exists(_s.subscriber,_s.nameInput)){
        return true;
    }
    else{
        return false;
    }
}