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
    with(self){
        inst_z.Emit("En", 60*5);
        var _id = other;
        var _self = self;
        return;
    }
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
me = "instObj"
foo = function(){
    inst_self.Emit("Self:" + self.me);
    inst_other.Emit("Other:" + other.me);
}
struct = {
    me: "instStruct",
    instObj:-1,
    foo : function(){
        inst_self.Emit("Self:" + self.me);
        inst_other.Emit("Other:" + other.me);
        },
    callfoo:-1,
    innerstruct:{
        me: "innerstruct",
        instObj:-1,
        foo : function(){
        inst_self.Emit("Self:" + self.me);
        inst_other.Emit("Other:" + other.me);
        }
    }
};
innerstruct = struct.innerstruct;
struct.instObj = self;
struct.innerstruct.instObj = self;
struct.callfoo = struct.foo;

/*
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
*/

#endregion