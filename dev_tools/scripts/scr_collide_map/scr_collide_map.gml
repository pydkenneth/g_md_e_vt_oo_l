//desc: this function is used for an object to collide map/specific obj by "its self"
function Collide_Map(_x,_y){
    if(Collide_Obj(_x, _y)){
        return true;
    }
    else if(Collide_Tile(sys_Collision.gridmapCollisionTile, _x, _y)){
        return true;
    }
    else{
        return false;
    }
}

function Collide_Obj(_x,_y,_objCollision){
    return place_meeting(_x, _y, _objCollision);
}

function Collid_Tile(){
    
}