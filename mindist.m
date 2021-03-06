function [coordinate,color] = mindist(rdist,ydist,gdist,botcent) 
%The function finds distances between all the points in the three ball
%centroid matrices and the bot centroid and returns coordinates of the 
%minimum of all
%along with the indication of color which would be useful for deciding the
%hole to put the ball in. 
%Color indication is as follows.
%1 => Red BAll
%2 => Yellow BAll
%3 => Green BALL
% rdist=[5 6;5 5];
% ydist=[5 5;6 6];
% gdist=[8 1;0 1];
% botcent=[0,0];
global objr,global objy,global objg;

[r1,c1]=size(rdist);
[r2,c2]=size(ydist);
[r3,c3]=size(gdist);

coordinate=[0,0];
color=0;

if rdist(1,1) < 1000
    if objr >0 && objr < 4
    coordinate = rdist(1,:);
    color = 1; 
    end
elseif gdist(1,1) < 1000
    if objg >0 && objg < 4
    coordinate = gdist(1,:);
    color = 3;
    end
elseif ydist(1,1) < 1000
    if objy >0 && objy < 4
    coordinate = ydist(1,:);
    color = 2;
    end
end

 D=1000;
% loop executes for finding minimum among red balls
if(r1>0 && rdist(1,1)<1000)
    coordinate=rdist(1,:);
    color=1;
    D=finddist(botcent,rdist(1,:));
    dr1=D;
     if r1>1
        dr2=finddist(botcent,rdist(2,:));
       if dr2<D
            D=dr2;
            coordinate=rdist(2,:);
       end
    end
end


%loop executes to find minimum among yellow balls
 if(r2>0 && ydist(1,1)<1000)
    dy1=finddist(botcent,ydist(1,:));
    if dy1<D
     coordinate=ydist(1,:);
     color=2;
     D=dy1;
    end
    if r2>1
        dy2=finddist(botcent,ydist(2,:));
       if dy2<D
           coordinate=ydist(2,:);
           D=dy2;   
           color=2;
       end
       
    end
    
end    

%Loop executes to find minumum among green balls
if(r3>0 && gdist(1,1)<1000 )
    dg1=finddist(botcent,gdist(1,:));
    if dg1<D
     coordinate=gdist(1,:);
     color=3;
     D=dg1;
    end
    if r2>1
          dg2=finddist(botcent,gdist(2,:));
       if dg2<D
           coordinate=gdist(2,:);
           D=dg2;
           color=3;
       end
    end
   
end 

