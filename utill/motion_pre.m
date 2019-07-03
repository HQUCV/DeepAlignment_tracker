function state = motion_pre( track,v)

A = track(2:3)+v;
state = [A track(4:5)];

end