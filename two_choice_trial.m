function [rt,choice] = two_choice_trial(thrpos,thrneg,vari,X0,B)
dt = vari;
X = X0;
rt = 0;
while X<thrpos && X>thrneg
    dW = normrnd(0,sqrt(dt));
    dX = B*dt + dW;
    X = X+dX;
    rt = rt + dt;
end
if X>=thrpos
    choice=1;
elseif X<thrneg
    choice= -1;
end
end

