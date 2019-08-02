function [desired_state] = circle(t, qn)
% CIRCLE trajectory generator for a circle

% =================== Your code goes here ===================
% You have to set the pos, vel, acc, yaw and yawdot variables
% NOTE: the simulator will spawn the robot to be at the
%       position you return for t == 0

r = 30;

p = (2*pi/30);

pos = [r*cos(p*t);r*sin(p*t);0.5*t];

vel = [-p*r*sin(p*t);p*r*cos(p*t);0.5];

acc = [-p*p*r*cos(p*t);-p*p*r*sin(p*t);0];

yaw = 0;
yawdot = 0;

% =================== Your code ends here ===================

desired_state.pos = pos(:);
desired_state.vel = vel(:);
desired_state.acc = acc(:);
desired_state.yaw = yaw;
desired_state.yawdot = yawdot;

end
