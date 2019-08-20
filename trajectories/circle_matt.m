function [desired_state] = circle(t, qn)
% CIRCLE trajectory generator for a circle

% =================== Your code goes here ===================
% You have to set the pos, vel, acc, yaw and yawdot variables
% NOTE: the simulator will spawn the robot to be at the
%       position you return for t == 0

pause = 0;
R = 5;
rt = 50;
omega_real = 2*pi/rt;
omega = omega_real;

c = 0.1;
% 
% if t > 35+pause
%     R = 3;
% end

pos = [R*cos(omega*(t-pause)); R*sin(omega*(t-pause)); c*(t-pause)];
vel = [-R*omega*sin(omega*(t-pause)); R*omega*cos(omega*(t-pause)); c];
acc = [-R*omega^2*cos(omega*(t-pause)); -R*omega^2*sin(omega*(t-pause)); 0];
yaw = 0; %atan2(pos(2), pos(1));
yawdot = 0; %omega;

% if t > 15+pause
%     pos(3) = c*t + 5;
% end

if t < pause
    pos = [R;0;0];
    vel = [0;0;0];
    acc = [0;0;0];
end

% =================== Your code ends here ===================

desired_state.pos = pos(:);
desired_state.vel = vel(:);
desired_state.acc = acc(:);
desired_state.yaw = yaw;
desired_state.yawdot = yawdot;

end
