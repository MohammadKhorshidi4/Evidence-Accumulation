function [rt,choice,X1] = Race(thrpos,thrneg,vari,X0,B)
dt = vari;
X = X0;
rt = 0;
c1 = 2;
X1(1) = X0;
while X<thrpos && X>thrneg
    dW = normrnd(0,sqrt(dt));
    dX = B*dt + dW;
    X = X+dX;
    X1(c1) = X;
    c1 = c1+1;
    rt = rt + dt;
end
if X>=thrpos
    choice=1;
elseif X<thrneg
    choice= -1;
end
end