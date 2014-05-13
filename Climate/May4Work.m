%Paradise climate processing
 %clear all;close all;
ParaClim=importdata('ParaClim.txt');
snow=importdata('Paradise_snow.txt');

dates=ParaClim(:,1);
[dateNu,dateVe,dateSt]=convertdates(dates);

clim=ParaClim(:,2:end);
fullClim=[dateVe clim];

completeClimate
monthlyClim
datastackSnow

daysnow=[dateNu fullClim(:,5)];
%moPercRec=moPerc(45:end,:);
moPercRec=moPerc;

paraplot2