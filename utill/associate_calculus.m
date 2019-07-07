function [ kfstate, tracklets, assignment, active ] = associate_calculus( idx_active, dist, kfstate, tracklets, object, obj_feat, active, i)
    
    for j = 1:length(idx_active)
      % index of this tracklet
      track_idx = idx_active(j);
      % predict state
      kfstate{track_idx} = kfpredict(kfstate{track_idx});
      dist(j,:) = trackletLocation(object(:,1:4),obj_feat,tracklets{track_idx});
    end
   % gating + hungarian assignment
   dist(dist<0) = 0;
   dist(dist>0.8) = inf;
   for l=1:length(dist(1,:))
      inf_ind    = isinf(dist(:,l));  
      inf_r  = find(inf_ind~=1);
      if length(inf_r) == 1
          tracklets{inf_r}.feat = obj_feat(:,l);
      end
   end
   dist(dist>0.5) = inf;
   assignment = assignmentoptimal(dist);
    % extend active tracklets
    for j=1:length(idx_active)
        % index of this tracklet
        track_idx = idx_active(j);
        % assigned object detection index
        obj_idx = assignment(j);
        % if a detection has been assigned => update state
        if obj_idx > 0
            kfstate{track_idx}.z = object(obj_idx,1:4)';
            kfstate{track_idx}   = kfcorrect(kfstate{track_idx});
            if tracklets{track_idx}.oc ~= 0
                [tracklets{track_idx}, object] = update_state(tracklets{track_idx}, object, obj_idx, kfstate{track_idx}, i);
                tracklets{track_idx}.oc = 0;
                tracklets{track_idx}.co = tracklets{track_idx}.co + 1;
            else
                [tracklets{track_idx}, object] = update_state(tracklets{track_idx}, object, obj_idx, kfstate{track_idx}, i);
                tracklets{track_idx}.co = tracklets{track_idx}.co + 1;
            end
        % if no detection has been assigned => deactivate
        else
            if tracklets{track_idx}.co >= 2 && tracklets{track_idx}.oc <= 15
                tracklets{track_idx}.oc = tracklets{track_idx}.oc + 1;
                prestate = motion_pre(tracklets{track_idx}.track(end,:),tracklets{track_idx}.vel);
                kfstate{track_idx}.z = prestate';
                kfstate{track_idx}   = kfcorrect(kfstate{track_idx});
                tracklets{track_idx}.track = [tracklets{track_idx}.track; i kfstate{track_idx}.x(1:4)' tracklets{track_idx}.track(end,6:end)];
            else
                active(track_idx) = 0;
            end
        end
     end

end

