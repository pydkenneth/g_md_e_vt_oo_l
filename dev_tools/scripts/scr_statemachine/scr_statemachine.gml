//WARNING: You should NOT modify script below.
//design graph: simple_statemachine_frame.graphml
//ref: stateflow user guide 2017b
//NOTICE: You should NOT edit this script except a bug exists.
#region Public Constructors & Functions////////////////////////////////
function statemachine(_name) constructor{
    #region attributes////////////////////////////////////////
	decomposition = "OR";
    states = array_create();
    junctions = array_create();
    transesDefault = array_create();
	name = _name;
    type = "statemachine";
    #endregion ////////////////////////////////////////////////
    
	#region public functions//////////////////////////////////
	Step = function(){
        Exe_Active_Children(self);
    };
    
    WakeUp = function(){
        var _valid = false;
        
        if(0 < array_length(transesDefault)){
            Exe_Set_Flow_Chart(transesDefault);
        }

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

    function Send_Event(_event, _state){//NOTICE: not public for developers
        if((_state.type == "state")&&(_state.isActive == false)){return false;}
    
        Exe_Active_State(_state, _event);
    
        var _earlyReturn = !(_state.isActive);
        return _earlyReturn;
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
        if((_parent.type == "state")
        && (_parent.isActive == false)){
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
        var _earlyReturn = Do_Actions_Entry(_state);
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
    #endregion Enter State Steps END //////////////
    
    Exe_Set_Flow_Chart = function(_transes, _event = -1){
        var _transesCurrent = _transes;
        var _evaluating = true;
        var _step = 1;
        var _pathTrans = array_create();
        var _idTranses, _transCurrent, _isValidTrans, _isValidEvent, _earlyReturn, _lastPath
        var _stateParentPath, _childrenExit;
        while(_evaluating){
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
                    array_push(_pathTrans,_transCurrent);
                    _earlyReturn = Do_Actions_Condition(_transCurrent, _pathTrans);
                    if(_earlyReturn ==true){return;}
                    _step = 5;
                    //FALLTHROUGH
                }
                else{
                    while(1){
                        if(_idTranses == array_length(_transesCurrent)-1){//last trans in transes set
                            if(_transesCurrent == _transes){//is the initial transes set tested
                                _evaluating = false;
                                break;
                            }
                            else{//bracktracking
                                _lastPath = array_pop(_pathTrans);
                                _transesCurrent = _lastPath.src.transes;
                                _idTranses = Array_Find_Index_Ele(_transesCurrent, _lastPath);
                            }
                        }
                        else{//test next trans in transes set
                            _step = 2;
                            break;
                        }
                    }
                    break;
                }
                
            case 5:
                if(_transCurrent.dest.type == "state"){
                    _evaluating = false;
                    _transCurrent.dest.pathTrans = _pathTrans;//back trans path
                    _stateParentPath = Get_State_Parent_Trans_Path(_pathTrans);
                    _childrenExit = Get_State_Active_Children(_stateParentPath);
                    var _iChildrenExit;
                    var _lenChildrenExit = array_length(_childrenExit);
                    for(_iChildrenExit=0; _iChildrenExit<_lenChildrenExit; _iChildrenExit++){
                        _earlyReturn = Do_Actions_Exit(_childrenExit[_iChildrenExit]);
                        if(_earlyReturn){return;}
                    }
                    var _lenTransPath;
                    _lenTransPath = array_length(_pathTrans);
                    
                    _earlyReturn = Do_Actions_Transition(_pathTrans[_lenTransPath-1], _pathTrans);
                    if(_earlyReturn){return;}
                    Enter_State(_transCurrent.dest);
                    break;
                }
                _step = 6;
                //FALLTHROUGH
                
            case 6:
                if((_transCurrent.dest.type == "junction")
                &&(0 == array_length(_transCurrent.dest.transesOutgoing))){
                    _breakWhile = true;
                    break;
                }
                _step = 7;
                //FALLTHROUGH
                
            case 7:
                _transesCurrent = _dest.transes;
                _step = 1;
                break;
            }
        }
    }
    
    static Get_State_Parent_Trans_Path = function(_pathTrans){
        var _parents = array_create();
        var _i,_len;
        _len=array_length(_pathTrans);
        for(_i=0; _i<_len; _i++){
            array_push(_parents,_pathTrans[_i].src.parent);
            array_push(_parents,_pathTrans[_i].dest.parent);
        }
        
        var _parentHigher = _parents[0];
        _len = array_length(_parents);
        for(var _i = 1;_i<_len;_i++){
            _parentHigher = Get_Higher_Parent(_parentHigher,_parents[_i]);
        }
        return _parentHigher;
    }

    static Get_Higher_Parent = function(_p1,_p2){
        if(_p1==_p2){return _p1;}
        var _branch1 = Get_Family_Branch(_p1);
        var _len1 = array_length(_branch1);
        var _branch2 = Get_Family_Branch(_p2);
        var _len2 = array_length(_branch2);
        var _parentCommon;
        for(var _i = 0; (_i<=_len1-1)&&(_i<_len2-1)&&(_branch1[_i] == _branch2[_i]);_i++){
            _parentCommon = _branch1[_i];
        }
        
        return _parentCommon;
    }
    
    static Get_Family_Branch = function(_node){
        var _branch = array_create();
        var _nodeCurrent = _node;
        while(_nodeCurrent.type != "statemachine"){
            array_push(_branch,_nodeCurrent);
            _nodeCurrent = _nodeCurrent.parent;
        }
        array_push(_branch,_nodeCurrent);
        return array_reverse(_branch);
    }
    
    static Get_State_Active_Children = function(_stateParentPath){
        var _parent = _stateParentPath;
        if(0 == array_length(_parent.states)){return [ ];}
        
        var _childrenActive = array_create();
        var _len = array_length(_parent.states);
        for(var _i = 0; _i<_len; _i++){
            if(_parent.states[_i].isActive == true){
                array_push(_childrenActive,_parent.states[_i]);
            }
        }
        return _childrenActive;
    }

    Do_Actions_Entry = function(_state){
        _state.tick = 1;
        var _earlyReturn = false;
        var _len = array_length(_state.actionsEn);

        if(_len == 0){//no action
            _earlyReturn = false;
            return _earlyReturn;
        }

        for(var _i=0; _i<_len; _i++){
            _state.actionsEn[_i]();
            if((_state.type == "state")&&(_state.isActive == false)){
                _earlyReturn = true;
                break;
            }
        }

        return _earlyReturn;
    }
    
    Do_Actions_During = function(_state){
        _state.tick++;
        
        var _earlyReturn = false;
        var _len = array_length(_state.actionsDu);

        if(_len == 0){//no action
            _earlyReturn = false;
            return _earlyReturn;
        }

        for(var _i=0; _i<_len; _i++){
            _state.actionsDu[_i]();
            if((_state == "state")&&(_state.isActive == false)){
                _earlyReturn = true;
                break;
            }
        }

        return _earlyReturn;
    }
    
    Do_Actions_Exit = function(_state){
        _state.tick = 0;
        
                var _earlyReturn = false;
        var _len = array_length(_state.actionsEx);

        if(_len == 0){//no action
            _earlyReturn = false;
            return _earlyReturn;
        }

        for(var _i=0; _i<_len; _i++){
            _state.actionsEx[_i]();
            if((_state.type == "state")&&(_state.isActive == false)){
                _earlyReturn = true;
                break;
            }
        }

        return _earlyReturn;
    }
    
    Do_Actions_Condition = function(_trans, _pathTrans){
        //If the origin state of the inner or outer flow chart 
        if(_pathTrans[0].isDefault == false){
            var _state = _pathTrans[0].src;
        }
        //or parent state of the default flow chart
        else if(_pathTrans[0].isDefault == true){
            var _state = Get_State_Parent_Trans_Path(_pathTrans);
        }

        var _len = array_length(_trans.actionsCondition);
        if(_len == 0){//no action
            _earlyReturn = false;
            return _earlyReturn;
        }

        for(var _i=0; _i<_len; _i++){
            _trans.actionsCondition[_i]();
            if((_state.type == "state")&&(_state.isActive == false)){//are no longer active at the end of the event broadcast
                _earlyReturn = true;//the chart does not perform remaining steps for executing the flow chart.
                break;
            }
        }
        return _earlyReturn;
    }
    
    Do_Actions_Transition = function(_trans, _pathTrans){
        var _earlyReturn = false;
        var _state = Get_State_Parent_Trans_Path(_pathTrans);
        if((_state.type == "state") && (_state.isActive == false)){//If the parent of the transition path is not active
            _earlyReturn = true;//the chart does not perform remaining transition actions and state entry actions.
            return _earlyReturn;
        }

        var _len;
        _len = array_length(Get_State_Active_Children(_state));// or if that parent has an active child
        if(0<_len){
            _earlyReturn = true;//the chart does not perform remaining transition actions and state entry actions.
            return _earlyReturn;
        }

        _earlyReturn = false;
        
        _len = array_length(_trans.actionsTransition);
        if(_len == 0){//no action
            _earlyReturn = false;
            return _earlyReturn;
        }

        for(var _i=0; _i<_len; _i++){
            _trans.actionsTransition[_i]();
            if((_state.type == "state")&&(_state.isActive == false)){//are no longer active at the end of the event broadcast
                _earlyReturn = true;//the chart does not perform remaining steps for executing the flow chart.
                break;
            }
        }
        
        return _earlyReturn;
    }
    #endregion ///////////////////////////////////////////////
}

function state(_name) constructor{
    name = _name;
    isActive = false;
    type = "state";
    parent = -1;
    states = array_create();
    junctions = array_create();
    actionsEn = array_create();
    actionsDu = array_create();
    actionsEx = array_create();
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
    isDefault = false;
    Condition = function(){return true;}
    events = array_create();
    actionsCondition = array_create();
    actionsTransition = array_create();
    src = -1;
    dest = -1;
}

function Trans_Set_Condition(_trans,_cond){
    if(is_method(_cond)||script_exists(_cond)){
        _trans.Condition = _cond;
    }
    else{
        show_error("Err: _cond is not a method or script function", true);
    }
}

function Trans_Add_Event(_trans,_event){
        if(is_string(_event)){
            array_push(_trans.events,_event);
        }
        else{
            show_error("Err: Add_Event, _event is not a string.",true);
        }
}

function junction(_name) constructor{
    name = _name;
    type = "junction";
    transesOuter = array_create();
    parent = -1;
}

function Add_Action(_actions,_function){
    array_push(_actions.contents,_function);
    array_push(_actions.type,"FUNC");
}

function Add_Send(_statemachine, _actions, _event,_state){
    array_push(
        _actions.contents,
        function(){_statemachine.Send_Event(_event,state);}
    );
    array_push(_actions.type,"SEND");
}



function after(_state, _n, _unit = "tick"){
    if(_state.type!="state"){show_error("Err: input is not a state.",true);}
    if(_state.isActive == false){return false;}
    var _t = _state.tick;
    switch(_unit){
        default:
        case "tick":
            if(_n < _t){
                return true;
            }
            else{
                return false;
            }
        case "sec":
            if(_n * game_get_speed(gamespeed_fps) < _t){
                return true;
            }
            else{
                return false;
            }
    }
}

function Add_Child(_parent, _child){
    if((_parent.type == "statemachine")||(_parent.type == "state")){
        if(_child.type == "state"){
            array_push(_parent.states,_child);
            _child.parent = _parent;
        }
        else if(_child.type == "junction"){
            array_push(_parent.junctions,_child);
            _child.parent = _parent;
        }
        else{
            show_error("Err: Illegal child type.",true);
        }
    }
    else{
        show_error("Err: Illegal parent type.",true);
    }
}

function Link_Transition(_src, _trans, _dest, _isDefault = false){
    if(_isDefault){
        var _t = _src.type;
        if((_t!="state")&&(_t!="statemachine")){show_error("Err: Link, _src is not a state/statemachine",true);}
        if(_dest.type!="state"){show_error("Err: Link, _dest is not a state",true);}
        _trans.src = _src;
        _trans.dest = _dest;
        array_push(_src.transesDefault,_trans);
    }
    else{
        if((_src == _dest)
        ||(Check_Ischild(_src, _dest))){//inner transition
            _trans.src = _src;
            _trans.dest = _dest;
            array_push(_src.transesInner,_trans);
        }
        else{//outer transition
            _trans.src = _src;
            _trans.dest = _dest;
            array_push(_src.transesOuter,_trans);
        }
    }
}

function Check_Ischild(_parent, _child){
    if(_parent == _child){return 1;}
    if(_parent.type == "state"){
        if(_child.type == "state"){
            //collect all children
            var _childrenState = Get_State_Children(_parent);
            
        }
        else if(_child.type == "junction"){
            var _childrenJunc = Get_Junction_Children(_parent);
        }
        else{
            show_error("Err: Illegal _child.",true);
        }
    }
    else{
        show_error("Err: Illegal _parent.",true);
    }
}

function Get_State_Children(_parent){
    if((_parent.type == "statemachine") || (_parent.type == "state")){
        var _children = array_create();
        var _p = _parent;
        _children = array_union(_children,_p.states);
        var _lenChildren = array_length(_children);
        var _i = 0;

        while(_i<_lenChildren){
            _p = _children[_i];
            if(0<array_length(_p.states)){
                _children = array_union(_children, _p.states);
                _lenChildren = array_length(_children);
                _i ++;
            }
        }
        
        return _children;
    }
    else{
        show_error("Err: Illegal _parent type.", true);
    }
}

function Get_Junction_Children(_parent){
    if((_parent.type == "statemachine") || (_parent.type == "state")){
        var _childrenState = Get_State_Children(_parent);
        var _len = array_length(_childrenState);
        var _childrenJunc = array_create();
        
        for(var _i = 0; _i<_len; _i++){
            var _junc = array_create();
            _junc = _childrenState[_i].junctions;
            if(0<array_length(_junc)){
                _childrenJunc = array_union(_childrenJunc, _junc);
            }
        }
        
        return _childrenJunc;
    }
    else{
        show_error("Err: Illegal _parent type.", true);
    }
}

#endregion  ////////////////////////////////////////////////////////////

