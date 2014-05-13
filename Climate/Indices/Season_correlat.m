%Correlate seasonal values

aa=length(Ind_winter);
bb=length(Para_winter);

psnow=Para_winter(:,4);
pyears=Para_winter(:,1);

if bb>aa

styr=Ind_winter(1,1);
enyr=Ind_winter(end,1);
ind1=find(pyears==styr);
ind2=find(pyears==2012);

years=pyears(ind1:ind2);
Psnow=psnow(ind1:ind2);

ind3=find(Ind_winter==2012);
Ind_winter=Ind_winter(1:ind3,:);

elseif bb<aa
    
styr=pyears(1,1);
enyr=pyears(end,1);
ind1=find(pyears==styr);
ind2=find(pyears==2012);

years=pyears(ind1:ind2);
Psnow=psnow(ind1:ind2);

ind3=find(Ind_winter==2012);
ind4=find(Ind_winter==styr);
Ind_winter=Ind_winter(ind4:ind3,:);

end

Psnow_cor=(Psnow-nanmean(Psnow));
Psnow_cor(isnan(Psnow_cor))=0;
Ind_cor=(Ind_winter(:,2)-nanmean(Ind_winter(:,2)));

[RHO,PVAL]=corr(Ind_cor,Psnow_cor);


