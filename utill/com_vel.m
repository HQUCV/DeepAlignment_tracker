function vel=com_vel(obj,tra)

%     A = obj(1:2)+obj(3:4)/2;
%     B = tra(1:2)+tra(3:4)/2;
if size(tra,1)>=6
    vel = (obj(1:2)-tra(size(tra,1)-5,2:3))/5;
else
    vel = (obj(1:2)-tra(1,2:3))/size(tra,1);
end

end