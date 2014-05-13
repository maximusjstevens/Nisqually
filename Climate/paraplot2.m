% use this script to make plots showing how monthly snowfall is changing.

yea=1917:2013;
yea=yea';
%mont=[10:12 1:9]

% figure(239);clf;box on;
% imagesc(mo,yea,moPercRec);
% 
% startmo=datenum('10-01-2011');
% endmo=datenum('09-31-2012');
% xdate = linspace(startmo,endmo,12);
% set(gca,'XTick',mo);
% months2 = ['Oct';
%           'Nov';
%           'Dec';
%           'Jan';
%           'Feb';
%           'Mar';
%           'Apr';
%           'May';
%           'Jun';
%           'Jul';
%           'Aug';
%           'Sep'];
% set(gca,'XTickLabel',months2,'fontsize',14)
% %colorbar%('title','% of Total Water-Year Snowfall')%,'fontweight','bold');
% t = colorbar;
% set(t,'fontsize',14);
% %ytick(t,'fontsize',14);
% ylabel(t,'% of total annual snowfall','fontsize',14);
% %set(get(t,'ylabel'),'ylabel','My Title');
% title('Monthly snowfall as a percentage of total water-year snowfall at Paradise, 1961-2013','fontsize',16);
% %datetick('x',3,'keepticks')
% saveas(gcf,'blah4.eps','epsc')
% 
nove=moPercRec(:,2);
els=~isnan(nove);
[nco]=polyfit(yea(els),nove(els),1);
nfit=polyval(nco,yea);

dece=moPercRec(:,3);
els=~isnan(dece);
dco=polyfit(yea(els),dece(els),1);
dfit=polyval(dco,yea);

janu=moPercRec(:,4);
els=~isnan(janu);
jco=polyfit(yea(els),janu(els),1);
jfit=polyval(jco,yea);

febr=moPercRec(:,5);
els=~isnan(febr);
fco=polyfit(yea(els),febr(els),1);
ffit=polyval(fco,yea);

marc=moPercRec(:,6);
els=~isnan(marc);
mco=polyfit(yea(els),marc(els),1);
mfit=polyval(mco,yea);

apri=moPercRec(:,7);
els=~isnan(nove);
aco=polyfit(yea(els),apri(els),1);
afit=polyval(aco,yea);

figure(256);
clf;hold on;
subplot(6,1,1);
hold on;
plot(yea,nove);
plot(yea,nfit,'k');
title('November','fontsize',12,'fontweight','bold');

subplot(6,1,2);hold on;
plot(yea,dece);
plot(yea,dfit,'k');
title('December','fontsize',12,'fontweight','bold');

subplot(613);hold on;
plot(yea,janu);
plot(yea,jfit,'k');
title('January','fontsize',12,'fontweight','bold');

subplot(614);hold on;
plot(yea,febr);
plot(yea,ffit,'k');
title('February','fontsize',12,'fontweight','bold')

subplot(615);hold on;
plot(yea,marc);
plot(yea,mfit,'k');
title('March','fontsize',12,'fontweight','bold');

subplot(616);hold on;
plot(yea,apri);
plot(yea,afit,'k');
title('April','fontsize',12,'fontweight','bold')

% figure(2342);
% clf;
% hold on;box on;grid on;
% plot(yea,nove,'b');
% plot(yea,dece,'r');
% plot(yea,janu,'g');
% plot(yea,febr,'k');
% plot(yea,marc,'m');
% plot(yea,apri,'c');




