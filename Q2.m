%%
clc
clear
dt = 1e-3;
N = [0 0];
t1 = 1e-3;
LIP_weights = [80 -.2];
MT_p_values = [.1 0.1];
psth1= 0 ;
c2=0;
for i = 1:1e3
    t1 = t1+dt;
    dN = double(rand(1,2) < MT_p_values);
    N = N+dN;
    N1(i,:) = dN;
    N = N/2;
    p_lip = sum(N.*LIP_weights);
    LIP_sp(i) =  rand < p_lip;
    
    
    if t1>0.0201
        
        psth1 = bin_spikes(LIP_sp,20);
        
    end
%     if psth1(length(psth1))>1
%         N=[0 0];
%         c2 = c2 +1;
%     end
   
end
figure('WindowState','maximized')
t = 1e-3:1e-3:1;
sp = double(LIP_sp);
sp(find(sp==0)) = NaN;
plot(t,sp,'.','LineWidth',2.5)
title('LIP Raster Plot','interpreter','latex')
xlabel('Time(s)','interpreter','latex')
yticks(1)
grid on
grid minor
saveas(gcf,'Fig23.png')
N1(find(N1(:,1)==0),1) = NaN;
N1(find(N1(:,2)==0),2) = NaN;
N1(find(N1(:,2)==1),2) = 2;
figure('WindowState','maximized')
plot(t,N1,'.','LineWidth',2.5)
title('MT Raster Plot','interpreter','latex')
xlabel('Time(s)','interpreter','latex')
yticks([1 2])
ylim([0 3])
yticklabels({'MT+','MT-'})
grid on
grid minor
saveas(gcf,'Fig24.png')

psth2=zeros(1,length(psth1)+1);
psth2(2:end) = psth1;
figure('WindowState','maximized')
t = linspace(0,1,51);

plot(t,smooth(psth2))
title('LIP Neuron Rate','interpreter','latex')
xlabel('Time(s)','interpreter','latex')
ylabel('Rate','interpreter','latex')
grid on
grid minor
saveas(gcf,'Fig25.png')


%%
clc
clear
dt = 1e-3;
N1 = [0 0];
t1 = 1e-3;
for j=1:100
    LIP_weights1 = [0.1 -0.1];
    LIP_weights2 = [-0.1 0.1];
    MT_p_values1 = [.1 0.1];
    
    for i = 1:500
        t1 = t1+dt;
        dN1 = double(rand(1,2) < MT_p_values1);
        N1 = N1+dN1;
        MT1(j,i) = dN1(1);
        MT2(j,i) = dN1(2);
        
        MT11(j,i) = dN1(1)*j;
        MT22(j,i) = dN1(2)*j;
        
        N1 = N1/2;
        p_lip1 = sum(N1.*LIP_weights1);
        LIP_sp1(j,i) =  rand < p_lip1;
        
        LIP_sp11(j,i) =  double(rand < p_lip1)*j;
        p_lip2 = sum(N1.*LIP_weights2);
        LIP_sp2(j,i) =  rand < p_lip2;
        LIP_sp22(j,i) =  double(rand < p_lip2)*j;
    end
    MT_p_values1 = [.5 0.1];
    for i = 501:1000
        t1 = t1+dt;
        dN1 = double(rand(1,2) < MT_p_values1);
        N1 = N1+dN1;
        MT1(j,i) = dN1(1);
        MT2(j,i) = dN1(2);
        
        MT11(j,i) = dN1(1)*j;
        MT22(j,i) = dN1(2)*j;
        N1 = N1/2;
        p_lip1 = sum(N1.*LIP_weights1);
        LIP_sp1(j,i) =  rand < p_lip1;
        LIP_sp11(j,i) =  double(rand < p_lip1)*j;
        p_lip2 = sum(N1.*LIP_weights2);
        LIP_sp2(j,i) =  rand < p_lip2;
        LIP_sp22(j,i) =  double(rand < p_lip2)*j;
    end
