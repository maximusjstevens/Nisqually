%detrending transects
% 10/16: All sorts of ways of looking at the data. Detrending, etc.

%close all;
% clear all;

transA=importdata('Nisq_all_A.txt');
transB=importdata('Nisq_all_B.txt');
transC=importdata('Nisq_all_C.txt');

trans_year_A=transA(:,1); %years of measurements
trans_year_B=transB(:,1);
trans_year_C=transC(:,1);

trans_el_A=transA(:,2); %actual elevations
trans_el_B=transB(:,2);
trans_el_C=transC(:,2);

dtrendCon_A=detrend(transA(:,2),'constant'); % Constant detrend (see help)
dtrendCon_B=detrend(transB(:,2),'constant');
dtrendCon_C=detrend(transC(:,2),'constant');

dtrend_A=detrend(transA(:,2)); %detrended data
dtrend_B=detrend(transB(:,2));
dtrend_C=detrend(transC(:,2));

gradA=gradient(trans_el_A,trans_year_A); % gradient of the raw elevation data
gradB=gradient(trans_el_B,trans_year_B);
gradC=gradient(trans_el_C,trans_year_C);

diffA=diff(trans_el_A); % derivative of the raw elevation data
diffB=diff(trans_el_B);
diffC=diff(trans_el_C);

normA=trans_el_A./nanmean(trans_el_A);
normB=trans_el_B./nanmean(trans_el_B);
normC=trans_el_C./nanmean(trans_el_C);

normA2=(trans_el_A-nanmean(trans_el_A))/nanmean(trans_el_A);
normB2=(trans_el_B-nanmean(trans_el_B))/nanmean(trans_el_B);
normC2=(trans_el_C-nanmean(trans_el_C))/nanmean(trans_el_C);

figure(1);hold on;
grid on;
plot(transA(:,1),trans_el_A,'b');
plot(transB(:,1),trans_el_B,'k');
plot(transC(:,1),trans_el_C,'r');

figure(2);hold on;
grid on;
plot(transA(:,1),dtrendCon_A,'b');
plot(transB(:,1),dtrendCon_B,'k');
plot(transC(:,1),dtrendCon_C,'r');

figure(3);hold on;
grid on;
plot(transA(:,1),dtrend_A,'b');
plot(transB(:,1),dtrend_B,'k');
plot(transC(:,1),dtrend_C,'r');

figure(4);hold on;
grid on;
plot(transA(:,1),gradA,'b');
plot(transB(:,1),gradB,'k');
plot(transC(:,1),gradC,'r');

figure(5);hold on;
grid on;
plot(transA(1:end-1,1),diffA,'b');
plot(transB(1:end-1,1),diffB,'k');
plot(transC(1:end-1,1),diffC,'r');

figure(6);hold on;
grid on;
plot(transA(:,1),normA,'b');
plot(transB(:,1),normB,'k');
plot(transC(:,1),normC,'r');

figure(7);hold on;
grid on;
plot(transA(:,1),normA2,'b');
plot(transB(:,1),normB2,'k');
plot(transC(:,1),normC2,'r');

figure(8);clf;hold on;
grid on;
plot(transA(end-10:end,1),dtrend_A(end-10:end),'b','linewidth',1.5);
plot(transB(end-10:end,1),dtrend_B(end-10:end),'k','linewidth',1.5);
plot(transC(end-10:end,1),dtrend_C(end-10:end),'r','linewidth',1.5);
legend('Transect A','Transect B','Transect C')
xlabel('Year','fontsize',18)
ylabel('Detrended Surface Elevation (m)','fontsize',18)
title('Detrended Transect elevations','fontsize',20)
