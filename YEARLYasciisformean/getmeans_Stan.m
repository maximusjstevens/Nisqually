% This script inputs the inidividual measurements for each
% transect and integrates to find the mean elevation

% 5/10/13: This edit interpolates to find the mean over the same
% standarized window for each profile, e.g. 225 - 630 m for profile A

clear all;close all;
k=1;

Astan=(225:630)';
Bstan=(300:870)';
Cstan=(90:615)';

years=[1991:1999 2001]';

for ii=1:length(years)
 ind=years(ii);
    
 FileA = sprintf('%dA.txt',ind);
 FileB = sprintf('%dB.txt',ind);
 FileC = sprintf('%dC.txt',ind);
 
 A=importdata(FileA);
 B=importdata(FileB);
 C=importdata(FileC);
 
 inElevA=interp1(A(:,1),A(:,2),Astan,'linear','extrap');
 inElevB=interp1(B(:,1),B(:,2),Bstan,'linear','extrap');
 inElevC=interp1(C(:,1),C(:,2),Cstan,'linear','extrap');
 
%  intA=trapz(A(:,1),A(:,2));
%  intB=trapz(B(:,1),B(:,2));
%  intC=trapz(C(:,1),C(:,2));
 
 intA=trapz(Astan,inElevA);
 intB=trapz(Bstan,inElevB);
 intC=trapz(Cstan,inElevC);
 
%  diviA=1/(A(end,1)-A(1,1));
%  diviB=1/(B(end,1)-B(1,1));
%  diviC=1/(C(end,1)-C(1,1));
 
 diviA=1/(Astan(end)-Astan(1));
 diviB=1/(Bstan(end)-Bstan(1));
 diviC=1/(Cstan(end)-Cstan(1));
 
 meanA=diviA*intA;
 meanB=diviB*intB;
 meanC=diviC*intC;
 
 outA(k,1)=ind;
 outA(k,2)=meanA;
 
 outB(k,1)=ind;
 outB(k,2)=meanB;
 
 outC(k,1)=ind;
 outC(k,2)=meanC;
 
 k=k+1;
end