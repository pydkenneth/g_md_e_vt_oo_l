function statemachine() constructor{//DO NOT EDIT
    states = array_create();
    statesNext = array_create();
    trans = array_create();
    Step = function(){}
    
    Clear_Active_States = function(){//fixed, DO NOT EDIT
        var _len = array_length(states);
        for(var _i = _len-1; _i>=0;_i--){
            states[_i].isActive = false;
        }
    }
    
    Init_State = function(){//fixed, DO NOT EDIT
        Clear_Active_States();
        states[0].isActive = true;
    }
    
    Update_Active_States = function(){//DO NOT EDIT
        Clear_Active_States();
        var _len, _i;
        
        //_len = array_length(statesNext);
        //for(_i = _len-1; 0<=_i; _i--){
        //    statesNext[_i].isActive = true;
        //}
        
        _len = array_length(trans);
        for(_i = _len-1; 0<=_i; _i--){
            if(trans[_i].ableTransit){
                trans[_i].destState.isActive = true;
                trans[_i].ableTransit = false;
            }
        }
    }
    
    static Step = function(){//DO NOT EDIT
        var _len, _i;
        _len = array_length(states);
        for(_i = _len-1; 0<=_i; _i--){
            if(states[_i].isActive){
                states[_i].Step();
                //break;
            }
        }
        Update_Active_States();
    }
    
    static Link = function(_src, _trans, _dest){//DO NOT EDIT
        _trans.stateSrc = _src;
        _trans.stateDest = _dest;
        array_push(_src.trans,_trans);
    }
}

function state() constructor{
    trans = array_create();//user overwrite after create
    EntryAction = function(){}//user overwrite after create
    DuringAction = function(){}//user overwrite after create
    ExitAction = function(){}//user overwrite after create
    
    isActive = false;//DO NOT EDIT
    Step = function(){//DO NOT EDIT
        if(isActive==false){return;}
        
        //checking trans
        var _len, _i, _stop;
        _len = array_length(trans);
        for(_i=_len-1; 0<=_i; i--){
            _stop = trans[_i].Step();
            if(_stop){return;}
        }
        
        //no trans available, Do During Action
        state.DuringAction();
    }
}

function transition() constructor{
    stateSrc = -1;//user overwrite after create
    stateDest = -1;//user overwrite after create
    Condition = DoNothing();//user overwrite after create
    ConditionAction = DoNothing();//user overwrite after create
    
    ableTransit = false;//DO NOT EDIT
    static Step = function(){//DO NOT EDIT
        if(Condition()){
            ConditionAction();
            stateSrc.ExitAction();
            stateSrc.isActive = false;
            stateDest.EntryAction();
            ableTransit = true;
            return true;//_stop for checking trans by state
        }
        else{
            return false;
        }
    }
}