
% This is the main program EXE to be called.
% the program sends following characters for mot maneuvering
% 'f': Forward,
% 'r': Right
% 'l': Left
% 'a': Reverse
% 'm': Special Forward (FAST);
% 'o': Close ring
% 'n': Open ring
% Copyright Sagar Joglekar, Swapnil Sakharshete , Paras Salunkhe
% January 2008
%VIT Electronics Pune :37 India.
  

 clc
 clear all
 
 %Global Declarations for easy manipulations of variables
 
 global sizemin,global sizemax,global sizeminbot,global sizemaxbot;
 global cutborderleft,global cutborderright;
 global cutborderup,global cutborderdown;
 global rhole,global yhole,global ghole;
 global hsVALg, global hsVALr, global hsVALy,global tolg,global tolr,global toly;
 global botthresh;
 global distthresh;
 global orientang;
 global goslow;
 global objr,global objy,global objg;
 %global holemat;
 objr=0;
 objy=objr;
 objg=objr;
 %Thresholds For Colorspace segmentation

 %holemat = [20,20;20,(resY-20);(resX-20),(resY/2-20)];
 hsVALg=[0.42 .5 0.5];
 hsVALr=[0.9 1 0.5];
 hsVALy=[0.15 .5 0.5];
 tolg=[0.13 .5 .5];
 tolr=[0.08 .5 .5];
 toly=[0.04 .5 .5]; 

 %Thresholds for bot detection
  
  botthresh = 210;
  
 %Distance threshold;
  
  distthresh = 30;
  goslow = 100;
  orientang =12;
 
 %Thresholds for Size regulation
 
  sizeminbot =100;
  sizemaxbot =1000;        %other common threshold parameters.
  sizemin=50;
  sizemax=1500;

 %Communications object Creation
 
 s = serial('COM5','baudrate',9600)
 s.terminator= ''
 fopen(s);
 %Video Object creation and configuration for closed Loop
 
 vid=videoinput('winvideo',1,'RGB24_640x480')
 set(vid,'FramesPerTrigger',1);
 triggerconfig(vid,'manual');
 set(vid,'TriggerRepeat', Inf);
 start(vid);

%Start of Executation



trigger(vid);
I=getdata(vid,1);
%I=peekdata(vid,1);
flushdata(vid);

%stop(vid);
%Resolution step down

J(:,:,1)=macro(I(:,:,1));
J(:,:,2)=macro(I(:,:,2));
J(:,:,3)=macro(I(:,:,3));
I=J;
[resX resY]=size(I(:,:,1));

imview(I);
cutborderleft= input('UP border to cut');
cutborderright=input('DOWN border to cut');
cutborderup=   input('LEFT border to cut');
cutborderdown= input('RIGHT border to cut');



img=I(cutborderleft:1:resX-cutborderright,cutborderup:1:resY-cutborderdown,:);

imshow(img)
I=img;

%Extract bot properties and orientation
[botcent,Alpha]=botprop(vid);
%Determine ball & hole positions
[rcent,ycent,gcent]=getplanes(vid);
    
[r1,c1]=size(rcent);
[r2,c2]=size(ycent);
[r3,c3]=size(gcent);

flag3=0;
var = r1+r2+r3
 
% Loop which executes till all the balls are put in holes.
 
while (var>0)
      
      [ballcent,color]=mindist(rcent,ycent,gcent,botcent);
      ballcent
      color

              
      flag3=capproc(ballcent,color,vid,s);
      if flag3==1
          var = var -1;
      end
      [botcent,Alpha]=botprop(vid);
      [rcent,ycent,gcent]=getplanes(vid);
      flag3
 end
