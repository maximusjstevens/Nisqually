%Max Stevens 6/11/13
% This script loads all of the climate indices that I am interested in
% (right now) and splits them into seasonal parts. Section
% at the end can be commented out if to not save to text file.

thenames={'ENSO_Multi_M_vec','AO_vec','EPO_vec','Nino1_2_vec','Nino3_vec','Nino4_vec','Nino34_vec','NinoBEST_vec','NP_vec','ONI_vec','PDO_data_vec','PNA_vec'};

%thenames={'PDO_data'};

for ii=1:length(thenames)
    clear startind fullyear summerind winterind Ind_winter Ind_summer
    filename=sprintf('%s.txt',thenames{ii});
    data=importdata(filename);
    % data=data.data; %comment this out if there are no column headers.
    
    years=data(:,1);
    styr=years(1);
    enyr=years(end);
    months=1:12;
    
    ind=min(find(data(:,2)==5));
    ind2=max(find(data(:,2)==4));
    data=data(ind:ind2,:);
    len=length(data(:,1));
    seas=1:12:len;
   
    for jj=1:length(seas)
        
        startind=seas(jj);
        
        fullyear=data(startind:startind+11,:);
        summerind=fullyear(1:6,:);
        winterind=fullyear(7:12,:);
        
        Ind_winter(jj,:)=[winterind(end,1) mean(winterind(:,3))]; 
        Ind_summer(jj,:)=[summerind(end,1) mean(summerind(:,3))];
        
    end
    
    Summer.(thenames{ii})=Ind_summer;
    Winter.(thenames{ii})=Ind_winter;
    
    saveme=sprintf('%s_summer.txt',thenames{ii});
    savename=fopen(saveme,'w');
    fprintf(savename,'%d\t%-.3f\n',Ind_summer');
    
    saveme=sprintf('%s_winter.txt',thenames{ii});
    savename=fopen(saveme,'w');
    fprintf(savename,'%d\t%-.3f\n',Ind_winter');
end



