clc;
clear all;
close all;
n=30;
p=rand(1,n)*2*pi;
v=rand(1,n);
pbest=p;
pb=sin(pbest);
pbmin=min(pb);
k=1;
for i=1:n

    if pb(i)==pbmin
      gbest(k)=pbest(i);
    end
end
c1=2.05;
c2=c1;
pmax=2*pi;
pmin=0;
vmax=1;
vmin=0;
for i=1:30
    v(i)=v(1,i)+(c1*(pbest(1,i)-p(1,i))*rand(1))+(c2*(gbest(k)-p(1,i))*rand(1));
    p=p+v;
%     y= sin(p);
     for j=1:30   
         if p(j)>pmax
             p(j)=pmax;
         else
             if p(j)<pmin
                 p(j)=pmin;
             else
                 p(j)=p(j);
             end
         end
        if sin(p(j))<sin(pbest(j))
            pbest(j)=p(j);
        end
       pb=sin(pbest);
       pbmin=min(pb);
k=k+1;
            for i=1:n
             if pb(i)==pbmin
              gbest(k)=pbest(i);
             end
        end
     end 
    
end
y1=sin(gbest);
plot(y1);

