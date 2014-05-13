
% Fills in April Snow amounts to correlate April snow on the ground to
% total snowfall at paradise.


asdf=importdata('SnowMonth.txt');
ind=find(asdf(:,2)==4);

aprilsnow=asdf(:,3);
aprilsnow_vec=aprilsnow(ind);

yearvec=asdf(ind)
april_V=[yearvec aprilsnow_vec]

yst=april_V(1,1);
yen=april_V(end,1);

vals=april_V(:,2);
%yfull=yst:yen;
yfull=1921:2012;


for ii=1:length(yfull);
    
    ind=find(april_V(:,1)==yfull(ii));
    
    bit=isempty(ind);
    
    if bit==1;
        
    April_new_trunc(ii,1)=yfull(ii);
    April_new_trunc(ii,2)=NaN;
    
    elseif bit==0;
        
    April_new_trunc(ii,1)=yfull(ii);
    April_new_trunc(ii,2)=vals(ind);
    
    end
    
end

figure(234);plot(April_new_trunc(:,2),ss_mm,'k+')