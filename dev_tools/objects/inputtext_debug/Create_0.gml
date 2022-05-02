/// @desc 
prv = {
    width : 96,
    height : 24,
    c_Self : c_dkgray,
    c_Outline : c_green,
    DELAY_DELETE : -30, //NOT RECOMMAND for edit
    lengthMaxString : 200,
    posSelf : [0,0,0,0],
    keyEnter : vk_enter,
    keyClose : vk_escape,
}

//initializing, DO NOT EDIT
prv.posSelf[0] = x;
prv.posSelf[1] = y;
prv.posSelf[2] = x + prv.width;
prv.posSelf[3] = y + prv.height;
target = {
    instance_id : -1,
    name : "name",
    nameStruct : "", //leave it blank, like this "" , if your data path not pass a struct
    //NOTICE, this tool only support 1 stack of struct, if you need to access multi-stack struct, you have to modify Close_And_Send()
}

//DO NOT EDIT
function Close_And_Send(){
    //close and send string
    if(keyboard_check_pressed(prv.keyEnter)){
        //set target instance's variable
        if(target.nameStruct == ""){
            variable_instance_set(target.instance_id, target.name, stringEntering);
        }
        else{
            var _targetId = target.instance_id;
            var _nameVariable = target.name;
            var _nameStruct = target.nameStruct;
            var _value = stringEntering;
            with(_targetId){
                var _struct = variable_instance_get(id, _nameStruct);   //pull the whole struct
                variable_struct_set(_struct, _nameVariable, _value);    //modify the temp struct
                variable_instance_set(id, _nameStruct, _struct);    //overwrite original struct with temp one
            }
        }
        instance_destroy();
    }
    else if(keyboard_check_pressed(prv.keyClose)){
        instance_destroy();
    }
    else if(!point_in_rectangle(mouse_x, mouse_y, prv.posSelf[0], prv.posSelf[1], prv.posSelf[2], prv.posSelf[3])
    && (mouse_check_button_pressed(mb_any))){
        if(needAbsorbMouse == true){
            needAbsorbMouse = false;
        }
        else{
            instance_destroy();
        }
    }
}

//DO NOT EDIT: for State_Commands
function ReceivingInput(){
    //receive letters
    if(keyboard_check(vk_anykey) && !keyboard_check(vk_backspace) && string_length(stringEntering)<prv.lengthMaxString){  //entering text
        stringEntering = stringEntering + string(keyboard_string);
        keyboard_string = "";
    }
    else if(keyboard_check_pressed(vk_backspace)){  //delete 1 character
        stringEntering = string_delete(stringEntering,string_length(stringEntering),1);
        keyboard_string = "";
        delete_timer = prv.DELAY_DELETE;
    }
    else if(keyboard_check(vk_backspace) && !keyboard_check_pressed(vk_backspace) && delete_timer == 2){  //delete by hodling backspace
        stringEntering = string_delete(stringEntering, string_length(stringEntering),1);
        keyboard_string = "";
        delete_timer = 0;
    }

    if(delete_timer != 2){ delete_timer++; }    //Handle Timer Update
}

//Initializing, DO NOT EDIT
stringEntering = "";    //input buffer for user
delete_timer = 2;

if(mouse_check_button_pressed(mb_any)){
    needAbsorbMouse = true;
}