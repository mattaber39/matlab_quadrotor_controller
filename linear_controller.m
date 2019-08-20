function [F, M, trpy, drpy] = linear_controller(qd, t, qn, params)
% CONTROLLER quadrotor controller
% The current states are:
%% Inputs:
%
% qd{qn}: state and desired state information for quadrotor #qn (qn
%         will be = 1 since we are only flying a single robot)
%
%  qd{qn}.pos, qd{qn}.vel   position and velocity
%  qd{qn}.euler = [roll;pitch;yaw]
%  qd{qn}.omega     angular velocity in body frame
% function [desired_state] = diamond(t, qn)
%  qd{qn}.pos_des, qd{qn}.vel_des, qd{qn}.acc_des  desired position, velocity, accel
%  qd{qn}.yaw_des, qd{qn}.yawdot_des
%
% t: current time
%    
% qn: quadrotor number, should always be 1
%    
% params: various parameters
%  params.I     moment of inertia
%  params.grav  gravitational constant g (9.8...m/s^2)
%  params.mass  mass of robot
%
%% Outputs:
%
% F: total thrust commanded (sum of forces from all rotors)
% M: total torque commanded
% trpy: thrust, roll, pitch, yaw (attitude you want to command!)
% drpy: time derivative of trpy
%
% Using these current and desired states, you have to compute the desired
% controls u, and from there F and M
%

% =================== Your code goes here ===================
% ...
% ==============================

%-------------------------------------------------------------------------
% Solving for u1 and u2
%-------------------------------------------------------------------------

kp = 8;  % Proportional control constant for attitude control
kd = 5;  % Derivative control constant for attitude control

kpa = 0.2;  % Proportional control constant for acceleration control
kda = 1;    % Derivative control constant for acceleration control

psi_des = qd{1}.yaw_des;

% Finding commanded acceleration using PD control (equation 21)
acc_com = qd{1}.acc_des - kda*(qd{1}.vel-qd{1}.vel_des) - kpa*(qd{1}.pos - qd{1}.pos_des);

% Solving for total force (equation 22c)
u1 = params.mass*(acc_com(3) + params.grav)/(cos(qd{1}.euler(1))*cos(qd{1}.euler(2)));

% Solving for desired attitude angles (equations 22a and 22b)
A = (u1/params.mass).*[cos(psi_des) sin(psi_des); sin(psi_des) -cos(psi_des)];
b = [acc_com(1); acc_com(2)];
solved = A\b;
theta_des = solved(1);
phi_des   = solved(2);

% Finding total moment vector using PD control (equation 25) 
PD_x = -kp*(qd{1}.euler(1) - phi_des) - kd*qd{1}.omega(1);
PD_y = -kp*(qd{1}.euler(2) - theta_des) - kd*qd{1}.omega(2);
PD_z = -kp*(qd{1}.euler(3) - psi_des) - kd*(qd{1}.omega(3) - qd{1}.yawdot_des);
u2 = params.I * [PD_x; PD_y; PD_z];

%--------------------------------------------------------------------------
% Backsolving for the force from each motor. Unnecessary in simulation, 
% necessary for a real drone. 
%--------------------------------------------------------------------------

l = 0.046;      % Distance from CoM to motor, found on page 9. 
km = 1.5e-9;    % Motor moment constant, found on page 3. 
kf = 6.11e-8;   % Motor force constant, found on page 2. 
gamma = km/kf;

% System of equations for motor forces. Combo of equation 16, 25, and 10. 
F_matrix = [0, l, 0, -l; -l, 0, l, 0; gamma, -gamma, gamma, -gamma; 1, 1, 1, 1];
u2_u1_combo = [u2(1); u2(2); u2(3); u1];
u = F_matrix\u2_u1_combo;   % 4x1 vector of solved motor forces. 

%--------------------------------------------------------------------------
% Resolving for F and M (for use in the simulation). 
%--------------------------------------------------------------------------

% Thrust
F    = sum(u);       % Also equal to u1. 

% Moment
M    = u2;     % 3x1 vector of moments. 

% =================== Your code ends here ===================

% Output trpy and drpy as in hardware
trpy = [F, phi_des, theta_des, psi_des];
drpy = [0, 0,       0,         0];

end
