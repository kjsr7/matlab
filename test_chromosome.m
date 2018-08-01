function [ test_result ]=test_chromosome( Xc, Yc, Op, ra )
clear test_result;
v_fit=zeros( size(Xc,2), length(Op),size(Xc,1) );
for p=1: size(Xc,1)
 for q=2: size( Xc,2 )
 for r=1: length( Op )
 x2= Xc(p,q); y2=Yc(p,q);x1=Xc(p,q-1); y1=Yc(p,q-1);
 x0= Op(1,r); y0=Op(2,r);

 %%%%%%%%%% if x1=x2 then find Ysol first %%%%%
 if x1==x2
 pol1=1;
 pol2= -2*y0;
 pol3= y0^2+x1^2-2*x0*x1+x0^2-ra^2;

 Ysol= roots( [ pol1 pol2 pol3] ) ;
 Xsol= [x1; x2];

 %%%%% else represent in polynoimal form.. i.e) descending order of X
 else
 m=(y2-y1)/(x2-x1);
 c=y1-m*x1;
 pol1= m^2+1;
 pol2= (2*m*c-2*y0*m-2*x0);
 pol3= c^2-2*y0*c+y0^2+x0^2-ra^2;

 Xsol= roots( [ pol1 pol2 pol3] ) ; 

 Ysol= m*Xsol + c;
 end
 sol= [ Xsol, Ysol ] ;
 sol_d = dist( [x1, y1], [Xsol' ; Ysol'] );
 obs_d = dist( [x1, y1], [x0 ; y0 ] );


 if isreal(sol) && ( obs_d > min( sol_d) && obs_d < max( sol_d ) )
 v_fit(q,r,p ) = 1;
 end
 end

 if sum(sum( v_fit(:,:,p) ) ) <1
 test_result(p)=1;
 else
 test_result(p)=0;
 end


 end



end
end