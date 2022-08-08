function linker_dev() constructor{
    links = array_create();
    links[0] = [-1,-1,-1,-1];
    length = 0;
    
    static Add_Link = function(_sub, _varSub, _obs, _varObs){
        var _i =0;
        if(length == 0){
            _i = 0;
        }
        else{
            _i = array_length(links);
        }
        links[_i][0]=_sub;
        links[_i][1]=_varSub;
        links[_i][2]=_obs;
        links[_i][3]=_varObs;
        length++;
    }

    static Del_Link = function(_sub, _varSub, _obs, _varObs){
        if(length==0){return;}
        for(var _i = length-1; _i>=0; _i--){
            if((links[_i][0] == _sub)&&
            (links[_i][1]==_varSub)&&
            (links[_i][2]==_obs)&&
            (links[_i][3]==_varObs)){
                array_delete(links, _i, 1);
                length--;
            }
        }
    }

    static Del_Subject = function(_sub){
        if(length==0){return;}
        for(var _i = length-1; _i>=0; _i--){
            if(links[_i][0] == _sub){
                array_delete(links, _i, 1);
                length--;
            }
        }
    }
    
    static Del_Observer = function(_obs){
        if(length==0){return;}
        for(var _i = length-1; _i>=0; _i--){
            if(links[_i][2] == _obs){
                array_delete(links, _i, 1);
                length--;
            }
        }
    }

    static Update = function(){
        if(length==0){return;}
        var _sub, _varSub, _obs, _varObs, _data;
        for(var _i = 0; _i<self.length; _i++){
            _sub = links[_i][0];_varSub = links[_i][1]; _obs = links[_i][2];_varObs = links[_i][3];
            if(instance_exists(_sub)&&
            instance_exists(_obs)&&
            variable_instance_exists(_sub,_varSub)&&
            variable_instance_exists(_obs,_varObs)){
                _data = variable_instance_get(_sub,_varSub);
                variable_instance_set(_obs,_varObs,_data);
            }
        }
    }
}
