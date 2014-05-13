% get an estimate of what snowfall may have been at paradise for the
% missing years. Need to run SeasonCompare.m first.



years=[1944 1945 1946 1948 1949 1950 1951 1952 1953 1954];

for jj=1:length(years)
    year=years(jj);
    ind=find(Long_winter(:,1)==year);
    
    LT=Long_winter(ind,4);
    
    PTS=polyval(P,LT);
    
    PT(jj,:)=[year PTS];
    
end