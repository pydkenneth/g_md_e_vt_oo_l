function Create_Playcard_Stage3(){
    var _inst = instance_create_depth(x,y,depth,placard_dev);
    with(_inst){
        alignX = "MIDDLE";
        alignY = "ABOVE";
        text = "I Love You.";
        visible = false;
        VisibleCondition = inst.IsPlayerNear;
    }
}