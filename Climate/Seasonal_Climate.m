%This script makes text files (or just variables) that are separate
%seasonal totals or means at longmire and paradise.

Long=importdata('LongmireMonth_filled.txt');
Para=importdata('ParadiseMonth_filled.txt');

Longdata=Long.data;
Paradata=Para.data;

Longdata=Longdata(95:end,:); % Start in November 1916.
Paradata=Paradata(11:end,:);

seas=1:12:1152;

for ii=1:length(seas)

startind=seas(ii);

fullyearL=Longdata(startind:startind+11,:);
fullyearP=Paradata(startind:startind+11,:);

winterL=fullyearL(1:6,:);
summerL=fullyearL(7:12,:);

winterP=fullyearP(1:6,:);
summerP=fullyearP(7:12,:);

%this bit to use nanmean
% Long_winter(ii,:)=[winterL(end,1) nanmax(winterL(:,3)) nansum(winterL(:,4)) nansum(winterL(:,5)) nanmean(winterL(:,6))];
% Long_summer(ii,:)=[summerL(end,1) nanmax(summerL(:,3)) nansum(summerL(:,4)) nansum(summerL(:,5)) nanmean(summerL(:,6))];
% 
% Para_winter(ii,:)=[winterP(end,1) nanmax(winterP(:,3)) nansum(winterP(:,4)) nansum(winterP(:,5)) nanmean(winterP(:,6))];
% Para_summer(ii,:)=[summerP(end,1) nanmax(summerP(:,3)) nansum(summerP(:,4)) nansum(summerP(:,5)) nanmean(summerP(:,6))];

% this bit to use regular mean
Long_winter(ii,:)=[winterL(end,1) max(winterL(:,3)) sum(winterL(:,4)) sum(winterL(:,5)) mean(winterL(:,6))];
Long_summer(ii,:)=[summerL(end,1) max(summerL(:,3)) sum(summerL(:,4)) sum(summerL(:,5)) mean(summerL(:,6))];

Para_winter(ii,:)=[winterP(end,1) max(winterP(:,3)) sum(winterP(:,4)) sum(winterP(:,5)) mean(winterP(:,6))];
Para_summer(ii,:)=[summerP(end,1) max(summerP(:,3)) sum(summerP(:,4)) sum(summerP(:,5)) mean(summerP(:,6))];
end

% savename1='Longmire_Winter_nan.txt';
% saveme=fopen(savename1,'w');
% fprintf(saveme,'%d\t%d\t%d\t%d\t%.2f\n',Long_winter');
% 
% savename1='Longmire_Summer_nan.txt';
% saveme=fopen(savename1,'w');
% fprintf(saveme,'%d\t%d\t%d\t%d\t%.2f\n',Long_summer');
% 
% savename1='Paradise_Winter_nan.txt';
% saveme=fopen(savename1,'w');
% fprintf(saveme,'%d\t%d\t%d\t%d\t%.2f\n',Para_winter');
% 
% savename1='Paradise_Summer_nan.txt';
% saveme=fopen(savename1,'w');
% fprintf(saveme,'%d\t%d\t%d\t%d\t%.2f\n',Para_summer');

