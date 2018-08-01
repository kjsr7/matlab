clc;
clear;
close all;
nvar=30;
costfunction=@(x)rastrigin(x,nvar);
varsize=[1 nvar];
varmin=-5.12;
varmax=5.12;
maxit=3000;
npop=20;
velmax=0.1*(varmax-varmin);
velmin=-velmax;
c1=2;
c2=2;
w=1;
wdamp=.99;
empty_particle.position=[];
empty_particle.velocity=[];
empty_particle.cost=[];
empty_particle.best.position=[];
empty_particle.best.cost=[];
globalbest.cost=inf;
particle=repmat(empty_particle,npop,1);
for i=1:npop
     particle(i).position=unifrnd(varmin,varmax,varsize);
     particle(i).cost=costfunction(particle(i).position);
     particle(i).velocity=zeros(varsize);
     particle(i).best.position=particle(i).position;
     particle(i).best.cost=particle(i).cost;
     if particle(i).best.cost<globalbest.cost
         globalbest.cost=particle(i).best.cost;
         globalbest.position=particle(i).best.position;
     end
end
bestcosts=zeros(maxit,1);
for it=1:maxit
    for i=1:npop
      particle(i).velocity = w*particle(i).velocity ...
            +c1*rand(varsize).*(particle(i).best.position-particle(i).position) ...
            +c2*rand(varsize).*(globalbest.position-particle(i).position);
        particle(i).position=particle(i).position+particle(i).velocity;
       if (particle(i).velocity>velmax)
           particle(i).velocity=velmax;
       else
           if particle(i).velocity<velmin
                particle(i).velocity=velmin;
           else
               particle(i).velocity=particle(i).velocity;
           end
       end
       if particle(i).position>varmax
            particle(i).position=varmax;
       else
           if particle(i).position<varmin
                particle(i).position=varmin;
           else
               particle(i).position=particle(i).position;
           end
       end                                                                                                                                                                       
        particle(i).cost=costfunction(particle(i).position);
        if particle(i).cost<particle(i).best.cost
             particle(i).best.cost=particle(i).cost;
             particle(i).best.position=particle(i).position;
        
        if particle(i).best.cost<globalbest.cost
            globalbest=particle(i).best;
        end
        end
    end
    bestcosts(it)=globalbest.cost;
    disp(['iteration',num2str(it),':bestcost',num2str(bestcosts(it))]);
    w=w*wdamp;
end
figure;
semilogy(bestcosts,'linewidth',2);
xlabel('iterations');
ylabel('bestcost');
grid on;