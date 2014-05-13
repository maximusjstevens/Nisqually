close all;clear all;

climate=importdata('ParaClim.txt','\t');
A_ANmeans=importdata('Nisq_all_A.txt','\t');
B_ANmeans=importdata('Nisq_all_B.txt','\t');
C_ANmeans=importdata('Nisq_all_C.txt','\t');

Climtime=climate(:,1); %date
precip=climate(:,2); %daily precip, mm
snowfall=climate(:,3); % daily snowfall, mm
snowdepth=climate(:,4); % total snow, mm
Tmax=climate(:,5); % maximum daily temperature, C
Tmin=climate(:,6); % minmum daily temp, C
Tobs=climate(:,7); % observed daily temp, C

TA=A_ANmeans(:,1);
TB=B_ANmeans(:,1);
TC=C_ANmeans(:,1);
A=A_ANmeans(:,2);
B=B_ANmeans(:,2);
C=C_ANmeans(:,2);
Amean=mean(A);
Bmean=mean(B);
Cmean=mean(C);

Anorm=A/Amean;
Bnorm=B/Bmean;
Cnorm=C/Cmean;

Ap=Anorm-1;
Bp=Bnorm-1;
Cp=Cnorm-1;

zp=[0 0];
za=[1930 2020];
% figure(1);
% clf;
% box on;grid on;
% plot(time(end-100:end),snowdepth(end-100:end));
% 
% figure(2);
% clf;
% box on;
% plot(asdf,snowdepth(end-100:end))

figure(3);
clf;
box on;
plot(snowdepth)

figure(4);
clf;
hold on;
box on;
grid on;
plot(TA,Ap,'b','linewidth',1.5);
plot(TB,Bp,'g','linewidth',1.5);
plot(TC,Cp,'r','linewidth',1.5);
plot(za,zp,'k','linewidth',1.5);
LH=legend('Profile A','Profile B','Profile C','line');
RL=legend(LH,'Profile A','Profile B','Profile C');
set(RL,'fontsize',14);
title('Transect Elevation Normalized to Transect Mean','fontsize',18);
ylabel('Normalized Elevation','fontsize',16);
xlabel('Year','fontsize',16);
set(gca,'fontsize',14);
