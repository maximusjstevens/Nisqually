% vars=min(size(climate));
% 
% for ii=1:vars
%     
%     ind=find(climate(:,ii)~=-9999);
%     
%     hold(ii)=numel(ind);
%     
% end

% ind=find(climate==-9999);
% climate(ind)=NaN;

fid=fopen('paradiseclimate3.txt','w');
%x = repmat('%d\t',1,(cols-1));
A=climate;
%for jj=1:length(A);
fprintf(fid,'%8d %8.0f %8.0f %8.0f %8.1f %8.1f %8.1f\n',A');