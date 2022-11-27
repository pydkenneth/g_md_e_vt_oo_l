/// @desc 
#region generate statemachine
/*
machine = new statemachine();

stateSrc = new state();

stateDest = new state();

transToDest = new transition();
transToDest.Set_Src(stateSrc);
transToDest.Set_Src()
transToSrc = new transition();


array_push(machine.states, stateSrc);
array_push(machine.states, stateDest);
array_push(machine.trans, trans1);
*/
#endregion


#region test struct
me = "intObj"
struct = {
    x:456,
    y:123,
    me: "instStruct1",
    Draw_Me : function(){
        draw_text(50,0,me);//instStruct
    },
    Draw_Me_Self : function(){
        draw_text(50, 50, self.me);//instStruct
    },
    Draw_Me_Other : function(){
        draw_text(50, 100, other.me);//intObj
    },
    
    inner_struct:{
        me: "inst inner",
        Draw_Me : function(){
            draw_text(250,0,me);//inst inner
        },
        Draw_Me_Self : function(){
            draw_text(250, 50, self.me);//inst inner
        },
        Draw_Me_Other : function(){
            draw_text(250, 100, other.me);//intObj
        }
    }
};
struct2 = {
    me: "instStruct2",
    Draw_Me : function(){
        draw_text(350, 0, me);
    }
}

structs[0]=struct;
structs[1]=struct2;

with(structs[0]){
    Draw_Me = function(){
        me = "structs[0]";
        draw_text(50, 150, me);
    }
}

with(structs[1]){
    Draw_Me = function(){
        me = "structs[0]";
        draw_text(350,0,me);
    }
}

with(struct){//region in struct
    Draw_Me = function(){//function belong to struct
        me = "with(struct)";//assign to struct.me
        draw_text(50,150,me);
    }
}


#endregion