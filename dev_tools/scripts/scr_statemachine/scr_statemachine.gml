//WARNING: You should NOT modify script below.
//design graph: simple_statemachine_frame.graphml
#region Public Constructors & Functions////////////////////////////////
function statemachine(_name) constructor{//DO NOT EDIT
    #region attributes////////////////////////////////////////
	decomposition = "OR";
    states = array_create();
    transesDefault = array_create();
	name = _name;
    type = "statemachine";
    #endregion ////////////////////////////////////////////////
    
	#region public functions//////////////////////////////////
	Step = function(){
        Exe_Active_Children(self);
    };
    
    WakeUp = function(){
        var _valid = Exe_Set_Flow_Chart(transesDefault);
        if(( _valid == false)&& (decomposition == "AND")){
            var _len = array_length(states);
            for(var _i=0; _i<_len; _i++){
                Enter_State(states[_i]);
            }
            return;
        }
        else{
            show_debug_message("Lack of Entry Action");
        }
    }
    #endregion //////////////////////////////////////////////////
    
    #region private functions/////////////////////////////////
    Exe_Active_Children = function(_node, _event = -1){
        var _lenStates = array_length(_node.states);
        if(_lenStates == 0){
            show_error("Err: Statemachine("+ name +") has no states.", true);
            return;
        }

        switch(decomposition){
        case "AND":
            for(var _i=0; _i<_lenStates; _i++){
                Exe_Active_State(states[_i],_event);
            }
            break;
        case "OR":
            for(var _i=0; _i<_lenStates; _i++){
                if(states[_i].isActive){
                    Exe_Active_State(states[_i],_event);
                    break;
                }
            }
            break;
        default:
            show_debug_message("Err: Statemachine("+ _name +") has no active states.");
        }
    }

    Exe_Active_State = function(_state,_event){
        var _isValidTrans = Exe_Set_Flow_Chart(_state.transesOuter, _event);
        if(_isValidTrans==true){return;}
        
        var _earlyReturn = DoDu(_state);
        if(_earlyReturn){return;}
        
        var _validTransInner = Exe_Flow_Charts(_state.transesInner, _event);
        if(_validTransInner){Exe_Active_Children(_state, _event);}
        
        return;
    }

    Do_Actions = function(_actions){
        var _len = array_length(_actions);
        var _earlyReturn = false;
        for(var _i=0; _i<_len; _i++){
            _earlyReturn = _actions[_i].contents();
            if((_actions[_i].type == "SEND")&&(_earlyReturn == true)){return true;}
        }
        return false;
    }
    
    static Get_States_Brother = function(_state){return _state.parent.states;}
    
    static Get_State_Brother_Prev = function(_state){
        var _len = array_length(_state.parent.states);
        if(0 ==_len){
            show_error("illegal length",true);
        }else if(1 ==_len){
            return -1;//only self
        }
        else{
            var _brothers = Get_States_Brother(_state);
            for(var _i=0; _i<_len; _i++){
                if(_brothers[_i] == _state){
                    if(_i == 0){
                        return -1;//self is 1st brother
                    }
                    else{
                        return _brothers[_i-1];//return previous brother
                    }
                }
            }
        }
    }
    
    static Get_Id_State_Brother = function(_state){
        var _len = array_length(_state.parent.states);
        if(0 ==_len){
            show_error("Err: illegal length", true);
        }
        else if(1 ==_len){
            return 0;
        }
        else{
            var _brothers = Get_States_Brother(_state);
            for(var _i=0; _i<_len; _i++){
                if(_brothers[_i] == _state){
                    return _i;//return self's order in brothers
                }
            }
        }
    }
    
    static Get_Decomposition_Parent = function(_state){return _state.parent.decomposition;}
    
    static Get_State_Brother_Next = function(_state){
        var _len = array_length(_state.parent.states);
        if(0 == _len){
            show_error("Err: no brothers", true);
        }
        else if(1 == _len){
            return -1;
        }
        else{
            var _brothers = Get_States_Brother(_state);
            for(var _i = 0; _i<_len; _i++){
                if(_brothers[_i]== _state){
                    if(_i == _len -1){
                        return -1;
                    }
                    else{
                        return _brothers[_i];
                    }
                }
            }
            show_error("Err: out of array", true);
        }
    }
    
    #region Enter State Steps START ////////////
    Enter_State_Steps = array_create(8);
    Enter_State_Steps[0] = function(_state){
        for(var _i=1; _i<8; _i++){
            Enter_State_Steps[_i](_state);
        }
    }
    
    Enter_State_Steps[1] = function(_state){
        var _parent = _state.parent;
        if(_parent.isActive == false){
            Enter_State_Steps[1](_parent);
            Enter_State_Steps[2](_parent);
            Enter_State_Steps[3](_parent);
            Enter_State_Steps[4](_parent);
        }
    }
    
    Enter_State_Steps[2] = function(_state){
        if("AND" == Get_Decomposition_Parent(_state)){
            var _stateCurrent = _state;
            var _brother = Get_State_Brother_Prev(_stateCurrent);
            while(1){
                if(_brother == -1){break;}
                else if(_brother.isActive){_stateCurrent = _brother;}
                else{
                    Enter_State_Steps[1](_brother);
                    Enter_State_Steps[2](_brother);
                    Enter_State_Steps[3](_brother);
                    Enter_State_Steps[4](_brother);
                    Enter_State_Steps[5](_brother);
                }
            }
        }
    }
    
    Enter_State_Steps[3] = function(_state){
        _state.isActive = true;
    }
    
    Enter_State_Steps[4] = function(_state){
        var _earlyReturn = DoEn(_state);
        return _earlyReturn;
    }
    
    Enter_State_Steps[5] = function(_state){
        var _len = array_length(_state.states);
        var _deco = _state.decomposition;
        if(0 == _len){return;}
        else if(1 == _len){_state.states[0].isActive = true;}
        else if(_deco =="OR"){Exe_Set_Flow_Chart(_state.transesDefault);}
        else if(_deco =="AND"){
            for(var _i=0; _i<_len; _i++){
                var _st;
                _st = _state.states[_i];
                Enter_State_Steps[1](_st);
                Enter_State_Steps[2](_st);
                Enter_State_Steps[3](_st);
                Enter_State_Steps[4](_st);
                Enter_State_Steps[5](_st);
            }
        }
        else{show_error("Err:illegal deco",true);}
    }
    
    Enter_State_Steps[6] = function(_state){
        var _deco = Get_Decomposition_Parent(_state);
        var _brother = Get_State_Brother_Next(_state);
        if((_deco == "AND")
        &&(_brother != -1))//not exist next brother
        {
            Enter_State(_brother);
            return;
        }
        
    }
    
    Enter_State_Steps[7] = function(_state){
        var _parent = _state.parent;
        if(_state.parentTransPath != _parent){
            Enter_State_Steps[6](_parent);
            Enter_State_Steps[7](_parent);
        }
    }
    
    Enter_State = Enter_State_Steps[0];
    #region Enter State Steps END //////////////
    
    Exe_Set_Flow_Chart = function(_transes, _event = -1){
        var _transesCurrent = _transes;
        var _breakWhile = false;
        var _step = 1;
        var _pathTrans = array_create();
        var _idTranses, _transCurrent, _isValidTrans, _isValidEvent, _earlyReturn, _lastPath
        var _stateParentPath, _childrenExit;
        while(_breakWhile == false){
            switch(_step){
            case 1:
                //set _transesCurrent
                _idTranses = -1;
                _step = 2;
                //FALLTHROUGH
            case 2:
                _idTranses++;
                _transCurrent = _transesCurrent[_idTranses];
                _step = 3;
                //FALLTHROUGH
            case 3:
                _isValidTrans = _transCurrent.Condition();
                if(_event!= -1){
                    _isValidEvent = Check_Event_Trans(_transCurrent, _event);
                    _isValidTrans = _isValidTrans && _isValidEvent;
                }
                _step = 4;
                //FALLTHROUGH
            case 4:
                if(_isValidTrans){
                    _earlyReturn = _transCurrent.ConditionAction();
                    if(_earlyReturn ==true){return;}
                    array_push(_pathTrans,_transCurrent);
                    _step = 5;
                    //FALLTHROUGH
                }
                else{
                    if(_idTranses == array_length(_transesCurrent)-1){
                        _step = 2;
                        break;
                    }
                    else{
                        if(_transesCurrent == _transes){//last trans of initial set,stop evaluation
                            _breakWhile = true;
                            break;
                        }
                        else{//is last trans of set,backtracking according to path
                            _lastPath = array_pop(_pathTrans);
                            _transesCurrent = _lastPath.src.states;
                            _idTranses = Array_Find_Index_Ele(_transesCurrent,_lastPath);
                            _step = 2;
                            break;
                        }
                    }
                }
                
            case 5:
                if(_transCurrent.dest.type == "state"){
                    _breakWhile = true;
                    _transCurrent.dest.pathTrans = _pathTrans;//back trans path
                    _stateParentPath = Get_State_Parent_Trans_Path(_pathTrans);
                    _childrenExit = Get_State_Active_Children(_stateParentPath);
                    
                }
            
            }
        }
    }

    DoEn = function(_state){}
    DoDu = function(_state){}
    DoEx = function(_state){}
    #endregion ///////////////////////////////////////////////
}

