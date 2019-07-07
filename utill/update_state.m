function [tracklets, objects] = update_state(tracklets, objects, obj_idx, kfstate, i)
    tw = (objects(obj_idx,3)-tracklets.track(end,4))/min(objects(obj_idx,3),tracklets.track(end,4));
    th = (objects(obj_idx,4)-tracklets.track(end,5))/min(objects(obj_idx,4),tracklets.track(end,5));
    if tw < 0.2 && th < 0.2
        tracklets.vel = com_vel(objects(obj_idx,1:2),tracklets.track);
        tracklets.track = [tracklets.track; i kfstate.x(1:4)' objects(obj_idx,5:end)];
    else 
        tracklets.vel = com_vel(objects(obj_idx,1:2),tracklets.track);
        tracklets.track = [tracklets.track; i kfstate.x(1:4)' objects(obj_idx,5:end)];
    end