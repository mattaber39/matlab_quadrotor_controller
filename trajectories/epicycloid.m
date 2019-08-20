function [desired_state] = epicycloid(t, qn)

% =================== Your code goes here ===================
% You have to set the pos, vel, acc, yaw and yawdot variables
% NOTE: the simulator will spawn the robot to be at the
%       position you return for t == 0

% Circle radii (this circles won't show up in the simulation.
a = 5;
b = 3;

% Period of time
p = (2*pi/80);

posx = (a+b)*cos(p*t)  -  b*cos(p*((a+b)/b)*t);

velx = -p*(a+b)*sin(p*t)  +  p*((a+b)/b)*b*sin(p*((a+b)/b)*t);

accx = -p*p*(a+b)*cos(p*t)  +  p*p*((a+b)/b)*((a+b)/b)*b*cos(p*((a+b)/b)*t);



posy = (a+b)*sin(p*t)  -  b*sin(p*((a+b)/b)*t);

vely = p*(a+b)*cos(p*t)  -  p*((a+b)/b)*b*cos(p*((a+b)/b)*t);

accy = p*p*(a+b)*sin(p*t)  +  p*p*((a+b)/b)*((a+b)/b)*b*sin(p*((a+b)/b)*t);

pos = [posx;posy; (1/16)*t];
vel = [velx;vely;(1/16)];
acc = [accx;accy;0];
yaw = 0;
yawdot = 0;

% =================== Your code ends here ===================

desired_state.pos = pos(:);
desired_state.vel = vel(:);
desired_state.acc = acc(:);
desired_state.yaw = yaw;
desired_state.yawdot = yawdot;

end
