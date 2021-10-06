function [ x, y, time ] = walk2drand ( starting_coordinate, step_num, range_grid, total_time )
%WALK3DRAND Generates a random path of step_num steps from a starting 
%coordinate on a defined grid.
    %Detailed epxlanation goes here.

    x = zeros(step_num+1,1);
    y = zeros(step_num+1,1);
    time=0:total_time/step_num:total_time;
    x(1)=starting_coordinate.x;
    y(1)=starting_coordinate.y;
    nx=[((range_grid.x1-range_grid.x2)/100) 0 ((range_grid.x2-range_grid.x1)/100)];
    ny=[((range_grid.y1-range_grid.y2)/100) 0 ((range_grid.y2-range_grid.y1)/100)];
    % - first step -
    xdone=0; ydone=0;
    step=1;
    x(step+1)=x(step)+nx(round(2*rand(1,1))+1);
    y(step+1)=y(step)+ny(round(2*rand(1,1))+1);
    % - end - 
    for step = 2:step_num + 1
        xdone=0; ydone=0;
        while ~xdone
            x(step+1)=x(step)+nx(round(2*rand(1,1))+1);
            if x(step+1)>range_grid.x1 && x(step+1)<range_grid.x2 && x(step+1)~=x(step-1); xdone=1; end
        end
        while ~ydone
            y(step+1)=y(step)+ny(round(2*rand(1,1))+1);
            if y(step+1)>range_grid.y1 && y(step+1)<range_grid.y2 && y(step+1)~=y(step-1); ydone=1; end
        end        
    end
end