function state(_name) constructor{
    name = _name;
    type = "state";
    parent = -1;
    states = array_create();
    actionsEn = array_create();
    actionsDu = array_create();
    actioneEx = array_create();
    tick = 0;
    decomposition = "OR";
    transesDefault = array_create();
    transesOuter = array_create();
    transesInner = array_create();
    parentTransPath = -1;
    pathTrans = array_create();
}

function transition(_name) constructor{
    name = _name;
    type = "transition";
    Condition = function(){return true;};
    actionsCondition = array_create();
    actionsTransition = array_create();
    src = -1;
    dest = -1;
}

function junction(_name) constructor{
    name = _name;
    type = "junction";
    src = -1;
    dest = -1;
    transOuter = array_create();
}

function Add_Action(_actions,_function){
    array_push(_actions.contents,_function);
    array_push(_actions.type,"FUNC");
}

function Add_Send(_actions, _event,_state){
    array_push(
        _actions.contents,
        function(){Send_Event(_event,state);}
    );
    array_push(_actions.type,"SEND");
}

function Send_Event(_event, _state){//not public for developers
    if(_state.isActive == false){return false;}
    
    Exec_Active_State(_state, _event);
    
    var _earlyReturn = !(_state.isActive);
    return _earlyReturn;
}


#endregion  ////////////////////////////////////////////////////////////










