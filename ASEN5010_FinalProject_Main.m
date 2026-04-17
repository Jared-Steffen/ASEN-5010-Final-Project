clc; clear; close all

%% ICs/Constants/Givens

% Constants and Givens
hLMO = 400; % [km]
RMars = 3396.19; % [km]
rLMO = RMars + hLMO;
rGMO = 20424.2; % [km]
thetadotLMO = 0.000884796; % [rad/s]
thetadotGMO = 0.0000709003; % [rad/s]
muMars = 42828.3; % [km^3/s^2]

% ICs
mrpBN0 = [0.3 -0.4 0.5]';
BwBN0 = deg2rad([1.00 1.75 -2.20]'); % [deg/s] -> [rad/s]
constants.I = diag([10 5 7.5]); % [kg-m^2]
OmegaLMO = deg2rad(20); % [deg] -> [rad]
iLMO = deg2rad(30); % [deg] -> [rad]
theta0LMO = deg2rad(60); % [deg] -> [rad]
OmegaGMO = 0; % [deg]/[rad]
iGMO = 0; % [deg]/[rad]
theta0GMO = deg2rad(250); % [deg] -> [rad]

% Calculated gains
constants.P = 1/6;
constants.K = 1/180;

%% Task 1: Orbit Simulation
[N_rLMO_t1,N_rdotLMO4_t1] = GetInertialPos(450,"LMO");
[N_rGMO_t1,N_rdotGMO_t1] = GetInertialPos(1150,"GMO");

%% Task 2: Orbit Frame Orientation

HN_t2 = HN_DCM(300,"LMO");

%% Task 3: Sun-Pointing Reference Frame Orientation

RsN = [-1 0 0;
        0 0 1;
        0 1 0];

%% Task 4: Nadir-Pointing Reference Frame Orientation

RnN_t4 = RnN_DCM(330);
NwRnN_t4 = NwRnN_vec(330);


%% Task 5: GMO-Pointing Reference Frame Orientation

RcN_t5 = RcN_DCM(330);
NwRcN_t5 = NwRcN_vec(330);

%% Task 6: Attitude Error Evaluation 

[mrpBRs_t6,BwBRs_t6,~,~] = attitude_error(0,mrpBN0,BwBN0,'sun');
[mrpBRn_t6,BwBRn_t6,~,~] = attitude_error(0,mrpBN0,BwBN0,'nadir');
[mrpBRc_t6,BwBRc_t6,~,~] = attitude_error(0,mrpBN0,BwBN0,'GMO');

%% Task 7: Numerical Attitude Simulator
% NOTE: control vector u was manually set within AttitudeMRP_RK4 for
% validation submissions

tspan = [0 500];
h = 1;
X0 = [mrpBN0;BwBN0]; 
[t_t7,X_t7,~,~,~,~,~,~] = AttitudeMRP_RK4(@AttitudeODE,tspan,X0,h,constants);
BwBN_t7 = X_t7(4:6,end);
mrpBN_t7 = X_t7(1:3,end);
BH_t7 = constants.I*BwBN_t7;
T_t7 = 0.5*BwBN_t7'*constants.I*BwBN_t7;
BN_t7 = MRPtoDCM(mrpBN_t7);
NH_t7 = BN_t7'*BH_t7;

% plot_test_attitude_sim(t_t7,X_t7)

%% Task 8/9/10: Sun/Nadir/GMO Pointing Control
% NOTE: control pointing mode was manually set within AttitudeMRP_RK4 for
% validation submissions

tspan = [0 1000];
[t_t8_9_10,X_t8_9_10,u_t8_9_10,~,mrpRN_t8_9_10,BwRN_t8_9_10,mrpBR_t8_9_10,BwBR_t8_9_10]...
    = AttitudeMRP_RK4(@AttitudeODE,tspan,X0,h,constants);
mrp15_t8_9_10 = X_t8_9_10(1:3,16);
mrp100_t8_9_10 = X_t8_9_10(1:3,101);
mrp200_t8_9_10 = X_t8_9_10(1:3,201);
mrp400_t8_9_10 = X_t8_9_10(1:3,401);
Xr_t8_9_10 = [mrpRN_t8_9_10;BwRN_t8_9_10];
Xe_t8_9_10 = [mrpBR_t8_9_10;BwBR_t8_9_10];

% plot_test_control(t_t8_9_10,X_t8_9_10,Xr_t8_9_10,u_t8_9_10)
% plot_state_error(t_t8_9_10,Xe_t8_9_10)

%% Task 11: Mission Scenario Simulation

tspan = [0 6500];
[t_t11,X_t11,u_t11,pointing_mode,mrpRN_t11,BwRN_t11,mrpBR_t11,BwBR_t11]...
    = AttitudeMRP_RK4(@AttitudeODE,tspan,X0,h,constants);
mrp300_t11 = X_t11(1:3,301);
mrp2100_t11 = X_t11(1:3,2101);
mrp3400_t11 = X_t11(1:3,3401);
mrp4400_t11 = X_t11(1:3,4401);
mrp5600_t11 = X_t11(1:3,5601);

switch_idx = find(pointing_mode(2:end) ~= pointing_mode(1:end-1)) + 1;
switch_modes = {"Sun to Nadir","Nadir to GMO","GMO to Nadir","Nadir to Sun"};
Xr_t11 = [mrpRN_t11;BwRN_t11];
Xe_t11 = [mrpBR_t11;BwBR_t11];

plot_attitude_sim(t_t11,X_t11,Xr_t11,Xe_t11,u_t11,switch_idx,switch_modes,constants)

for i = 1:length(t_t11)
    [N_rLMO_t11,~] = GetInertialPos(t_t11(i),"LMO");
    [N_rGMO_t111,~] = GetInertialPos(t_t11(i),"GMO");
    beta_t11(i) = acos(dot(N_rLMO_t11,N_rGMO_t111)/(norm(N_rLMO_t11)*norm(N_rGMO_t111)));
    alpha_t11(i) = acos(dot(N_rLMO_t11,[0 1 0])/norm(N_rLMO_t11));
end

figure();
subplot(2,1,1)
plot(t_t11,rad2deg(alpha_t11))
hold on
yline(90, ':w','90 degrees', 'LineWidth', 1.5,'FontSize', 14);
xline(switch_idx(1), ':w',"Sun to Nadir", 'LineWidth', 1.5, 'LabelOrientation', 'horizontal','FontSize', 14);
xline(switch_idx(4), ':w',"Nadir to Sun", 'LineWidth', 1.5, 'LabelOrientation', 'horizontal','FontSize', 14);
ylabel('\alpha [deg]')
xlabel('Time [s]')
title('Angle Between LMO Spacecraft Position Vector and Sun Direction Unit Vector')
subplot(2,1,2)
plot(t_t11,rad2deg(beta_t11))
hold on
yline(35, ':w','35 degrees', 'LineWidth', 1.5,'FontSize', 14);
xline(switch_idx(2), ':w',"Nadir to GMO", 'LineWidth', 1.5, 'LabelOrientation', 'horizontal','FontSize', 14);
xline(switch_idx(3), ':w',"GMO to Nadir", 'LineWidth', 1.5, 'LabelOrientation', 'horizontal','FontSize', 14);
ylabel('\beta [deg]')
xlabel('Time [s]')
title('Angle Between LMO and GMO Spacecraft Position Vectors')