/// @desc 
prv = {
    name : "LIST_NAME",
    width : 96,
    heightTitle: 24,
    heightLine : 48,
    numCell_Page : 5,
    c_Title : c_green,
    c_Outline : c_yellow,
    buttonMode : true, //add for curve ui
    
    target : -1,
    mb_Close : mb_middle
}

function Update_Info_Page(){
    var _len = array_length(strings);
    if(numCell_Total== _len){return;}
    
    numCell_Total = array_length(strings);
    pageTotal = floor(numCell_Total / prv.numCell_Page);
    var _remainder = numCell_Total % prv.numCell_Page;
    if(_remainder == 0){
        numCell_LastPage = prv.numCell_Page;
    }
    else{
        numCell_LastPage = _remainder;
        pageTotal++;
    }
}

function Draw_Page(_numPage = 0){
    if( _numPage == 0 || prv.buttonMode){ return;}
    
    var _y = y + prv.heightTitle;
    var _indexStart = prv.numCell_Page * (_numPage-1);
    var _indexEnd = prv.numCell_Page-1;
    if(_numPage == pageTotal){
        _indexEnd = numCell_LastPage-1;
    }
    for(var _iCell = 0; _iCell <= _indexEnd; _iCell++){
        _y = y + (1+ _iCell)*prv.heightLine;
        draw_text(x, _y, strings[_iCell + _indexStart]);
    }
}

function Draw_ListName(){
    draw_set_color(prv.c_Title);
    draw_roundrect(x,y,x+prv.width,y+prv.heightTitle,false);
    if(point_in_rectangle(mouse_x, mouse_y, x,y,x+prv.width,y+prv.heightTitle)){
        draw_set_color(prv.c_Outline);
        draw_roundrect(x,y,x+prv.width,y+prv.heightTitle,true);
        
        if(List_Opened == Do_State){
            if(point_in_rectangle(mouse_x, mouse_y, x, y, x + prv.width/2, y + prv.heightTitle)){
                Draw_ArrowHead(x + prv.width*3/8, y + prv.heightTitle/2, 180, prv.heightTitle/2, prv.width/4,c_yellow, false);
            }
            else{
                Draw_ArrowHead(x + prv.width*5/8, y + prv.heightTitle/2, 0, prv.heightTitle/2, prv.width/4,c_yellow, false);
            }
        }
        
    }
    if(List_Opened == Do_State){
        Draw_ArrowHead(x + prv.width*5/8, y + prv.heightTitle/2, 0, prv.heightTitle/2, prv.width/4,c_yellow, true);
        Draw_ArrowHead(x + prv.width*3/8, y + prv.heightTitle/2, 180, prv.heightTitle/2, prv.width/4,c_yellow, true);
    }
    Draw_Reset();
    
    draw_set_valign(fa_middle);
    draw_set_halign(fa_center);
    draw_text(x + prv.width/2,y + prv.heightTitle/2,prv.name);
    Draw_Reset();
}

List_Closed = function(){
    if(point_in_rectangle(mouse_x, mouse_y, x, y, x + prv.width, y + prv.heightTitle)
    && mouse_check_button(mb_left)){
        Do_State = List_Opened;
        pageCurrent = 1;
        Draw_Page_Buttons(pageCurrent);
    }
    else{
        pageCurrent = 0;    //close page
    }
}

List_Opened = function(){
    var _mouseInTitleLeft = point_in_rectangle(mouse_x, mouse_y, x, y, x + prv.width/2, y + prv.heightTitle);
    var _mouseInTitleRight = point_in_rectangle(mouse_x, mouse_y, x + prv.width/2, y, x + prv.width, y + prv.heightTitle);
    var _mb_leftPressed = mouse_check_button_pressed(mb_left);
    var _mb_anyPressed = mouse_check_button_pressed(mb_any);
    var _wheelUp = mouse_wheel_up();
    var _wheelDown = mouse_wheel_down();
    
    if((_mouseInTitleLeft || _mouseInTitleRight)
    && (_mb_leftPressed || _wheelUp || _wheelDown)){    //switch page
        if(_wheelUp || (_mb_leftPressed && _mouseInTitleLeft)){
            pageCurrent--;
        }
        else if(_wheelDown || (_mb_leftPressed && _mouseInTitleRight)){
            pageCurrent++;
        }
        pageCurrent = clamp(pageCurrent, 1, pageTotal);
        if(prv.buttonMode){
            Clear_Buttons();
            Draw_Page_Buttons(pageCurrent);
        }
    }
    else if(!(_mouseInTitleLeft || _mouseInTitleRight) && _mb_anyPressed){ //close page
        if(!prv.buttonMode){
            pageCurrent = 0;
            Do_State = List_Closed;
        }
    }
    else if((_mouseInTitleLeft || _mouseInTitleRight)
    && mouse_check_button_pressed(prv.mb_Close)){
        if(prv.buttonMode){
            Clear_Buttons();
        }
        else{
            pageCurrent = 0;
        }
        Do_State = List_Closed;
    }
}

function Draw_Page_Buttons(_numPage){
    if(_numPage == 0 || !prv.buttonMode){return;}
    var _x = x;
    var _y = y + prv.heightTitle;
    
    var _indexStart = prv.numCell_Page * (_numPage-1);
    var _indexEnd = prv.numCell_Page -1;
    if(_numPage == pageTotal){
        _indexEnd = numCell_LastPage -1;
    }
    
    var _buttons = array_create(0);
    var _inst;
    for(var _iCell = 0; _iCell <= _indexEnd; _iCell++){
        _y = y + (1+ _iCell)*prv.heightLine;
        _inst = instance_create_depth(x,_y, depth, button_confirm_list_debug);
        _inst.iCell = _iCell;
        _inst.target = id;
        _inst.prv.name = strings[_iCell + _indexStart];
        array_push(_buttons, _inst);
    }
    buttons = _buttons;
    return ;
}

function Clear_Buttons(){
    if(buttons == -1){return;}
    var _len = array_length(buttons);
    if(_len == 0){return;}
    for(var _iButton = _len-1; 0 <= _iButton; _iButton--;){
        instance_destroy(buttons[ _iButton],false);
    }
    buttons = -1;
}

function Do_ButtonConfirmed(_iCell){
    //get string id from _idButton
    var _biasPage = (pageCurrent-1) * prv.numCell_Page;
    var _index = _biasPage + _iCell;
    with(prv.target){
        nameVariable = _index;
    }
}



//publics
strings = array_create(0);
strings[0] = "123";
strings[1] = "456";
strings[2] = "789";
strings[3] = "abc";
strings[4] = "def";
strings[5] = "ijk";
strings[6] = "qwe";

numCell_Total = 0;
numCell_LastPage = 0;
pageCurrent = 1;//close page
pageTotal = 0;
Update_Info_Page();

Do_State = List_Closed;
if(prv.buttonMode){
    buttons = array_create(0);
}