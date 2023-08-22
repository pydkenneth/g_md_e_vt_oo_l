Check_Printer_StateText();

switch(prv.state){
default:
case "Waiting_Release":
    if(Check_Button_Released()){
        prv.state = "Released";
    }
    break;
case "Released":
    if(Check_Button_Pressing()){
        prv.state = "Pressing";
        alarm_set(0,delayHold);
    }
    break;
case "Pressing":
    if(Check_Button_Released()){
        prv.state = "Released";
        ActionReleased();
    }
    break;
}

if(prv.state!="Pressing"){
    alarm_set(0,-1);
}