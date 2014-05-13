%Max Stevens 6/11/13
% This script correlates the mass balance data with the weather obs and the
% climate indices.

thenames={'ENSO_Multi_M_vec','AO_vec','EPO_vec','Nino1_2_vec','Nino3_vec','Nino4_vec','Nino34_vec','NinoBEST_vec','NP_vec','ONI_vec','PDO_data_vec','PNA_vec'};

MassBalance=importdata('NisqMB_text.txt');
massbal=MassBalance.data;
massbal=massbal(2:end,1:5);


%thenames={'PDO_data'};

for ii=1:length(thenames)
    clear startind fullyear summerind winterind Ind_winter Ind_summer
    filename=sprintf('%s.txt',thenames{ii});
    data=importdata(filename);
    % data=data.data; %comment this out if there are no column headers.
    
    aba=strcmp(filename,'NinoBEST_vec.txt');
    abb=strcmp(filename,'NP_vec.txt');
    if aba==1 || abb==1
        MByears=massbal(1:end-1,1);
        MBnet=massbal(1:end-1,2);
        MBwin=massbal(1:end-1,3);
        MBsum=massbal(1:end-1,4);
        MBabl=massbal(1:end-1,5);
        
        MBnetC=MBnet-mean(MBnet);
        MBwinC=MBwin-mean(MBwin);
        MBsumC=MBsum-mean(MBsum);
        MBablC=MBabl-mean(MBabl);
        
    else
        MByears=massbal(:,1);
        MBnet=massbal(:,2);
        MBwin=massbal(:,3);
        MBsum=massbal(:,4);
        MBabl=massbal(:,5);
        
        MBnetC=MBnet-mean(MBnet);
        MBwinC=MBwin-mean(MBwin);
        MBsumC=MBsum-mean(MBsum);
        MBablC=MBabl-mean(MBabl);
    end
    
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
    %% Get just the mass balance years
    pyears=Para_winter(:,1);
    lastyear=min(Para_winter(end,1),Ind_winter(end,1));
    
    styr=MByears(1);
    enyr=MByears(end);
    
    ind1=find(pyears==styr);
    ind2=find(pyears==lastyear);
    
    years=pyears(ind1:ind2);
    
    Para_winter2=Para_winter(ind1:ind2,:);
    Para_summer2=Para_summer(ind1:ind2,:);
    
    ind3=find(Ind_winter==lastyear);
    ind4=find(Ind_winter==styr);
    Ind_winter=Ind_winter(ind4:ind3,:);
    Ind_summer=Ind_summer(ind4:ind3,:);
    
    %% End get the mb years
    
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
    
    
    [NetInd,NVAL]=corr(Ind_cor,MBnetC);
    [WinInd,WVAL]=corr(Ind_cor,MBwinC);
    [ELAInd,ELVAL]=corr(Ind_cor,MBablC);
    [SumInd,SVAL]=corr(Ind_corS,MBsumC);
    
    xNetInd=xcorr(Ind_cor,MBnetC,2,'coeff');
    xWinInd=xcorr(Ind_cor,MBwinC,2,'coeff');
    xELAInd=xcorr(Ind_cor,MBablC,2,'coeff');
    xSumInd=xcorr(Ind_corS,MBsumC,2,'coeff');
    
    corrsvec=[NetInd,NVAL;WinInd,WVAL;ELAInd,ELVAL;SumInd,SVAL];
    %xcorrsvec=[xNetInd;xWinInd;xELAInd;xSumInd];
    
    MB_Ind_Corr.(thenames{ii})=corrsvec;
    xMB_Ind_Corr.(thenames{ii}).net=xNetInd;
    xMB_Ind_Corr.(thenames{ii}).win=xWinInd;
    xMB_Ind_Corr.(thenames{ii}).ela=xELAInd;
    xMB_Ind_Corr.(thenames{ii}).sum=xSumInd;
end


%winter
[NetSN,NSVAL]=corr(psnow_cor,MBnetC);
[NetTP,NTVAL]=corr(ptemp_cor,MBnetC);

[WinSN,WSVAL]=corr(psnow_cor,MBwinC);
[WinTP,WTVAL]=corr(ptemp_cor,MBwinC);

[ElaSN,ESVAL]=corr(psnow_cor,MBablC);
[ElaTP,ETVAL]=corr(ptemp_cor,MBablC);

%Summer
[SumTPS,SSTVAL]=corr(ptempS_cor,MBsumC);
[NetTPS,NSTVAL]=corr(ptempS_cor,MBnetC);
[ElaTPS,ElaTSVAL]=corr(ptempS_cor,MBablC);

corrsvec2=[NetSN,NSVAL;NetTP,NTVAL;WinSN,WSVAL;WinTP,WTVAL;ElaSN,ESVAL;ElaTP,ETVAL;SumTPS,SSTVAL;NetTPS,NSTVAL;ElaTPS,ElaTSVAL];

MB_W.Corr=corrsvec2;




