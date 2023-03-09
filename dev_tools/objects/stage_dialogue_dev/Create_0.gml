/// @desc 
layers = array_create();

for(var _i=0; _i<10; _i++){
    layers[_i] = layer_create(-3100+10*_i);
}

effect_create_above(ef_ellipse,x,y,1,c_red);