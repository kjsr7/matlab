clc
clear all
aa=1;
%%%%%%%%%%%%%%%%%%%% Define globally used variables
%%%%%%%%%%%%%%%
tic;
pop=100 ; %%% size of the population
Lg=[1 2 4 10]; %%% Define the length of the gene ( the number of via points)
ra=5; %%%% Define the radius of the obstacle
map_size=20;
Sp = [0; 0]; %%%% Define the starting point
Op=[ 10, 10; 10 , 10] ;
%Op=[ 3,3; 10,10; 14,10; ; 14 , 4 ; 8, 14; 6, 18]'%; 4,10; 16,14; 10, 16]'; %%%%Define the position of the obstacle
Ep=[map_size; map_size]; %%%% Define the destination point
%%%%%%%%%%%% create the possible locations in the map
%%%%%%%%%%%%%%
pos=[];
for k=1:map_size+1
 for l=1:map_size+1
 pos_t=[l-1; k-1];
 pos=[pos pos_t];
 end
end
no_via_ind1= find( ( pos(1,:) ==Sp(1) & pos(2,:)== Sp(2) ) | ( pos(1,:)== Ep(1) & pos(2,:)==Ep(2) ) );
no_via_ind2=[]; 
for i=1: size (Op,2)
 no_via_ind2=[no_via_ind2 find( (pos(1,:) - Op(1,i) ).^2 + ( pos(2,:) -Op(2,i) ).^2<= ra^2 ) ]; %% find points which are inside of the obstacle circle
end
no_via = union ( no_via_ind1, no_via_ind2 );
pos( :, no_via )=[];

[ Xch, Ych ]= gen_ch ( pop , Lg(aa), pos, Sp, Op, Ep, ra); 
 ch_dist=[];
 for i=2:Lg(aa)+2
 ch_dist(:,i-1)= sqrt( ( Xch(:,i-1)- Xch(:,i) ).^2 + ( Ych(:, i-1)- Ych(:, i ) ).^2);
 end

 ch_fitness = sum( ch_dist')';
 best_ch_ind= find( ch_fitness == min( ch_fitness) );

 ch_order = [ [1:length(ch_fitness)']' ch_fitness] ;
 ch_order = sortrows( ch_order, 2) ;
for generation = 1:100
 
 Pc=.2; 
 Pm=.2; 

  

 elite= ch_order(1,:);
 Xe=Xch( elite(:,1), : );
 Ye=Ych( elite(:,1), :);

 order=ch_order(2:end,:);

 
 bit=round( rand*(Lg(aa)-1) );

 [ Xchild1, Ychild1 ] = crossover ( order, Xch, Ych, Pc , bit, Op, ra, Lg(aa));

 chn_size=0;
 chn_size= pop- size(Xchild1,1);
 [ Xchdn2, Ychdn2 ]= gen_ch ( chn_size, Lg(aa), pos, Sp, Op, Ep, ra ) ; 
 Xchild1=[ Xchild1; Xchdn2];
 Ychild1=[ Ychild1; Ychdn2];
 [ Xchild2, Ychild2 ] = mutation( Xchild1, Ychild1, pos, Pm, Op, ra )
 
 Xchn= Xchild2; 
 Ychn= Ychild2; 

 
 chn_size=0;
 chn_size= pop- size(Xchn,1);
 [ Xchn2, Ychn2 ]= gen_ch ( chn_size, Lg(aa), pos, Sp, Op, Ep, ra) ;

 Xch_t= [Xchn ; Xchn2]; Xch(2:end,:)= Xch_t(1:pop-1,:); Xch(1,:)=Xe;
 Ych_t= [Ychn ; Ychn2];Ych(2:end,:)= Ych_t(1:pop-1,:); Ych(1,:)=Ye;
 

 ch_dist=[];
 for i=2:Lg(aa)+2
 ch_dist(:,i-1)= sqrt( ( Xch(:,i-1)- Xch(:,i) ).^2 + ( Ych(:, i-1)- Ych(:, i ) ).^2);
 end

 ch_fitness = sum( ch_dist')';
 best_ch_ind= find( ch_fitness == min( ch_fitness) );
 

 ch_order = [ [1:length(ch_fitness)']' ch_fitness] ;
 ch_order = sortrows( ch_order, 2) 



 
 if generation==100
 Xch100=Xch; 

 Ych100=Ych;
 order100=ch_order;
 best100=best_ch_ind;

 end

end
toc;
figure(4)
plot( Xch(best_ch_ind(1),:), Ych(best_ch_ind(1),:), 'g*' )
hold on
line( Xch(best_ch_ind(1),:), Ych(best_ch_ind(1),:) )
plot( Op(1,:), Op(2,:), 'ro', 'markersize', ra*27)
title(' the best chromomosome found at the 100th generation' )
text(12,19, ['path length =', num2str( ch_order(1,2) )] )
hold off


 

