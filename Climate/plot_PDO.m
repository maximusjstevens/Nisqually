close all;

% Select a starting date:
startDate = datenum('01-1900');
% Select an ending date:
endDate = datenum('12-2012');
% Create xdata to correspond to the number of 
% months between the start and end dates:
xData = linspace(startDate,endDate,12);
% For this example, plot random data:
figure(3);clf;
plot(xData,rand(1,12))
% Set the number of XTicks to the number of points
% in xData:
set(gca,'XTick',xData)
datetick('x','mmm','keepticks')

% 
figure(1);
clf;
hold on;
plot(hld,data_3,'x');
%set(gca,'XTick',0:12:1356)
%set(gca,'XTickLabel',years5(1:60:end))
plot(hld,line);

stop=144;
line2=line(end-stop:end);

figure(2);
clf;
hold on;
plot(data_3(end-stop:end));
set(gca,'XTick',0:12:1356)
set(gca,'XTickLabel',years5(1:60:end))
plot(line2,'r');

figure(5);
clf;
hold on;
[AX,H1,H2] = plotyy(hld1921,snow5,hld1921,pdo_plot,'bar','plot');






