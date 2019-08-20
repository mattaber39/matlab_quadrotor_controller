function [desired_state] = diamond_daniel(t, qn)
% DIAMOND trajectory generator for a diamond

% =================== Your code goes here ===================
% You have to set the pos, vel, acc, yaw and yawdot variables
% NOTE: the simulator will spawn the robot to be at the
%       position you return for t == 0

x = (1/80)*t;
velx = 1/80;

if 0 < t && t <= 20
    
    y = sqrt(2)*0.05*t;
    z = sqrt(2)*0.05*t;
    
    vely = sqrt(2)*0.05;
    velz = sqrt(2)*0.05;
    
elseif 20 < t && t <=40
    
    y = sqrt(2) -sqrt(2)*0.05*(t-20);
    z = sqrt(2) + sqrt(2)*0.05*(t-20);
    
    vely = -sqrt(2)*0.05;
    velz = sqrt(2)*0.05;
    
elseif 40 < t && t <= 60
   
    y = -sqrt(2)*0.05*(t-40);
    z = 2*sqrt(2) - sqrt(2)*0.05*(t-40);
    
    vely = -sqrt(2)*0.05;
    velz = -sqrt(2)*0.05;
    
elseif 60 < t && t <= 80
    
    y = -sqrt(2) + sqrt(2)*0.05*(t-60);
    z = sqrt(2) - sqrt(2)*0.05*(t-60);
    
    vely = sqrt(2)*0.05;
    velz = -sqrt(2)*0.05;
    
else
    
    y = 0;
    z = 0;
    
    vely = 0;
    velz = 0;
    
end

pos = [x;y;z];
vel = [velx;vely;velz];
acc = [0; 0; 0];
yaw = 0;
yawdot = 0;

% =================== Your code ends here ===================

desired_state.pos = pos(:);
desired_state.vel = vel(:);
desired_state.acc = acc(:);
desired_state.yaw = yaw;
desired_state.yawdot = yawdot;

end
