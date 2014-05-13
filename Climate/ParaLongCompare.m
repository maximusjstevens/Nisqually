Long=importdata('LongmireMonth_filled.txt');
Para=importdata('ParadiseMonth_filled.txt');

Longdata=Long.data;
Paradata=Para.data;

Longdata=Longdata(95:end,:);
Paradata=Paradata(11:end,:);

Long_MXSD=Longdata(:,3);
Para_MXSD=Paradata(:,3);

Long_TSNW=Longdata(:,4);
Para_TSNW=Paradata(:,4);

Long_TPCP=Longdata(:,5);
Para_TPCP=Paradata(:,5);

Long_MNTM=Longdata(:,6);
Para_MNTM=Paradata(:,6);

%asdf=ones(numel(Long_TPCP),1);
%Long_TPCP_s=[Long_TPCP asdf];
%[P_reg,BINT,R,RINT,STATS]=regress(Para_TSNW,Long_TPCP_s);

validdata1 = ~isnan(Para_TSNW);
validdata2 = ~isnan(Long_TPCP);
validdataBoth = validdata1 & validdata2;
keep1 = Para_TSNW(validdataBoth);
keep2 = Long_TPCP(validdataBoth);

P=polyfit(keep2, keep1, 1);
xx=1:8000;
rline=polyval(P,xx);
%P=polyfit(Long_TPCP,Para_TSNW,1);


figure(123);
plot(Long_MXSD/10,Para_MXSD/10,'k+');
xlabel('Longmire (cm)','fontsize',16)
ylabel('Paradise (cm)','fontsize',14)
title('Maximum Monthly Snow Depth','fontsize',14)

figure(124);
plot(Long_TSNW/10,Para_TSNW/10,'b*');
title('Total Monthly Winter Snowfall','fontsize',16)
xlabel('Longmire (cm)','fontsize',14)
ylabel('Paradise (cm)','fontsize',14)

figure(125);
plot(Long_TPCP/10,Para_TPCP/10,'ro');
title('Total Monthly Precipitation','fontsize',16)
xlabel('Longmire (cm)','fontsize',14)
ylabel('Paradise (cm)','fontsize',14)

figure(89);
clf;
hold on;
box on;
plot(Long_TPCP/10,Para_TSNW/10,'k*')
plot(xx,rline,'k','linewidth',2)
axis([0 800 0 1000])
title('Total Precipitation at Longmire vs Snow at Paradise','fontsize',16)
xlabel('Longmire (cm)','fontsize',14)
ylabel('Paradise (cm)','fontsize',14)

%legend('Maximum Snow Depth','Total Snow','Total Precip');

SnowEx=[Longdata(:,1:2) Long_TPCP Para_TSNW];


