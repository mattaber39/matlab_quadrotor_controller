function [desired_state] = circle(t, qn)
% CIRCLE trajectory generator for a circle

% =================== Your code goes here ===================
% You have to set the pos, vel, acc, yaw and yawdot variables
% NOTE: the simulator will spawn the robot to be at the
%       position you return for t == 0

r = 30;

pos = [r*cos((2*pi/30)*t);r*sin((2*pi/30)*t);0.5*t];
vel = [-(2*pi/30)*r*sin((2*pi/30)*t);(2*pi/30)*r*cos((2*pi/30)*t);0.5];
acc = [-(2*pi/30)*(2*pi/30)*r*cos((2*pi/30)*t);-(2*pi/30)*(2*pi/30)*r*sin((2*pi/30)*t);0];
yaw = 0;
yawdot = 0;

% =================== Your code ends here ===================

desired_state.pos = pos(:);
desired_state.vel = vel(:);
desired_state.acc = acc(:);
desired_state.yaw = yaw;
desired_state.yawdot = yawdot;

end
