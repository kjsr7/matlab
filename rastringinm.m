clc;
clear all;
close all;


%% problem definition

   costfunction = @(x) rastringin(x);
   nvar = 5;
   varsize = [1 5];
   varmin = -10;
   varmax = 10;
   velmax=0.1*(varmax - varmin);
   velmin=-velmax;
   %% parameters of PSO
   maxit = 100;
   npop = 50;
   w = 1;
   wdamp = 0.99;
   c1 = 2;
   c2 = 2;
   %% initialization
    empty_particle.position = [];
    empty_particle.velocity = [];
    empty_particle.cost = [];
    empty_particle.best.cost = [];
    empty_particle.best.position = [];
    particle = repmat(empty_particle, npop, 1);
    globalbest.cost=inf;
    for i=1:npop
        particle(i).position = unifrnd(varmin, varmax, varsize);
        particle(i).velocity = zeros(varsize);
        particle(i).cost = costfunction(particle(i).position);
        particle(i).best.cost=particle(i).cost;
        particle(i).best.position = particle(i).position;
    if particle(i).best.cost < globalbest.cost
        globalbest.cost =  particle(i).best.cost;
    end
    end
    %% main loop of     PSO
  
    for it = 1:maxit
         for i=1:npop
              particle(i).velocity = w*rand.*particle(i).velocity + c1*rand.*(particle(i).best.position - particle(i).position) + c2*rand.*(globalbest.cost - particle(i).position);
              particle(i).position = particle(i).position + particle(i).velocity;
               
              particle(i).velocity = max(particle(i).velocity,velmin);
        particle(i).velocity = min(particle(i).velocity,velmax);
        
        IsOutside=(particle(i).position<varmin | particle(i).position>varmax);
        particle(i).velocity(IsOutside)=-particle(i).velocity(IsOutside);
        
        particle(i).position = max(particle(i).position,varmin);
        particle(i).position = min(particle(i).position,varmax);
              
        particle(i).cost = costfunction(particle(i).position);
              if particle(i).cost < particle(i).best.cost
                  particle(i).best.cost = particle(i).cost;
                  particle(i).best.position = particle(i).position;
                  
             
           if particle(i).best.cost < globalbest.cost
               globalbest.cost = particle(i).best.cost;
           end
              end
         end
         bestcosts(it) = globalbest.cost;
         disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(bestcosts(it))]);
         w=w*wdamp;
         
    end
    
    %% results
    figure;
    semilogy(bestcosts,'linewidth',2);
    xlabel('Iteration');
    ylabel('Best Cost');
    grid on;

    
         
     