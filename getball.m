
%This function does the job of going towards the ball/hole and orient
%faithfully so as to put the capture device.


function flag2 = getball (ballcent,s,vid)

%thresholds

global distthresh;
global orientang;
global goslow;
flag2 = 0;
doublechk=0;

% [botcent,Alpha]=botprop(vid);
% doublechk=evalhead(botcent,ballcent,s,vid)
[botcent,Alpha]=botprop(vid);
% [rgamma,dir]=angeva(ballcent,botcent,Alpha);
% flag1 = orient( rgamma,dir,ballcent,s,vid);


predist=finddist(botcent,ballcent);
count=0;

%Go forward till we reach the ball.
while predist > distthresh
    
    if doublechk==1     %Check for certain head first movement
    
    if predist < goslow %Go slow if very near to ball
    %fopen(s)    ;
    fprintf(s,'%c','f','async');
    pause(0.5);
    stopasync(s);
    %fclose(s);
    else                %Else giddy up horsey !!! 
    %fopen(s)    ;
    fprintf(s,'%c','m','async');
    pause(0.5);
    stopasync(s);
    %fclose(s);
    end
    count=count+1;
    [botcent,Alpha]=botprop(vid);
    predist=finddist(botcent,ballcent);
    
    if count == 2                                   %for repetetive orient.
        [rgamma,dir]=angeva(ballcent,botcent,Alpha); % After every 2 forwards
         f = 0;
         f = orient( rgamma,dir,ballcent,s,vid);
        count = 0;
    end
    
    else
        [botcent,Alpha]=botprop(vid);
        doublechk=evalhead(botcent,ballcent,s,vid);
        [botcent,Alpha]=botprop(vid);
        [rgamma,dir]=angeva(ballcent,botcent,Alpha);
        flag1 = orient( rgamma,dir,ballcent,s,vid);

    end
        
end

[rgamma,dir]=angeva(ballcent,botcent,Alpha);
 f = 0;
 
 %Final orientation to ball/hole
 if rgamma > orientang
     f = orient( rgamma,dir,ballcent,s,vid);
 end
 flag2=1;