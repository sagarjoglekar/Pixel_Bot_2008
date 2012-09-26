
%Function orients the bot to the destined ball/Hole.
function flag = orient ( gamma,dir,ballcent,s,vid)

 global orientang;
%     sizeminbot =50;
%     sizemaxbot =1000;
%     sizemin=20;
%     sizemax=300;

if dir == 1
    %fopen(s)    
    fprintf(s,'%c','l','async')
    pause(0.5);
    stopasync(s);
    %fclose(s);
else
    %fopen(s)    
    fprintf(s,'%c','r','async')
    pause(0.5);
    stopasync(s);
    %fclose(s);
end

flag = 0
%start(vid);

while flag == 0
    

   
     [botcent,Alpha]=botprop(vid);
        
    
     [gamma,dir]=angeva(ballcent,botcent,Alpha);
     gamma
     if gamma < orientang                %threshold  window for orientation.
         flag=1
    
     else
         if dir ==1
             %fopen(s)    
             fprintf(s,'%c','l','async')
             pause(0.5);
             stopasync(s);
             %fclose(s);
             %dir
         else
             %fopen(s)    
             fprintf(s,'%c','r','async')
             pause(0.5);
             stopasync(s);
             %fclose(s);
             %dir
         end
     end
     
end
