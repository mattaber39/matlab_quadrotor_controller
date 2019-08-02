function [desired_state] = hipocycloid(t, qn)

% =================== Your code goes here ===================
% You have to set the pos, vel, acc, yaw and yawdot variables
% NOTE: the simulator will spawn the robot to be at the
%       position you return for t == 0

a = 5;
b = 3;

p = (2*pi/80);

posx = (a-b)*cos(p*t)  +  b*cos(p*((b-a)/b)*t);

velx = -p*(a-b)*sin(p*t)  -  p*((b-a)/b)*b*sin(p*((b-a)/b)*t);

accx = -p*p*(a-b)*cos((2*pi/80)*t)  -  p*p*((b-a)/b)*((b-a)/b)*b*cos(p*((b-a)/b)*t);



posy = (a-b)*sin(p*t)  +  b*sin(p*((b-a)/b)*t);

vely = p*(a-b)*cos(p*t)  +  p*((b-a)/b)*b*cos(p*((b-a)/b)*t);

accy = -p*p*(a-b)*sin(p*t)  -  p*p*((b-a)/b)*((b-a)/b)*b*sin(p*((b-a)/b)*t);

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
