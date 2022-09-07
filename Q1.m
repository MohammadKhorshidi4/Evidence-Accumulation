%%
clc
clear 
B = 1;
si = 1;
dt = .1;

X1 = zeros(1e4,101);
t = 0:.1:20;
for i = 1:1e4
    X = 0;
    X1(i,1)=0;
    for q=1:100
        dW = normrnd(0,sqrt(dt));
        dX = B * dt + si*dW;
        X = X + dX;
        X1(i,q+1) = X;
    end
    choice1(i) = double(X>0);
end
p1 = sum(choice1)/length(choice1);
p2 = [1-p1 p1];
p = 1 - normcdf(0,B*20,sqrt(dt));
p3 = [1-p p];
p4 = [1-p1 1-p;p1 p];
figure('WindowState','maximized')
plot(X1')
xlim([1,11])
grid on
grid minor
xticks([1 3 5 7 9 11])
xticklabels({'0','0.2','0.4','0.6','0.8','1'})
xlabel('Time(s)','interpreter','latex')
ylabel('X(t)','interpreter','latex')
title('The Variation of X(t) during Trials','interpreter','latex')
saveas(gcf,'Fig1.png')



figure('WindowState','maximized')
bar([0,1],p4)

xticklabels({'0','1'})
legend('The Counted Value of p','The ideal value of p','interpreter','latex')
title('The probablity of Choice 1 and 0','interpreter','latex')
saveas(gcf,'Fig2.png')


%%
clc
clear
B1 = [1,10,0,.1,-1];

si = 1;
dt = .1;
t = 0:.1:10;

for i =1:5
    B = B1(i);
    X1 = zeros(1e4,101);
    for j = 1:1e4
        X = 0;
        X1(j,1)=0;
        for q=1:100
            dW = normrnd(0,sqrt(dt));
            dX = B * dt + si*dW;
            X = X + dX;
            X1(j,q+1) = X;
        end
        choice1(j) = double(X>0);
    end
    X2(i,:,:) = X1;
    p1 = sum(choice1)/length(choice1);
    p2 = [1-p1 p1];
    p = 1 - normcdf(0,B*10,sqrt(10));
    p3 = [1-p p];
    p4 = [1-p1 1-p;p1 p];
    figure('WindowState','maximized')
    bar([0,1],p4)

    xticklabels({'0','1'})
    legend('The Counted Value of p','The ideal value of p','interpreter','latex')
    title(['The probablity of Choice 1 and 0 where B = ',num2str(B1(i))],'interpreter','latex')
    saveas(gcf,['Fig',num2str(i+2),'.png'])
end

%%
clc
clear
B = .1;
si = 1;
dt = .1;


t = 0.4:.4:10;

p5 = [];
for q = 1:25
    for i = 1:1e5
        X = 0;
        X1(i,1)=0;
        dW1 = normrnd(0,sqrt(dt),floor(t(q)/dt),1);
        B1 = ones(floor(t(q)/dt),1) * B *dt;
        X = sum(B1) + sum(dW1);
        choice1(i) = double(X>0);
    end
    p1 = sum(choice1)/length(choice1);
    p = 1 - normcdf(0,B*t(q),sqrt(t(q)));
    p4 = [1-p1 1-p];
    p5(q,:) = p4;
end
figure('WindowState','maximized')
bar(t,p5)
xlabel('Time(s)','interpreter','latex')
xticks(t)
legend('The Counted Value of error rate','The ideal value of error rate','interpreter','latex')
title('The Error Rates','interpreter','latex')
saveas(gcf,'Fig8.png')


%%
clc
clear 
B = .1;
si = 1;
dt = .1;

X1 = zeros(1e4,11);
t = 0:.1:10;
for i = 1:1e4
    X = 0;
    X1(i,1)=0;
    for q=1:100
        dW = normrnd(0,sqrt(dt));
        dX = B * dt + si*dW;
        X = X + dX;
        X1(i,q+1) = X;
    end
    
    choice1(i) = double(X>0);
end
for i = 1:101
    X2 = X1(:,i);
    v1(i) = std(X2);
end
m1 = mean(X1);
figure('WindowState','maximized')
plot(t,X1')
hold on

plot(t,m1,'LineWidth',5.5)

xlabel('Time(s)','interpreter','latex')
title('Variaton of X(t) versus mean of X(t)','interpreter','latex')
saveas(gcf,'Fig9.png')


figure('WindowState','maximized')
plot(t,B*t)
hold on
plot(t,m1)
legend('The ideal Mean','The Calculated Mean','interpreter','latex')
xlabel('Time(s)','interpreter','latex')
title('The mean of X(t)','interpreter','latex')
grid on
grid minor
saveas(gcf,'Fig10.png')

figure('WindowState','maximized')
plot(t,v1)
hold on
plot(t,sqrt(si*t))
legend('The ideal Variance','The Calculated Variance','interpreter','latex')
xlabel('Time(s)','interpreter','latex')
title('The Variance of X(t)','interpreter','latex')
grid on
grid minor
saveas(gcf,'Fig11.png')


%%

%%
clc
clear
B1 = [.1 0 -.1];
t1 = [1 10];
X0 = [1 0 -1];
c1=1;
c2=1;
for i =1:3
    B = B1(i);
    for j=1:2
        t = t1(j);
        for q = 1:3
            X = X0(q);
            for rt = 1:1e3
                pr(rt) = rand<simple_model2(B,t,1,X);
            end
            p(c1) = sum(pr)/length(pr);
            ind{c2} = [' B= ',num2str(B),' T= ',num2str(t),' X0= ',num2str(X)];
            c1 = c1+3;
            c2=c2+1;
            
        end
    end
end
figure('WindowState','maximized')
bar(p)
xticks(1:6:53)
xticklabels(ind(1:2:end))
title('The probability for different biasses and times and start points','interpreter','latex')
saveas(gcf,'Fig12.png')

%%
%%
clc
clear
B = .1;
vari = 0.1;
thr1 = 5;
thr2 = -5;
X0 = 0;
for i=1:1e4
    [rt(i),choice(i)] = two_choice_trial(thr1,thr2,vari,X0,B);
end
figure('WindowState','maximized')
histogram(rt(find(choice==-1)),'Normalization','probability')
title('p(RT|-1)')
xlabel('Reaction Time','Interpreter','latex')
ylabel('Probability','Interpreter','latex')
saveas(gcf,'Fig13.png')


figure('WindowState','maximized')
histogram(rt(find(choice==1)),'Normalization','probability')
title('p(RT|1)')
xlabel('Reaction Time','Interpreter','latex')
ylabel('Probability','Interpreter','latex')
saveas(gcf,'Fig14.png')

figure('WindowState','maximized')
histogram(rt,'Normalization','probability')
title('p(RT)')
xlabel('Reaction Time','Interpreter','latex')
ylabel('Probability','Interpreter','latex')
saveas(gcf,'Fig15.png')

rt1 = mode(rt,'all');
ind2 = find(rt==rt1);
pc = find(choice(ind2) == 1);
pc = length(pc)/length(ind2);
err = 1-pc;

figure('WindowState','maximized')
p = simple_model2(.1,rt1,vari,0);
bar([0 1],[err 1-p;pc p])
xticklabels({['p(choice = -1|RT = ',num2str(mode(rt,'all')),')'],['p(choice = 1|RT = ',num2str(mode(rt,'all')),')']})
title(['p(choice|RT = ',num2str(mode(rt,'all')),') The most Frequent value of RT has Chosen'])
legend('The Calculated Probability','The Probability from simple model2')
saveas(gcf,'Fig16.png')

%%

%%
clc
clear
B = .1;
vari=.1;
thrpos = 5;
thrneg = -5;
X0 = 0;
[rt1,choice1,X1] = Race(thrpos,thrneg,vari,X0,B);
t1 = 0:vari:(length(X1)-1)*vari;
B=-.1;
[rt2,choice2,X2] = Race(thrpos,thrneg,vari,X0,B);
t2 = 0:vari:(length(X2)-1)*vari;
figure('WindowState','maximized')
plot(t1,X1)
hold on
plot(t2,X2)
hold on 
yline(5,'k')
hold on
yline(-5,'k')
grid on
grid minor
legend('$${X_1}$$','$${X_2}$$','Threshold','interpreter','latex')
[mi,I1] = min([rt1 rt2]);
title(['The winner is $${X_{',num2str(I1),'}}$$'],'interpreter','latex')
saveas(gcf,'Fig17.png')

vari=.1;
thrpos = 5;
thrneg = -5;
X0 = 0;
for i=1:1e4
    B = .1;
    [rt1,choice1,X1] = Race(thrpos,thrneg,vari,X0,B);
    B=-.1;
    [rt2,choice2,X2] = Race(thrpos,thrneg,vari,X0,B);
    [mi,I1(i)] = min([rt1 rt2]);
    I1(i) = I1(i) - 1;
end
p = sum(I1)/length(I1);
figure('WindowState','maximized')
bar([0 1],[1-p p])
title('Probability of Win with B=0.1 for $${X_1}$$ and B=-0.1 for $${X_2}$$','interpreter','latex')
xticklabels({'X_1','X_2'})
saveas(gcf,'Fig18.png')


for i=1:1e4
    X0 = 1;
    B = .1;
    [rt1,choice1,X1] = Race(thrpos,thrneg,vari,X0,B);
    B=-.1;
    X0 = 0;
    [rt2,choice2,X2] = Race(thrpos,thrneg,vari,X0,B);
    [mi,I1(i)] = min([rt1 rt2]);
    I1(i) = I1(i) - 1;
end
p = sum(I1)/length(I1);
figure('WindowState','maximized')
bar([0 1],[1-p p])
title('Probability of Win with B=0.1 for $${X_1}$$ and B=-0.1 for $${X_2}$$ with different starting points 1 for $${X_1}$$'...
    ,'interpreter','latex')
xticklabels({'X_1','X_2'})
saveas(gcf,'Fig19.png')

X0 = 0 ;
for i=1:1e4
    B = .2;
    [rt1,choice1,X1] = Race(thrpos,thrneg,vari,X0,B);
    B=-.1;
    [rt2,choice2,X2] = Race(thrpos,thrneg,vari,X0,B);
    [mi,I1(i)] = min([rt1 rt2]);
    I1(i) = I1(i) - 1;
end
p = sum(I1)/length(I1);
figure('WindowState','maximized')
bar([0 1],[1-p p])
title('Probability of Win with B=0.2 for $${X_1}$$ and B=-0.1 for $${X_2}$$','interpreter','latex')
xticklabels({'X_1','X_2'})
saveas(gcf,'Fig20.png')


for i=1:1e4
    B = .1;
    [rt1,choice1,X1] = Race(thrpos-1,thrneg,vari,X0,B);
    B=-.1;
    [rt2,choice2,X2] = Race(thrpos,thrneg,vari,X0,B);
    [mi,I1(i)] = min([rt1 rt2]);
    I1(i) = I1(i) - 1;
end
p = sum(I1)/length(I1);
figure('WindowState','maximized')
bar([0 1],[1-p p])
title('Probability of Win with B=0.1 for $${X_1}$$ and B=-0.1 for $${X_2}$$ with different Threshold 4 for positive threshold for $${X_1}$$','interpreter','latex')
xticklabels({'X_1','X_2'})
saveas(gcf,'Fig21.png')

%%
clc
clear
B = .1;
vari=.1;
thrpos = 5;
thrneg = -5;
tim = 1;
X0 = 0;
[rt1,choice1,X1,dist1] = Race_1(thrpos,thrneg,vari,X0,B,tim);
t1 = 0:vari:(length(X1)-1)*vari;
B=-.1;
[rt2,choice2,X2,dist2] = Race_1(thrpos,thrneg,vari,X0,B,tim);
t2 = 0:vari:(length(X2)-1)*vari;
figure('WindowState','maximized')
plot(t1,X1)
hold on
plot(t2,X2)
hold on 
yline(5,'k')
hold on
yline(-5,'k')
grid on
grid minor
legend('$${X_1}$$','$${X_2}$$','Threshold','interpreter','latex')


if dist1 ~= 0 && dist2~=0
    [mi,I1] = min([dist1 dist2]);
else
    [mi,I1] = min([rt1 rt2]);
end

title(['The winner is $${X_{',num2str(I1),'}}$$ ; distance 1 is ', num2str(dist1),...
    ' and distance 2 is ',num2str(dist2)],'interpreter','latex')
saveas(gcf,'Fig22.png')




%%
clc
clear

vari=.1;
thrpos = 5;
thrneg = -5;

tim1 = 1:20;

for j = 1:length(tim1)
    tim = tim1(j);
    for i = 1:1e4    
        B = .1;
        X0 = 0;
        [rt1,choice1,X1,dist1] = Race_1(thrpos,thrneg,vari,X0,B,tim);
        t1 = 0:vari:(length(X1)-1)*vari;
        B=-.1;
        [rt2,choice2,X2,dist2] = Race_1(thrpos,thrneg,vari,X0,B,tim);

        if dist1 ~= 0 && dist2~=0
            [mi,I1] = min([dist1 dist2]);
        else
            [mi,I1] = min([rt1 rt2]);
        end
        P1(i) = I1;
    end
    p11 = length(find(P1==1))/1e4;
    P2(j,:) = [p11,1-p11];
end
    
    
% t2 = 0:vari:(length(X2)-1)*vari;
% figure('WindowState','maximized')
% plot(t1,X1)
% hold on
% plot(t2,X2)
% hold on 
% yline(5,'k')
% hold on
% yline(-5,'k')
% grid on
% grid minor
% legend('$${X_1}$$','$${X_2}$$','Threshold','interpreter','latex')
% 
% 
% 
% 
% title(['The winner is $${X_{',num2str(I1),'}}$$ ; distance 1 is ', num2str(dist1),...
%     ' and distance 2 is ',num2str(dist2)],'interpreter','latex')
% saveas(gcf,'Fig31.png')



%%
figure('WindowState','maximized')


% p22 = 1 - p11;

bar(tim1,P2)
xlabel('Time(s)','Interpreter','latex')
ylabel('Probability','Interpreter','latex')
title('Wininng Probability Over Time','Interpreter','latex')
legend('$X_{1}$','$X_{2}$','Interpreter','latex')
saveas(gcf,'Fig32.png')

