function statemachine() constructor{//DO NOT EDIT
    decomposition = "OR";
    states = array_create();
    transesDefault = array_create();
    Step = function(){
        Exe_Active_Children(self);
    };
    Exe_Active_Children = function(_node, _event = -1){
        if(array_length(_node.states)== 0){
            //err
            show_debug_message()
        }
    }
}

function state() constructor{
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
}

function ReturnTrue(){return true;}

function transition() constructor{
    Condition = ReturnTrue;
    actionsCondition = array_create();
    actionsTransition = array_create();
    src = -1;
    dest = -1;
}

function junction() constructor{
    src = -1;
    dest = -1;
    transOuter = array_create();
}

