/// @desc 
#region generate statemachine

transToX = new transition();
transToX.Condition = function(){
    return keyboard_check_pressed(ord("X"));
}
transToX.ConditionAction = function(){
    inst_trans.Emit("X, ->", 60*5);
}

transToZ = new transition();
transToZ.Condition = function(){
    return keyboard_check_pressed(ord("Z"));
}
transToZ.ConditionAction = function(){
    inst_trans.Emit("Z, <-", 60*5);
}

waitingZ = new state();
waitingZ.En = function(){
    inst_z.Emit("En", 60*5);
}
waitingZ.Du = function(){
    inst_z.Emit("Du", 60*5);
}
waitingZ.Ex = function(){
    inst_z.Emit("Ex", 60*5);
}

waitingX = new state();
waitingX.En = function(){
    inst_x.Emit("En", 60*5);
}
waitingX.Du = function(){
    inst_x.Emit("Du", 60*5);
}
waitingX.Ex = function(){
    inst_x.Emit("Ex", 60*5);
}

Link_States_Trans(waitingZ,transToX,waitingX);
Link_States_Trans(waitingX,transToZ,waitingZ);

sm = new statemachine();
array_push(sm.states,waitingZ,waitingX);
array_push(sm.trans, transToX,transToZ);
sm.Init_State();

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