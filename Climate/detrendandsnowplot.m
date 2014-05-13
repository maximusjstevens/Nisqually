%run transect detrend first.

%run get_missing... first to get the PT numbers.
snow=ParadiseSnow;
% yrs=PT(:,1);
% PT_in=PT;
% PT_in(:,2)=PT_in(:,2)/25.4;
% 
% for jjj=1:length(yrs)
%     
%     yr=yrs(jjj);
%     ind=find(snow(:,1)==yr);
%     snow(ind,2)=PT_in(jjj,2);
%         
% end

snowmean=snow(:,2)/nanmean(snow(:,2));
snowplot=20*(snowmean-1);

% for jjj=1:length(yrs)
%     yr=yrs(jjj);
%     ind=find(snow(:,1)==yr);
%     in_snowplot(jjj,:)=[yr snowplot(ind)];
%         
% end

lag1=0;
lag2=2*lag1;

figure(36);clf;hold on;
box on;grid on;
%bar(snow(:,1),snowplot);
%bar(in_snowplot(:,1),in_snowplot(:,2),'r');
plot(transA(:,1)-lag2,dtrend_A,'b','linewidth',1.5);
plot(transB(:,1)-lag1,dtrend_B,'k','linewidth',1.5);
plot(transC(:,1),dtrend_C,'r','linewidth',1.5);
%legend('Snowfall at Paradise','Transect A','Transect B','Transect C')
legend('Transect A','Transect B','Transect C')
xlabel('Year','fontsize',18)
% ylabel('Normalized Snowfall and Detrended Surface Elevation','fontsize',18)
% title('Transect elevations and Snowfall at Paradise','fontsize',20)
ylabel('Detrended Surface Elevation (m)','fontsize',18)
title('Detrended Transect elevations','fontsize',20)
axis([1930 2013 -40 30])

long_snow=Long_winter(:,3);
long_snowmean=long_snow/nanmean(long_snow);
long_snowplot=20*(long_snowmean-1);

figure(1234);clf;
hold on;
box on;grid on;
bar(Long_winter(15:end,1),long_snowplot(15:end));
plot(transA(:,1)-lag2,dtrend_A,'b','linewidth',1.5);
plot(transB(:,1)-lag1,dtrend_B,'k','linewidth',1.5);
plot(transC(:,1),dtrend_C,'r','linewidth',1.5);
legend('Snowfall at Longmire','Transect A','Transect B','Transect C')
xlabel('Year','fontsize',18)
ylabel('Normalized Snowfall and Detrended Surface Elevation','fontsize',18)
title('Transect elevations and Snowfall at Longmire','fontsize',20)
axis([1930 2013 -40 30])



