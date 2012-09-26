
function Y = macro(Z)

[resX resY]= size(Z);

A=zeros(resX+1,resY+1);
for i=1:1:resX
    for j=1:1:resY
        A(i,j)=Z(i,j);
    end
end

for i=1:1:resX/2
    for j=1:1:resY/2
      
      
          Y(i,j) = (A(2*i,2*j) + A(2*i+1,2*j) + A(2*i,2*j+1) +  A(2*i+1,2*j+1))/4;
       
    end
end
Y=uint8(Y);