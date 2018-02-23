%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% David Ryan Islip - 1000552797 Nov 17 2017
% AER501 Assignment#2 
% Dynamics & Finite Elements
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%problem data
EI = 1.286e4;
EA = 6.987e6;
rhoA = 2.74;
N_files = 4;

% Run the free vibration analysis to see the convergence in eigenvalues as
% the number of elements per truss member is increased
freevibration( EA, EI, rhoA, N_files );

ohm = 250; %define the frequency rnge

%Directly calulate the frequency response of the structure by for each mesh
u_meshrefined = directfrfanalysis(EA, EI, rhoA, N_files, ohm);
%Approximate the frequency response of the finest mesh and see how that
%approximation compares as the number of eigen modes used in the
%approximation is increased
u_eigens = modalfrfanalysis( EA, EI, rhoA, ohm, u_meshrefined);

