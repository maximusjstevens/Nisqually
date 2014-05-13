%use this script to fill in holes in daily data
% e.g. if a day is missing, add the date and put NaNs in for the data
% values.

dayiter=min(dateNu):max(dateNu); %vector of all days from start to end
fulldays=datenum(dayiter);
le=length(dayiter);

complete=zeros(le,7);
complete(:,1)=fulldays;

for jij=1:length(dayiter);
    num=dayiter(jij);
    ind=find(dateNu==num);
            TF = isempty(ind);
        if TF==1
            complete(jij,2:7)=NaN;
        else
            complete(jij,2:7)=clim(ind,1:6); % complete is all of the climate data plus the missing days.
        end
    
end