end

for i=1:100
    LIP_sp11(i,find(LIP_sp11(i,:)==0)) = NaN;
    LIP_sp22(i,find(LIP_sp22(i,:)==0)) = NaN;
    MT11(i,find(MT11(i,:)==0)) = NaN;
    MT22(i,find(MT22(i,:)==0)) = NaN;
end
t = -0.499:1e-3:0.5;
figure('WindowState','maximized')
plot(t,MT11,'k.','LineWidth',.5)
title('MT1 Raster Plot','interpreter','latex')
xlabel('Time(s)','interpreter','latex')
ylabel('Trial Number','interpreter','latex')
hold on
xline(0,'r--','LineWidth',2)
saveas(gcf,'Fig26.png')

figure('WindowState','maximized')
plot(t,MT22,'k.','LineWidth',.5)
title('MT2 Raster Plot','interpreter','latex')
xlabel('Time(s)','interpreter','latex')
ylabel('Trial Number','interpreter','latex')
hold on
xline(0,'r--','LineWidth',2)
saveas(gcf,'Fig27.png')

figure('WindowState','maximized')
plot(t,LIP_sp11,'k.','LineWidth',.5)
title('LIP1 Raster Plot','interpreter','latex')
xlabel('Time(s)','interpreter','latex')
ylabel('Trial Number','interpreter','latex')
hold on
xline(0,'r--','LineWidth',2)
saveas(gcf,'Fig28.png')

figure('WindowState','maximized')
plot(t,LIP_sp22,'k.','LineWidth',.5)
title('LIP2 Raster Plot','interpreter','latex')
xlabel('Time(s)','interpreter','latex')
ylabel('Trial Number','interpreter','latex')
hold on
xline(0,'r--','LineWidth',2)
saveas(gcf,'Fig29.png')


figure('WindowState','maximized')
psth1 = bin_spikes(LIP_sp1,10);
psth3 = bin_spikes(psth1',100);
psth2=zeros(1,101);
psth2(2:end) = psth3;
t2 = linspace(-0.5,0.5,101);

subplot(2,2,1)
plot(t2,smooth(psth2))
grid on
grid minor
xlabel('Time(s)','interpreter','latex')
ylabel('Rate','interpreter','latex')
title('LIP1 Firing Rate','interpreter','latex')
hold on
xline(0,'r--')


psth1 = bin_spikes(LIP_sp2,10);
psth3 = bin_spikes(psth1',100);
psth2=zeros(1,101);
psth2(2:end) = psth3;
t2 = linspace(-0.5,0.5,101);

subplot(2,2,2)
plot(t2,smooth(psth2))
grid on
grid minor
xlabel('Time(s)','interpreter','latex')
ylabel('Rate','interpreter','latex')
title('LIP2 Firing Rate','interpreter','latex')
hold on
xline(0,'r--')


psth1 = bin_spikes(MT1,10);
psth3 = bin_spikes(psth1',100);
psth2=zeros(1,101);
psth2(2:end) = psth3;
t2 = linspace(-0.5,0.5,101);

subplot(2,2,3)
plot(t2,smooth(psth2))
grid on
grid minor
xlabel('Time(s)','interpreter','latex')
ylabel('Rate','interpreter','latex')
title('MT1 Firing Rate','interpreter','latex')
hold on
xline(0,'r--')


psth1 = bin_spikes(MT2,10);
psth3 = bin_spikes(psth1',100);
psth2=zeros(1,101);
psth2(2:end) = psth3;
t2 = linspace(-0.5,0.5,101);

subplot(2,2,4)
plot(t2,smooth(psth2))
grid on
grid minor
xlabel('Time(s)','interpreter','latex')
ylabel('Rate','interpreter','latex')
title('MT2 Firing Rate','interpreter','latex')
hold on
xline(0,'r--')

saveas(gcf,'Fig30.png')