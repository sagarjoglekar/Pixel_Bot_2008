
% This function evaluates the bot head and verifies whether the bot proceeds
% towards the ball in head first manner.

function flag1 = evalhead(botcent,ballcent,s,vid);

%Globals required from the main file

 global sizemin,global sizemax,global sizeminbot,global sizemaxbot;
 global cutborderleft,global cutborderright;
 global cutborderup,global cutborderdown;


    predist=finddist(botcent,ballcent);  %Find initial distance
    predist=abs(predist);
    flag1= 0;
    
    %Send an initial forward to check whether the bot goes away or comes
    %close to the destined ball.
    
    %fopen(s)    ;
    fprintf(s,'%c','f','async');
    pause(1);
    stopasync(s);
    %fclose(s);
    

    
    %Find distance and orientation after initial forward motion
    
    [botcent,Alpha]=botprop(vid); 
    nexdist = finddist(botcent,ballcent);
    nexdist=abs(nexdist);
    
    %If bot has gone away take a 180 degree turn to face ball head first.
    
    if nexdist > predist
    %fclose(s);
         fprintf(s,'%c','m','async');
         pause(1);
         stopasync(s);
         fprintf(s,'%c','a','async');
         pause(1);
         stopasync(s);
%          fprintf(s,'%c','p','async');
%          pause(1);
%          stopasync(s);
         fprintf(s,'%c','p','async');
         pause(1);
         stopasync(s);
%     pause(1.5);
%     stopasync(s);
%     fclose(s);
%     fopen(s) ;
%     fprintf(s,'%c','p','async');           %send 180 degree turn instru
%     pause(0.5);
%     stopasync(s);
%     fclose(s);

%     fopen(s)    ;
%     fprintf(s,'%c','r','async');           %send 180 degree turn instru
%     pause(0.5);
%     stopasync(s);
%     fclose(s);
%     fprintf(s,'%c','r','async');           %send 180 degree turn instru
%     pause(0.5);
%     stopasync(s);
%     fclose(s);
%         fprintf(s,'%c','r','async');           %send 180 degree turn instru
%     pause(0.5);
%     stopasync(s);
%     fclose(s);


%     [rgamma,dir]=angeva(ballcent,botcent,Alpha);
%     flag1 = orient( rgamma,dir,ballcent,s,vid);
    flag1=1
    else
       flag1 = 1;
    end
       
    
    
    