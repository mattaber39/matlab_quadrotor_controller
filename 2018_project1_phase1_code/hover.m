function [desired_state] = hover(t, qn)
% HOVER creates hover

% =================== Your code goes here ===================
% You have to set the pos, vel, acc, yaw and yawdot variables
%    
% NOTE: the simulator will spawn the robot to be at the
%       position you return for t == 0

h = 1;  % End height of hover.
rt = 3; % Run time; how long it takes to get to hover.
omega = pi/rt;

pos = [0; 0; h];
vel = [0; 0; 0];
acc = [0; 0; 0];
yaw = 0;
yawdot = 0;

if t < rt
    pos(3) = -h * cos(omega*t);
    vel(3) = h*omega * sin(omega*t);
    acc(3) = h*omega^2 * cos(omega*t);
end

% =================== Your code ends here ===================

desired_state.pos = pos(:);
desired_state.vel = vel(:);
desired_state.acc = acc(:);
desired_state.yaw = yaw;
desired_state.yawdot = yawdot;

end
