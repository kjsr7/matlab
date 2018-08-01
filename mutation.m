function [ Xchild, Ychild ] = mutation( Xp, Yp, pos, Pm , Op, ra)
X_head= Xp(:,1); X_body= Xp(:, 2:end-1 ); X_tail= Xp(:,end) ;
Y_head= Yp(:,1); Y_body= Yp(:, 2:end-1 ); Y_tail= Yp(:,end) ;
%%%% The mutation will be performed on the body of the chomosome %%%%
Ppm=rand( size( X_body,1), size( X_body,2) );
m_ind=find( Ppm < Pm);
child_ind=ceil( rand( size( m_ind) )*length(pos) );
X_body( m_ind )= pos( 1, child_ind) ;
Y_body( m_ind) = pos( 2, child_ind);
Xchild= [ X_head X_body X_tail];
Ychild= [ Y_head Y_body Y_tail];
[ test_result ]=test_chromosome( Xchild, Ychild, Op, ra );
Xchild( find( test_result == 0 ), : )=[];
Ychild( find( test_result == 0 ), : )=[];
end