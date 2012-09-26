%Function evaluates the angle through which the bot has to turn to
%orient with the ball/hole. The function always calculates the minor angle.
%Logic Copyright Sagar and swapnil... hehehe.

function [gamma , dir] = angeva (ballcent,botcent,alpha)


if alpha < 0
    alpha = 180 + alpha;
end

theta = atan((botcent(1,2)-ballcent(1,2))/(botcent(1,1)-ballcent(1,1)));
theta=(theta*180)/pi;


if theta< 0
    
    gamma=alpha-abs(theta);
    if gamma <0
      dir = 1;   %anti clk wise = 1, clk =0;  
    else
      dir = 0;
    end
    gamma = abs(gamma);
    
else
    
    gamma = 180 - (alpha+theta);
    
    if gamma <0
      dir = 0;   %anti clk wise = 1, clk =0;  
    else
      dir = 1;
    end
    gamma = abs(gamma);
    
end
    
if gamma > 90
    
    gamma = 180-gamma;
    dir = 1 - dir;
end