burp=data(1,:);
trans=data(2:end,:);

for i=1:length(trans)
    
    nor=(trans(i,1)-burp(1))^2;
    eas=(trans(i,2)-burp(2))^2;
    
    pos(i)=sqrt(nor+eas);
    
end

pos=pos';

elevs=trans(:,3);

points=[pos elevs]
