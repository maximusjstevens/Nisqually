% this script builds a matrix that is the convolved matrix: montly values
% in each column, each row is a different year.
% moPerc is the "normalized" snowfall: the monthly snowfall/total for that
% year.

%snowStack is built in monthlyClim.m

dStack=snowStack; %don't really need this;

[rows cols]=size(dStack);

for iii=1:rows-1;
convStack(iii,:)=[dStack(iii,10:12) dStack(iii+1,1:9)]; %montly total snowfall
end

[rows2 cols]=size(convStack);

for jj=1:rows2
    totalSnow(jj)=nansum(convStack(jj,:)); %total snow for that year
    moPerc(jj,:)=100*convStack(jj,:)./totalSnow(jj); %montly as a percentage
end
    
