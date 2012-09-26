%Function to segment balls and holes using HSV colorspace.

function [cent,hole,num]= colorDetectHSV(RGB, hsvVal, tol)

 global sizemin,global sizemax,global sizeminbot,global sizemaxbot;
 global cutborderleft,global cutborderright;
 global cutborderup,global cutborderdown;
 global hsVALg, global hsVALr, global hsVALy,global tolg,global tolr,global toly;
 global rhole,global yhole,global ghole;
 global botthresh;
 global distthresh;
 global holemat;
 cent=[1000 1000];
 %thole=[0,0];
 
 [resX,resY]=size(RGB(:,:,1));
 %Loop that extracts bot position as a BW image.
for i =1:1:resX
    for j=1:1:resY
        red=RGB(i,j,1);
        green = RGB(i,j,2);
        blue =RGB(i,j,3);
        if(red > botthresh & blue > botthresh & green > botthresh)
            
           HSV(i,j,1)=1.0;
            HSV(i,j,2)=1.0;
            HSV(i,j,3)=1.0;
            
        end
    end
end
 HSV = rgb2hsv(RGB);
 hole = [10 10];
 %hole=zeros(1,2);
  %  imshow(HSV)
%   [resX,resY]=size(HSV(:,:,2))
%   for i=1:1:resX
%       for j=1:1:resY
%           HSV(i,j,2)=1;
%       end
%   end
     imview(HSV)

% find the difference between required and real H value:
diffH = abs(HSV(:,:,1) - hsvVal(1));

[M,N,t] = size(RGB);
I1 = zeros(M,N); I2 = zeros(M,N); I3 = zeros(M,N);

T1 = tol(1);

I1( find(diffH < T1) ) = 1;

if (length(tol)>1)
% find the difference between required and real S value:
diffS = abs(HSV(:,:,2) - hsvVal(2));
T2 = tol(2);
I2( find(diffS < T2) ) = 1;
if (length(tol)>2)
% find the difference between required and real V value:
difV = HSV(:,:,3) - hsvVal(3);
T3 = tol(3);
I3( find(diffS < T3) ) = 1;
I = I1.*I2.*I3;
%    imview(I)
else
I = I1.*I2;
%  imview(I)
end
else
I = I1;
 %imview(I)
end
% sizemin=50;
% sizemax=600;
se=ones(2,2);
se1=strel('disk',15);

    J=imerode(I,se);
    J=imdilate(J,se);
    J=imdilate(J,se);
    J=imclose(J,se1);

%        imview(J)
    [L,no] = bwlabel(J);                   %Labels different moving regions by diff numbers.    
    %imview(L)
    stats = regionprops(L,'basic');        %no = total number of regions
     allArea = [stats.Area]
    
    idx = find([stats.Area] > sizemin & [stats.Area] < sizemax);
    BW2 = ismember(L,idx);                  %discard regions smaller than sizemin
    [L,no] = bwlabel(BW2);
    num=no;
    stats = regionprops(L,'centroid','area');
    [N,W] = size(stats);
    
    % do bubble sort (large to small) on regions in case there are more than 1
  id = zeros(N);
  for i = 1 : N
    id(i) = i;
  end
  if no > 1            % do sorting only if there are more than 1 objects
  for i = 1 : N-1
    for j = i+1 : N
      if stats(i).Area < stats(j).Area
        tmp = stats(i);
        stats(i) = stats(j);
        stats(j) = tmp;
        tmp = id(i);
        id(i) = id(j);
        id(j) = tmp;
      end
    end
  end
   hole = [stats(1).Centroid]
    for i=2:1:no
        cent(i-1,:)=[stats(i).Centroid];
    end
   
  else
      hole = [stats(1).Centroid]
     % imview(L);

  end
    
    img=L;
    imview(img)
    return
