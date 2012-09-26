%This function does the job of extraction of balls and segmentation  

function [rcent,ycent,gcent]=getplanes(vid)


 global sizemin,global sizemax,global sizeminbot,global sizemaxbot;
 global cutborderleft,global cutborderright;
 global cutborderup,global cutborderdown;
 global hsVALg, global hsVALr, global hsVALy,global tolg,global tolr;
 global toly;
 global rhole,global yhole,global ghole;
 global objr,global objy,global objg;
%stop(vid);
%start(vid); 
pause(0.5);
trigger(vid);
I=getdata(vid,1);
%I=peekdata(vid,1);
flushdata(vid);

%stop(vid);
%start(vid);

  
 


 rcent=[1000,1000];
 ycent=[1000,1000];
 gcent=[1000,1000];
 rhole=[10 10];
 yhole=[10 10];
 ghole=[10 10];


J(:,:,1)=macro(I(:,:,1));
J(:,:,2)=macro(I(:,:,2));
J(:,:,3)=macro(I(:,:,3));
I=J;
[resX resY]=size(I(:,:,1));


img=I(cutborderleft:1:resX-cutborderright,cutborderup:1:resY-cutborderdown,:);


[rcent,rhole,objr] = colorDetectHSV(img, hsVALr, tolr);
% [gcent,ghole,objg] = colorDetectHSV(img, hsVALg, tolg)
 [ycent,yhole,objy] = colorDetectHSV(img, hsVALy, toly);

