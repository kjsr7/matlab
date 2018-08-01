clear all;
close all;
clc;
w = 0.5 ; %Inertial Weight
c1 = 2.05 ; %Constants
c2 = c1 ;
number_of_particles = 50 ;
%Function = sin (x)
%Finding minimum
x_min = 0 ; %Minimum position
x_max = 2 * pi ; %Maximum position
x = rand (1 , number_of_particles) .* (x_max - x_min) + x_min ; %Generating random particles
v_min = 0 ; %Minimum velocity
v_max = 1 ; %Maximum velocity
v = rand (1 , number_of_particles) .* (v_max - v_min) + v_min ; %Giving random velocities
p_best = x ; %At t = 0, all particles are at a personal best
proximity = sin (x) ;
g_best = max (proximity) ; %As minimum is being found, g_best is the partcle having least value
for i = 1 : 20
    for j = 1 : number_of_particles
        v (1,j) = w .* v (1,j) + c1 .* rand (1) .* (p_best (1,j) - x (1,j)) + c2 .* rand(1) .* (g_best (1,end) - x (1,j)) ; %Velocity update
        x = x + v ; %Postion update
        for j = 1 : number_of_particles
            if x (j) > x_max
                x (j) = x_max ;
            elseif x (j) < x_min
                x (j) = x_min ;
            end
            if sin (x (j)) > sin (p_best (j))
                p_best (j) = x(j);
            end
        end
    end
    proximity = sin (p_best) ;
    g_best (i + 1) = max (proximity) ;
end
plot (g_best) ;