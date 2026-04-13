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
B_I = diag([10 5 7.5]); % [kg-m^2]
OmegaLMO = deg2rad(20); % [deg] -> [rad]
iLMO = deg2rad(30); % [deg] -> [rad]
theta0LMO = deg2rad(60); % [deg] -> [rad]
OmegaGMO = 0; % [deg]/[rad]
iGMO = 0; % [deg]/[rad]
theta0GMO = deg2rad(250); % [deg] -> [rad]

%% Task 1: Orbit Simulation
[N_rLMO450,N_rdotLMO450] = GetInertialState(450,"LMO");
[N_rGMO1150,N_rdotGMO1150] = GetInertialState(1150,"GMO");

%% Task 2: Orbit Frame Orientation

HN_300 = HN_DCM(300,"LMO");

%% Task 3: Sun-Pointing Reference Frame Orientation

RsN = [-1 0 0;
        0 0 1;
        0 1 0];

%% Task 4: Nadir-Pointing Reference Frame Orientation

RnN_330 = RnN_DCM(330);
NwRnN_330 = NwRnN_vec(330);


%% Task 5: GMO-Pointing Reference Frame Orientation

RcN_330 = RcN_DCM(330);
NwRcN_330 = NwRcN_vec(330);

%% Task 6: Attitude Error Evaluation 

[mrpBRs,BwBRs] = attitude_error(0,mrpBN0,BwBN0,'sun');
[mrpBRn,BwBRn] = attitude_error(0,mrpBN0,BwBN0,'nadir');
[mrpBRc,BwBRc] = attitude_error(0,mrpBN0,BwBN0,'GMO');

%% Task 7: Numerical Attitude Simulator

%% Task 8: Sun Pointing Control

%% Task 9: Nadir Pointing Control

%% Task 10: GMO Pointing Control

%% Task 11: Mission Scenario Simulation