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
    
%     Summer.(thenames{ii})=Ind_summer;
%     Winter.(thenames{ii})=Ind_winter;
    
    aa=length(Ind_winter);
    bb=length(Para_winter);
    
    pyears=Para_winter(:,1);
    lastyear=min(Para_winter(end,1),Ind_winter(end,1));
    if bb>aa
        
        styr=Ind_winter(1,1);
        enyr=Ind_winter(end,1);
        ind1=find(pyears==styr);
        ind2=find(pyears==lastyear);
        
        years=pyears(ind1:ind2);
        Para_winter2=Para_winter(ind1:ind2,:);
        Para_summer2=Para_summer(ind1:ind2,:);
        
        ind3=find(Ind_winter==lastyear);
        Ind_winter=Ind_winter(1:ind3,:);
        Ind_summer=Ind_summer(1:ind3,:);
        
    elseif bb<aa
        
        styr=pyears(1,1);
        enyr=pyears(end,1);
        ind1=find(pyears==styr);
        ind2=find(pyears==lastyear);
        
        years=pyears(ind1:ind2);
%         Psnow=psnow(ind1:ind2);
        
        ind3=find(Ind_winter==lastyear);
        ind4=find(Ind_winter==styr);
        Ind_winter=Ind_winter(ind4:ind3,:);
        Ind_summer=Ind_summer(ind4:ind3,:);
        
    end
    
    
    psmax=Para_winter2(:,2);
    psnow=Para_winter2(:,3);
    ppcp=Para_winter2(:,4);
    ptemp=Para_winter2(:,5);
    ptempS=Para_summer2(:,5);
    
    psmax_cor=(psmax-nanmean(psmax));
    psmax_cor(isnan(psmax_cor))=0;
    
    psnow_cor=(psnow-nanmean(psnow));
    psnow_cor(isnan(psnow_cor))=0;
    
    ppcp_cor=(ppcp-nanmean(ppcp));
    ppcp_cor(isnan(ppcp_cor))=0;
    
    ptemp_cor=(ptemp-nanmean(ptemp));
    ptemp_cor(isnan(ptemp_cor))=0;
    
    ptempS_cor=(ptempS-nanmean(ptempS));
    ptempS_cor(isnan(ptempS_cor))=0;
    
    Ind_cor=(Ind_winter(:,2)-nanmean(Ind_winter(:,2)));
    Ind_cor(isnan(Ind_cor))=0;
    Ind_corS=(Ind_summer(:,2)-nanmean(Ind_summer(:,2)));
    Ind_corS(isnan(Ind_corS))=0;
    
    
    [MRHO,MPVAL]=corr(Ind_cor,psmax_cor);
    [SRHO,SPVAL]=corr(Ind_cor,psnow_cor);
    [PRHO,PPVAL]=corr(Ind_cor,ppcp_cor);
    [TRHO,TPVAL]=corr(Ind_cor,ptemp_cor);
    [TSRHO,TSPVAL]=corr(Ind_corS,ptempS_cor);
    
    corrsvec=[MRHO MPVAL;SRHO SPVAL;PRHO PPVAL;TRHO TPVAL;TSRHO TSPVAL];
    
    Corr.(thenames{ii})=corrsvec;
    
    
    
end



