function [F, M, trpy, drpy] = geometric_controller(qd, t, qn, params)
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
% 
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

% Finding commanded acceleration using PD control (equation 26)
acc_com = qd{1}.acc_des - kda*(qd{1}.vel-qd{1}.vel_des) - kpa*(qd{1}.pos - qd{1}.pos_des);

% Finding commanded force using equation 28. 
F_com = params.mass*(acc_com + [0; 0; params.grav]);

% Finding basis vectors for body coordinates. 
angles = [qd{1}.euler(1); qd{1}.euler(2); qd{1}.euler(3)];
R = eulzxy2rotmat(angles);
b1 = R(1:3, 1);
b2 = R(1:3, 2);
b3 = R(1:3, 3);

% Solving for total force (equation 29).
u1 = dot(b3, F_com);

% Solving for desired R (equation 31, 30, 32, 33). 
a_psi = [cos(psi_des); sin(psi_des); 0];
b3_des = F_com/norm(F_com);
b2_des = cross(b3_des, a_psi)/norm(cross(b3_des, a_psi));
b1_des = cross(b2_des, b3_des);
R_des = [b1_des b2_des b3_des];

% Finding desired angles. Necessary only when using the Crazyflie's
% built-in attitude controller. 
angles_des = rotmat2eulzxy(R_des);
phi_des = angles_des(1);
theta_des = angles_des(2);

% Finding error between R_des and R using a vee map (equation 34). Note
% that there is a premade function for a vee map in the original code, but
% it was one line so I didn't use it.
eR_raw = (transpose(R_des)*R - transpose(R)*R_des);
eR = 0.5*[eR_raw(3,2); eR_raw(1,3); eR_raw(2,1)];

% Finding moment vector (equation 25). 
u2 = params.I*(-kp*eR - kd*qd{1}.omega);

%-------------------------------------------------------------------------
% Backsolving for the force from each motor. Unnecessary in simulation, 
% necessary for a real drone. 
%-------------------------------------------------------------------------

l = 0.046;      % Distance from CoM to motor, found on page 9. 
km = 1.5e-9;    % Motor moment constant, found on page 3. 
kf = 6.11e-8;   % Motor force constant, found on page 2. 
gamma = km/kf;

% System of equations for motor forces. Combo of equation 16, 25, and 10. 
F_matrix = [0, l, 0, -l; -l, 0, l, 0; gamma, -gamma, gamma, -gamma; 1, 1, 1, 1];
u2_u1_combo = [u2(1); u2(2); u2(3); u1];
u = F_matrix\u2_u1_combo;   % 4x1 vector of solved motor forces. 

%-------------------------------------------------------------------------
% Resolving for F and M (for use in the simulation). 
%-------------------------------------------------------------------------

% Thrust
F    = sum(u);       % Also equal to u1. 

% Moment
M    = u2;     % 3x1 vector of moments. 

% =================== Your code ends here ===================

% Output trpy and drpy as in hardware
trpy = [F, phi_des, theta_des, psi_des];
drpy = [0, 0,       0,         0];

end

%
% ------------------------------------------------------------
%    should you decide to write a geometric controller,
%    the following functions should come in handy
%

function m = eulzxy2rotmat(ang)
    phi   = ang(1);
    theta = ang(2);
    psi   = ang(3);
    
    m = [[cos(psi)*cos(theta) - sin(phi)*sin(psi)*sin(theta), -cos(phi)*sin(psi), ...
          cos(psi)*sin(theta) + cos(theta)*sin(phi)*sin(psi)];
         [cos(theta)*sin(psi) + cos(psi)*sin(phi)*sin(theta),  cos(phi)*cos(psi), ...
          sin(psi)*sin(theta) - cos(psi)*cos(theta)*sin(phi)];
         [-cos(phi)*sin(theta), sin(phi), cos(phi)*cos(theta)]];
end

function eul = rotmat2eulzxy(R)
    if R(3,2) < 1
        if R(3,2) > -1
            thetaX = asin(R(3,2));
            thetaZ = atan2(-R(1,2), R(2,2));
            thetaY = atan2(-R(3,1), R(3,3));
        else % R(3,2) == -1
            thetaX = -pi/2;
            thetaZ = -atan2(R(1,3),R(1,1));
            thetaY = 0;
        end
    else % R(3,2) == +1
        thetaX = pi/2;
        thetaZ = atan2(R(1,3),R(1,1));
        thetaY = 0;
    end
    eul = [thetaX, thetaY, thetaZ];
end
