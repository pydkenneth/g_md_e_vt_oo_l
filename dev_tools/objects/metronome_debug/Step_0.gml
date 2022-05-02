/// @desc 
CHECK_DEBUG_SWITCH

//WARNING : DO NOT EDIT ALL CODE BELOW
Detect_Mouse_Click();

if(!prv.isStepping){return;}

//advance step
prv.stepCurrent +=1;
if(period <= prv.stepCurrent){
    prv.stepCurrent = 0;
    Do_PeriodAction();
}
