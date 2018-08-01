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
g_best = min (proximity) ; %As minimum is being found, g_best is the partcle having least value
for i = 1 : number_of_particles
    v = w * v + c1 .* rand (1) .* (p_best - x) + c2 .* rand(1) .* (g_best - x) ; %Velocity update
    x = x + v ; %Postion update
    if x > x_max
        x = x_max ;
    elseif x < x_min
        x = x_min ;
    end
    proximity = sin (x) ;
    proximity_best = sin (p_best) ;
    for j = 1 : number_of_particles
        if proximity (1 , j) < proximity_best (1 , j) ;
            p_best (1 , j) = x (1 , j) ;
        end
    end
end