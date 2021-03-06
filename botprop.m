%This function especially extracts the position and properties of the
%robot. The properties returnes are centroid of bot and orientation from
%the orizontal axis

function [botcent,Alpha]=botprop(vid)

%Globals from main file

 global sizemin,global sizemax,global sizeminbot,global sizemaxbot;
 global cutborderleft,global cutborderright;
 global cutborderup,global cutborderdown;
 global botthresh;

 %Start of typical frame acquisitions and resolution procesing
 
 %start(vid);
 pause(0.5);
 trigger(vid);
 I=getdata(vid,1);
 %I=peekdata(vid,1);
 flushdata(vid);

 

% stop(vid);
 
 se=ones(4,4);           %Structuring element for bot 

J(:,:,1)=macro(I(:,:,1));
J(:,:,2)=macro(I(:,:,2));
J(:,:,3)=macro(I(:,:,3));
I=J;
%imview(I)
[resX resY]=size(I(:,:,1));


img=I(cutborderleft:1:resX-cutborderright,cutborderup:1:resY-cutborderdown,:);
% imview(img)
r=img(:,:,1);        %the r plane
g=img(:,:,2);        %the g plane
b=img(:,:,3);        %the b plane

[resX resY]=size(img(:,:,1));        %new resolution

%Bot plane extraction.

botpos=zeros(resX,resY);

%Loop that extracts bot position as a BW image.
for i =1:1:resX
    for j=1:1:resY
        red=img(i,j,1);
        green = img(i,j,2);
        blue =img(i,j,3);
        if(red > botthresh  & green > botthresh & blue > botthresh)
            
            botpos(i,j)=255;
            img(i,j,:)=0;
        end
    end
end
%  imview(botpos)

%Morphology for making bot uniform
botpos=imdilate(botpos,se);
botpos=imerode(botpos,se);

   
    [L,no] = bwlabel(botpos);                   %Labels different moving regions by diff numbers.    
   
    statsbot = regionprops(L,'basic');         %no = total number of regions
    idx = find([statsbot.Area] > sizeminbot & [statsbot.Area] < sizemaxbot);
    BW2 = ismember(L,idx);                  %discard regions smaller than sizemin
    [L,no] = bwlabel(BW2);
          
     
    statsbot = regionprops(L,'centroid','orient','area');
    
    botpos=L;
     [N,W] = size(statsbot);
%     imview(botpos);
     id = zeros(N);
  for i = 1 : N
    id(i) = i;
  end
  if no > 1            % do sorting only if there are more than 1 objects
  for i = 1 : N-1
    for j = i+1 : N
      if statsbot(i).Area < statsbot(j).Area
        tmp = statsbot(i);
        statsbot(i) = statsbot(j);
        statsbot(j) = tmp;
        tmp = id(i);
        id(i) = id(j);
        id(j) = tmp;
      end
    end
  end
  end
   
    
    Alpha=[statsbot(1).Orientation];
    botcent=[statsbot(1).Centroid];
        
%     z=uint8(ones(resX,resY));    %To eliminate divide by zero error.
%     g=g+z;