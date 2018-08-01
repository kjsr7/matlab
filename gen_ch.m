function [ Xch, Ych ]= gen_ch ( N , Lg, pos, Sp, Op, Ep, ra)
i=1;
Xch=zeros(N, Lg+2);
Ych=zeros(N, Lg+2);
 while i < N+1

 chs_ind=ceil( rand(1,Lg)*length(pos) ); %%% pop size of possible combinations
 ch_t=[ Sp pos(:,chs_ind) Ep ] ; 

 [ test_result ]=test_chromosome( ch_t(1,:), ch_t(2,:) , Op, ra ) ;

 if test_result == 1
 Xch (i,:)= ch_t(1,:);
 Ych (i,:)= ch_t(2,:);
 i=i+1;
 end
 end

end