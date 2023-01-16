function test_load_csv(){
    file_grid = load_csv("paragraphs_dev.csv");
    var ww = ds_grid_width(file_grid);
    var hh = ds_grid_height(file_grid);
    var xx = 32;
    var yy = 32;
    for (var i = 0; i < ww; i++;)
    {
        for (var j = 0; j < hh; j++;)
        {
            draw_text(xx, yy, string(file_grid[# i, j]));
            yy += 32;
        }
        yy = 32;
        xx += 32;
    }
}
