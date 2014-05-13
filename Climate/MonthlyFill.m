%use this script to fill in holes in monthly data.
% e.g. if a month is missing, add the date and put NaNs in for the data
% values.
monthly=importdata('Longmire_Monthly_interest.txt');
monthlydata=monthly.data;

dates=monthlydata(:,1);
[PdateNu,PdateVe,PdateSt]=convertdates(dates);

years=PdateVe(:,1);
mont=PdateVe(:,2);
year1=min(years);
yearend=max(years);
fullyears=year1:yearend;

yemo=repmat(fullyears,12,1);
yemo=reshape(yemo,[],1);

months=1:12;
mos=repmat(months,1,length(fullyears));
mos=reshape(mos,[],1);

yemo_vec=[yemo mos];

DataOut=[NaN NaN NaN NaN NaN NaN];

for jj=1:length(fullyears);
    for ii=1:12        
        
         yoi=fullyears(jj);
         moi=ii;
        
        ind=find(PdateVe(:,1)==yoi & PdateVe(:,2)==moi);
        
        tf=isempty(ind);
                
            if tf==1
                newrow=[yoi moi -9999 -9999 -9999 -9999];
            else
                newrow=[yoi moi monthlydata(ind,2) monthlydata(ind,3) monthlydata(ind,4) monthlydata(ind,5)]; % complete is all of the climate data plus the missing days.
            end
            
            DataOut=[DataOut; newrow];
            
    end
end

asd=find(DataOut==-9999);
DataOut(asd)=NaN;

DataOut=DataOut(2:end,:);

savename='LongmireMonth_filled.txt';
saveme=fopen(savename,'w');
fprintf(saveme,'%d\t%d\t%d\t%d\t%d\t%d\n',DataOut');
