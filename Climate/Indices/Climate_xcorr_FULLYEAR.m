% calculate correlations with paradise weather and climate indices
clear all;

Paradise=importdata('ParadiseMonth_filled.txt');
Paradise=Paradise.data;

Parayears=Paradise(:,1);
Pmos=Paradise(:,2);
Pmxsd=Paradise(:,3);
Ptsnw=Paradise(:,4);
Ptpcp=Paradise(:,5);
Pmntm=Paradise(:,6);

AO=importdata('AO_vec.txt');
AOdata=AO(:,3);

thenames={'ENSO_Multi_M','AO','EPO','Nino1_2','Nino3','Nino4','Nino34','NinoBEST','NP','ONI','PDO_data','PNA'};

lagmonths=48;
%method='unbiased';
method='biased';
%method='coeff';
%method='none';


for ii=1:length(thenames)
    
    filename=sprintf('%s_vec.txt',thenames{ii});
    Indata=importdata(filename);
    
    IndexOut.(thenames{ii})=Indata;
    
    Indata_d=Indata(:,3);
    
    startyear=Indata(1,1);
    endyear=Indata(end,1);
    
    indS=find(Parayears==startyear,1,'first');
    indE=find(Parayears==endyear,1,'last');
    
    P_use=Paradise(indS:indE,:);
    
    Pyears=P_use(:,1);
    Pmos=P_use(:,2);
    Pmxsd=P_use(:,3);
    Ptsnw=P_use(:,4);
    Ptpcp=P_use(:,5);
    Pmntm=P_use(:,6);
    
    IN_scaled = (Indata_d - nanmean(Indata_d)) / nanstd(Indata_d);
    IN_scaled(isnan(Indata_d)) = 0;
    
    MXSD_scaled = (Pmxsd - nanmean(Pmxsd)) / nanstd(Pmxsd);
    MXSD_scaled(isnan(Pmxsd)) = 0;
    
    TSNW_scaled = (Ptsnw - nanmean(Ptsnw)) / nanstd(Ptsnw);
    TSNW_scaled(isnan(Ptsnw)) = 0;
    
    TPCP_scaled = (Ptpcp - nanmean(Ptpcp)) / nanstd(Ptpcp);
    TPCP_scaled(isnan(Ptpcp)) = 0;
    
    MNTM_scaled = (Pmntm - nanmean(Pmntm)) / nanstd(Pmntm);
    MNTM_scaled(isnan(Pmntm)) = 0;
    
    ind1=find(~isnan(Indata(:,3)));
    ind2=find(~isnan(Pmxsd));
    ind3=find(~isnan(Ptsnw));
    ind4=find(~isnan(Ptpcp));
    ind5=find(~isnan(Pmntm));
    
    U1=intersect(ind1,ind2);
    U2=intersect(ind1,ind3);
    U3=intersect(ind1,ind4);
    U4=intersect(ind1,ind5);
    
   MXSD.(thenames{ii})=xcorr(IN_scaled,MXSD_scaled,lagmonths,method);
   TSNW.(thenames{ii})=xcorr(IN_scaled,TSNW_scaled,lagmonths,method);
   TPCP.(thenames{ii})=xcorr(IN_scaled,TPCP_scaled,lagmonths,method);
   MNTM.(thenames{ii})=xcorr(IN_scaled,MNTM_scaled,lagmonths,method);
   
%    MXSD.(thenames{ii})=xcorr(Indata_d(U1),Pmxsd(U1),method);
%    TSNW.(thenames{ii})=xcorr(Indata_d(U2),Ptsnw(U2));
%    TPCP.(thenames{ii})=xcorr(Indata_d(U3),Ptpcp(U3),method);
%    MNTM.(thenames{ii})=xcorr(Indata_d(U4),Pmntm(U4),method);
    
%    MAX_MXSD.(thenames{ii})=max(MXSD.(thenames{ii}));
%    MAX_TSNW.(thenames{ii})=max(TSNW.(thenames{ii}));
%    MAX_TPCP.(thenames{ii})=max(TPCP.(thenames{ii}));
%    MAX_MNTM.(thenames{ii})=max(MNTM.(thenames{ii})); 
   
      [MAX_MXSD.(thenames{ii}).max  MAX_MXSD.(thenames{ii}).IND]=max(MXSD.(thenames{ii}));
   [MAX_TSNW.(thenames{ii}).max  MAX_TSNW.(thenames{ii}).IND]=max(TSNW.(thenames{ii}));
   [MAX_TPCP.(thenames{ii}).max  MAX_TPCP.(thenames{ii}).IND]=max(TPCP.(thenames{ii}));
   [MAX_MNTM.(thenames{ii}).max  MAX_MNTM.(thenames{ii}).IND]=max(MNTM.(thenames{ii})); 
   
   
end






