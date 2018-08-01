%Using PSO to find minimum of given function
clear all;
close all;
clc;
w = 1.0 ; %Inertial Weight
w_damp = 0.99 ; %Inertial weight damping
c1 = 2.05 ; %Personal Constant
c2 = 2.05 ; %Social Constant
number_of_particles = 49 ;
number_of_iterations = 50 ;
x_min = 0 ; %Minimum x
x_max = 25 ; %Maximum x
y_min = 0 ; %Minimum y
y_max = 25 ; %Maximum y
x = rand (1 , number_of_particles) .* (x_max - x_min) + x_min ; %Generating random particles
y = rand (1 , number_of_particles) .* (y_max - y_min) + y_min ;
v_min = 0 ; %Minimum velocity
v_max = 1 ; %Maximum velocity
v_x = zeros (1 , number_of_particles) ; %Giving random velocities
v_y = zeros (1 , number_of_particles) ;
p_best = [x ; y] ; %At t = 0, all particles are at a personal best
for i = 1 : number_of_particles
    proximity (i) = func (p_best (1 , i) , p_best (2 , i)) ; %#ok<*SAGROW>
end
[g_best,I] = min (proximity) ;
g_best_x (1,1) = p_best (1,I) ;
g_best_y (1,1) = p_best (2,I) ;
for i = 1 : number_of_iterations
    for j = 1 : number_of_particles
        v_x (1,j) = w * rand * v_x (1,j) + c1 * rand * (p_best (1,j) - x (1,j)) + c2 * rand * (g_best_x (1,end) - x (1,j)) ; %x-Velocity update
        v_y (1,j) = w * rand * v_y (1,j) + c1 * rand * (p_best (2,j) - y (1,j)) + c2 * rand * (g_best_y (1,end) - y (1,j)) ; %y-Velocity update
        x (1,j) = x (1,j) + v_x (1,j) / 1.3 ; %x-Position update
        y (1,j) = y (1,j) + v_y (1,j) / 1.3 ; %y-Position update
        for k = 1 : number_of_particles
            if x (k) > x_max
                x (k) = x_max ;
            elseif x (k) < x_min
                x (k) = x_min ;
            end
            if y (k) > y_max
                y (k) = y_max ;
            elseif y(k) < y_min
                y (k) = y_min ;
            end
            if func (x (k) , y (k)) < func (p_best (1,k) , p_best (2,k))
                p_best (1,k) = x (k) ;
                p_best (2,k) = y (k) ;
            end
        end
    end
    w = w * w_damp ;
    for j = 1 : number_of_particles
        proximity (i) = func (p_best (1,j) , p_best (1,j)) ;
    end
    [g_best ,I] = min (proximity) ;
    g_best_x  = p_best (1,I) ;
    g_best_y  = p_best (2,I) ;
    plot (x,y,'o') ;
    axis([x_min x_max y_min y_max]);
     pause(0.2);
end