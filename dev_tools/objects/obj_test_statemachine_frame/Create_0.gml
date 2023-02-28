/// @desc 

/*
//generate statemachine, states, transitions, junction
test_case = new statemachine("test_case");
test_case.decomposition = "AND";

AND1 = new state("AND1");
tAND1d1 = new transition("tAND1d1");
tAND1d1.Condition = function(){return true;}
tAND1d2 = new transition("tAND1d2");
tAND1d2.Condition = function(){return false;}

AND1OR1 = new state("AND1OR1");
AND1OR2 = new state("AND1OR2");
tAND1OR2out1 = new transition("tAND1OR2out1");
Trans_Set_Condition(tAND1OR2out1,function(){return keyboard_check_pressed(ord("A"));});
jAND1OR2out = new junction("jAND1OR2out");
tAND1OR2out2 = new transition("tAND1OR2out2");
Trans_Add_Event(tAND1OR2out2,"E_AND1OR2_To_AND1OR3");
tAND1OR2in1 = new transition("tAND1OR2in1");
Trans_Set_Condition(tAND1OR2in1, function(){return keyboard_check_pressed(ord("D"));});
AND1OR3 = new state("AND1OR3");
tAND1OR3out1 = new transition("tAND1OR3out1");
Trans_Set_Condition(tAND1OR3out1, function(){return after(AND1OR3, 10);});

#region AND2
AND2 = new state("AND2");
tAND2d1 = new transition("tAND2d1");
tAND2in1 = new transition("tAND2in1");
tAND2in2 = new transition("tAND2in2");
tAND2in3 = new transition("tAND2in3");
AND2OR1 = new state("AND2OR1");
tAND2OR1out1 = new transition("tAND2OR1out1");
tAND2OR1out2 = new transition("tAND2OR1out2");
tAND2OR1d1 = new transition("tAND2OR1d1");
tAND2OR1in1 = new transition("tAND2OR1in1");

AND2OR1OR1 = new state("AND2OR1OR1");

AND2OR1OR2 = new state("AND2OR1OR2");

AND2OR2 = new state("AND2OR2"); AND2OR2.decomposition = "AND";
AND2OR2AND1 = new state("AND2OR2AND1");
AND2OR2AND1OR1 = new state("AND2OR2AND1OR1");
AND2OR2AND1OR2 = new state("AND2OR2AND1OR2");
AND2OR2AND1OR3 = new state("AND2OR2AND1OR3");
AND2OR2AND2 = new state("AND2OR2AND2");
AND2OR2AND2OR1 = new state("AND2OR2AND2OR1");
AND2OR2AND2OR2 = new state("AND2OR2AND2OR2");

#endregion AND2

#region AND3
AND3 = new state("AND3");
AND3OR1 = new state("AND3OR1");
AND3OR2 = new state("AND3OR2");
#endregion AND3

#region assign hierarchy of statemachine & states
Add_Child(test_case, AND1);
Add_Child(test_case, AND2);
Add_Child(test_case, AND3);
Add_Child(AND1, AND1OR1);
Add_Child(AND1, AND1OR2);
Add_Child(AND1, AND1OR3);
Add_Child(AND1, jAND1OR2out);
#endregion assign hierarchy of statemachine & states

//link transistions
Link_Transition(AND1, tAND1d1, AND1OR1, true);
Link_Transition(AND1, tAND1d2, AND1OR2, true);
Link_Transition(AND1OR2, tAND1OR2out1, jAND1OR2out);
Link_Transition(AND1OR2, tAND1OR2out2, AND1OR3);
Link_Transition(AND1OR2, tAND1OR2in1, AND1OR2);
Link_Transition(AND1OR3, tAND1OR3out1, AND1OR1);

//wakeup statemachine
test_case.WakeUp();
*/

//generate statemachine, states, transitions, junction
sm = new statemachine("sm");
tSmD1 = new transition("tSmD1");
or1 = new state("or1");
or2 = new state("or2");
tOr1Or2 = new transition("tOr1Or2");
Trans_Set_Condition(tOr1Or2, function(){return keyboard_check_pressed(ord("A"));});
tOr2Or1 = new transition("tOr2Or1");
Trans_Set_Condition(tOr2Or1, function(){return keyboard_check_pressed(ord("D"));});

//assign hierarchy of statemachine & states
Add_Child(sm,or1);
Add_Child(sm,or2);

//link transistions
Link_Transition(sm, tSmD1, or1, true);
Link_Transition(or1, tOr1Or2, or2);
Link_Transition(or2, tOr2Or1, or1);

//wakeup statemachine
sm.WakeUp();