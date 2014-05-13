% This script inputs the inidividual measurements for each
% transect and integrates to find the mean elevation

k=1;
for ii=1991:2012
 
 FileA = sprintf('%dA.txt',ii);
 FileB = sprintf('%dB.txt',ii);
 FileC = sprintf('%dC.txt',ii);
 
 A=importdata(FileA);
 B=importdata(FileB);
 C=importdata(FileC);
 
 intA=trapz(A(:,1),A(:,2));
 intB=trapz(B(:,1),B(:,2));
 intC=trapz(C(:,1),C(:,2));
 
 diviA=1/(A(end,1)-A(1,1));
 diviB=1/(B(end,1)-B(1,1));
 diviC=1/(C(end,1)-C(1,1));
 
 meanA=diviA*intA;
 meanB=diviB*intB;
 meanC=diviC*intC;
 
 outA(k,1)=ii;
 outA(k,2)=meanA;
 
 outB(k,1)=ii;
 outB(k,2)=meanB;
 
 outC(k,1)=ii;
 outC(k,2)=meanC;
 
 k=k+1;
end