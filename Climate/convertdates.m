function [dateNu,dateVe,dateSt]=convertdates(dates)
%  convertdates(dates)  Converts dates of form YYYYMMDD
%               to datevec, datenum, and datestr

date_str=num2str(dates);

year=str2num(date_str(:,1:4));
month=str2num(date_str(:,5:6));
day=str2num(date_str(:,7:8));

dateNu=datenum(year,month,day);
dateVe=datevec(dateNu);
dateVe=dateVe(:,1:3);
dateSt=datestr(dateNu);