vid=videoinput('winvideo',1,'RGB24_640x480');
 set(vid,'FramesPerTrigger',1);
 triggerconfig(vid,'manual');
 set(vid,'TriggerRepeat', Inf);
 start(vid);
 
 trigger(vid);
I=getdata(vid,1);
J(:,:,1)=macro(I(:,:,1));
J(:,:,2)=macro(I(:,:,2));
J(:,:,3)=macro(I(:,:,3));
I=J;
[resX resY]=size(I(:,:,1));

imview(I);
cutborderleft=input('UP border to cut');
cutborderright=input('DOWN border to cut');
cutborderup=input('LEFT border to cut');
cutborderdown=input('RIGHT border to cut');



img=I(cutborderleft:1:resX-cutborderright,cutborderup:1:resY-cutborderdown,:);

imshow(img)