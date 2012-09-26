
%this function is doing all the jobs from getting the ball to putting the
%ball in its own hole. All the ally functions are called from this 

function flag3 = capproc (ballcent,col,vid,s) 

global rhole,global yhole,global ghole;

[botcent,Alpha]=botprop(vid);
flag2=0;
colour=col;
finish = 0;
flag3 = 0;

%perform the tasks below till the ball goes into ots hole 
while finish == 0
    [rgamma,dir]=angeva(ballcent,botcent,Alpha);
    f = 0;
         
    f = orient( rgamma,dir,ballcent,s,vid);
    
    if f == 1
      flag1= evalhead(botcent,ballcent,s,vid)
    end 
    
    if flag1 == 1
         flag2 = getball(ballcent,s,vid)
    end
    
    % hereonwards the bot will take ball to the hole
    %Depending on the color of the ball.
    
    if flag2 == 1
         %fopen(s)    ;
         fprintf(s,'%c','n','async');      
         pause(0.5);
         stopasync(s);
         %fclose(s);
        
         if colour == 1
             
            [rgamma,dir]=angeva(rhole,botcent,Alpha);
             f = 0;
         
             f = orient( rgamma,dir,rhole,s,vid);
    
            if f == 1
                flag1= evalhead(botcent,rhole,s,vid)
            end 
    
            if flag1 == 1
                flag2 = getball(rhole,s,vid)
            end
    
         elseif colour == 2
             
            [rgamma,dir]=angeva(yhole,botcent,Alpha);
            f = 0;
         
             f = orient( rgamma,dir,yhole,s,vid);
    
            if f == 1
                flag1= evalhead(botcent,yhole,s,vid)
            end 
    
            if flag1 == 1
                flag2 = getball(yhole,s,vid)
            end
    
          elseif colour == 3
             
             [rgamma,dir]=angeva(ghole,botcent,Alpha);
              f = 0;
         
              f = orient( rgamma,dir,ghole,s,vid);
    
            if f == 1
                flag1= evalhead(botcent,ghole,s,vid)
            end 
    
            if flag1 == 1
                flag2 = getball(ghole,s,vid)
            end
         end
         
         %Take the ring out and go reverse to avoid wall collision.
         
         %fopen(s)    ;
         fprintf(s,'%c','o','async');
         pause(1.5);
         stopasync(s);
         %fclose(s);    
         
         %fopen(s)    ;
         fprintf(s,'%c','a','async');
         pause(1);
         stopasync(s);
         %fclose(s); 
         
         finish = 1;
    end
        
end
flag3=1;