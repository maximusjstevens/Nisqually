%compare just winter or summer data
% run along with Seasonal_Climate, probably.
close all;
%theseason='summer';
theseason='winter';

% var1=sprintf('Long_%s',theseason);
% var2=sprintf('Para_%s',theseason);

if theseason=='summer'
    
Long_MXSD=Long_summer(:,2);
Para_MXSD=Para_summer(:,2);

Long_TSNW=Long_summer(:,3);
Para_TSNW=Para_summer(:,3);

Long_TPCP=Long_summer(:,4);
Para_TPCP=Para_summer(:,4);

Long_MNTM=Long_summer(:,5);
Para_MNTM=Para_summer(:,5);

elseif theseason=='winter'

Long_MXSD=Long_winter(:,2);
Para_MXSD=Para_winter(:,2);

Long_TSNW=Long_winter(:,3);
Para_TSNW=Para_winter(:,3);

Long_TPCP=Long_winter(:,4);
Para_TPCP=Para_winter(:,4);

Long_MNTM=Long_winter(:,5);
Para_MNTM=Para_winter(:,5);

end

%asdf=ones(numel(Long_TPCP),1);
%Long_TPCP_s=[Long_TPCP asdf];
%[P_reg,BINT,R,RINT,STATS]=regress(Para_TSNW,Long_TPCP_s);

validdata1 = ~isnan(Para_TSNW) & Para_TSNW>5000;
validdata2 = ~isnan(Long_TPCP);
validdataBoth = validdata1 & validdata2;
keep1 = Para_TSNW(validdataBoth);
keep2 = Long_TPCP(validdataBoth);

P=polyfit(keep2, keep1, 1);
xx=1:25000;
rline=polyval(P,xx);
%P=polyfit(Long_TPCP,Para_TSNW,1);


figure(123);
plot(Long_MXSD,Para_MXSD,'k+');
xlabel('Longmire')
ylabel('Paradise')
title('Maximum Snow Depth')
figure(124);
plot(Long_TSNW,Para_TSNW,'b*');
title('Total Snow')
xlabel('Longmire')
ylabel('Paradise')
figure(125);
plot(Long_TPCP,Para_TPCP,'ro');
title('Total Precip')
xlabel('Longmire')
ylabel('Paradise')

figure(89);
clf;
hold on;
plot(keep2,keep1,'k*')
plot(xx,rline,'k','linewidth',2)
%axis([0 8000 0 10000])

%legend('Maximum Snow Depth','Total Snow','Total Precip');
if theseason=='summer'
SnowEx=[Long_summer(:,1) Long_TPCP Para_TSNW];
elseif theseason=='winter'
SnowEx=[Long_winter(:,1) Long_TPCP Para_TSNW];
end

validdata3 = Para_MXSD>1000;
validdata4 = Para_TSNW>5000;
validdataBoth = validdata3 & validdata4;
keep3 = Para_MXSD(validdataBoth);
keep4 = Para_TSNW(validdataBoth);

P2=polyfit(keep3, keep4, 1);
xx=1:12000;
rline2=polyval(P2,xx);

figure(230);
hold on;
plot(keep3,keep4,'+')
plot(xx,rline2,'k')





