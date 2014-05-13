%this script finds monthly values of the data, e.g. average high, maximum
%snow depth, etc.

ye=min(fullClim(:,1)):max(fullClim(:,1));
mo=1:12;
iter=1;
for ii=1:length(ye)
    for jj=1:length(mo)
        
        YOI=ye(ii);
        MOI=mo(jj);
        
        ind=find(fullClim(:,1)==YOI & fullClim(:,2)==MOI);
        
        
        monthsnow=nansum(fullClim(ind,5)); %mm
        TF = isempty(monthsnow);
        if TF==1
            monthsnow=NaN;
        end
        monthprecip=nansum(fullClim(ind,4)); %mm
        TF = isempty(monthprecip);
        if TF==1
            monthprecip=NaN;
        end
        maxsnowdepth=nanmax(fullClim(ind,6)); %mm
        TF = isempty(maxsnowdepth);
        if TF==1
            maxsnowdepth=NaN;
        end
        avghighT=nanmean(fullClim(ind,7));
        TF = isempty(avghighT);
        if TF==1
            avghighT=NaN;
        end
        maxhighT=nanmax(fullClim(ind,7));
        TF = isempty(maxhighT);
        if TF==1
            maxhighT=NaN;
        end
        avglowT=nanmean(fullClim(ind,8));
        TF = isempty(avglowT);
        if TF==1
            avglowT=NaN;
        end
        minlowT=nanmin(fullClim(ind,8));
        TF = isempty(minlowT);
        if TF==1
            minlowT=NaN;
        end
        avgmonT=nanmean(fullClim(ind,9));
        TF = isempty(avgmonT);
        if TF==1
            avgmonT=NaN;
        end
        
        monClim_m(iter,:)=[YOI MOI monthprecip/1000 monthsnow/1000 maxsnowdepth/1000 avghighT maxhighT avglowT minlowT avgmonT];
        iter=iter+1;
        snowStack(ii,jj)=monthsnow/1000;
    end
end