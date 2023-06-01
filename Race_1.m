function [rt,choice,X1,dist] = Race_1(thrpos,thrneg,vari,X0,B,t)
dt = vari;
X = X0;
rt = 0;
c1 = 2;
X1(1) = X0;
while X<thrpos && X>thrneg && rt<t
    dW = normrnd(0,sqrt(dt));
    dX = B*dt + dW;
    X = X+dX;
    X1(c1) = X;
    c1 = c1+1;
    rt = rt + dt;
end

if X>=thrpos || X<thrneg
    dist = 0;
else
    dist1 = thrpos - X1(c1-1);
    dist2 = X1(c1-1) - thrneg ;
    [dist,I] = min([dist1 dist2]);
    if I ==1
        choice = 1;
    else
        choice = -1;
    end
end

if X>=thrpos
    choice=1;
elseif X<thrneg
    choice= -1;
end


end