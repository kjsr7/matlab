function [ Xchild, Ychild ] = crossover ( order, Xch, Ych, Pc , bit, Op, ra, Lg)
%bit=1;
if bit < 0 || bit > 5
 error( 'choose diff bit number' )
 return;%break
end
% ch_fitness= order(:,2) - min( order(:,2) )+1;
% fit_sum=sum(ch_fitness ) ;
% p_t= sum( ch_fitness )./ch_fitness ;
% p= p_t/sum(p_t);
ch_fitness_t = order(:,2) ;

ch_fitness= 1./ch_fitness_t;

% fit_sum=sum(ch_fitness_t);
% ch_fitness= fit_sum./ ( ch_fitness_t - sqrt( 20^2+20^2 ) ) ;
p= ch_fitness/(sum(ch_fitness) ) ;
Xp= Xch( order(:,1), :);
Yp= Ych( order(:,1), :);
for i=1:length(p)
 q(i)=sum( p(1:i) ) ;
end
%%%%%%%%%%%%%% chromosome clone %%%%%%%%%%%%%%%%
roulet=rand(1,length(p) );
for i=1:length(p)
qk_t= find( q > roulet(i) ) ; qk(i)=qk_t(1);
%qk_1_t=find( q < roulet(1) );, qk=qk_1_t(end)
end
Xp=Xp(qk,: );
Yp=Yp(qk,: );
%%%%%%%%%%%%%% chromosome crossover %%%%%%%%%%%%%%%%
roulet=rand(1, length(p) );
vc=find( roulet < Pc );
Xparent = Xp ; X_head= Xparent(vc, 1:Lg-bit ); X_tail=Xparent(vc,Lg-bit+1:end) ;
Yparent = Yp ;Y_head= Yparent(vc, 1:Lg-bit ); Y_tail=Yparent(vc,Lg-bit+1:end);
Xchild=Xparent;
Ychild=Yparent;
X_tail= flipud(X_tail);
Y_tail= flipud(Y_tail);
Xchild(vc,:)= [ X_head X_tail ];
Ychild(vc,:)= [ Y_head Y_tail ];
[ test_result ]=test_chromosome( Xchild, Ychild, Op, ra ) ;
Xchild( find( test_result == 0 ), : )=[];
Ychild( find( test_result == 0 ), : )=[];
end 

 