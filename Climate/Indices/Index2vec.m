%Max Stevens 6/6/13
% This script loads all of the climate indices that I am interested in
% (right now) and turns them into vector form [year month index]. Section
% at the end can be commented out if to not save to text file.

%thenames={'ENSO_Multi_M','AO','EPO','Nino1_2','Nino3','Nino4','Nino34','NinoBEST','NP','ONI','PDO_val','PNA'};

thenames={'PDO_data'};

for ii=1:length(thenames)
    
    filename=sprintf('%s.txt',thenames{ii});
    data=importdata(filename);
    data=data.data; %comment this out if there are no column headers.
    
    vals=mode(data(:));
    if vals==-99.90
        ind=find(data==vals);
        data(ind)=NaN;
    elseif vals==-999
        ind=find(data==vals);
        data(ind)=NaN;
    elseif vals==-99.99
        ind=find(data==vals);
        data(ind)=NaN;
    end
    
    months=1:12;
    
    years=data(:,1);
    years2=repmat(years,1,12);
    years3=reshape(years2',[],1);
    
     months=1:12;
     months2=repmat(months,1,length(years));
     months3=reshape(months2',[],1);
    
     months4=months3(1:length(years3));
     
    dataout=data(:,2:end);
    dataout=reshape(dataout',[],1);
    
    datavec=[years3 months4 dataout];
    datavec=datavec(205:end,:); % use this line to get rid early years if needed.
    IndexOut.(thenames{ii})=datavec;
    
    saveme=sprintf('%s_vec.txt',thenames{ii});
    savename=fopen(saveme,'w');
    fprintf(savename,'%d\t%d\t%-.3f\n',datavec');
    
end
    
    
    
    