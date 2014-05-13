% plot nisqually things

close all;clear all;

all_A=importdata('Nisq_all_A.txt');
spr_A=importdata('Nisq_spring_A.txt');
fall_A=importdata('Nisq_fall_A.txt');
est_A=importdata('Nisq_est_A.txt');

all_B=importdata('Nisq_all_B.txt');
spr_B=importdata('Nisq_spring_B.txt');
fall_B=importdata('Nisq_fall_B.txt');
est_B=importdata('Nisq_est_B.txt');

all_C=importdata('Nisq_all_C.txt');
spr_C=importdata('Nisq_spring_C.txt');
fall_C=importdata('Nisq_fall_C.txt');
est_C=importdata('Nisq_est_C.txt');

figure(1);
box on;hold on;

plot(all_A.data(:,1),all_A.data(:,2))
plot(spr_A.data(:,1),spr_A.data(:,2),'k+')
plot(fall_A.data(:,1),fall_A.data(:,2),'k.')
plot(est_A.data(:,1),est_A.data(:,2),'r.')



