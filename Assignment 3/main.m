%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   David Islip Assignment 3 
%   AER501 
%   Optimization
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
%% bump function optimization 
run plotbump.m %plot the negative of the objective function on the domain

x0  = [3; 3];
xl = [0; 0];
xu = [10; 10];
epsilon = 0.4;
maxiter = 5000;
Tstart = 1000;
c = 0.99;

[ best, x_best, x, d ] = SA(x0, xu, xl, epsilon, maxiter, Tstart, c, @bump);
run plotSA_bump
fprintf('min of bump function at x = ')
x_best
fprintf('with objective function value = ')
best(maxiter)

statistical_test = 0; 
M = 5; %number of iterations
c = [0.8 0.99 0.999];
run c_statistical_test.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Truss optimization
A0 = (10^-4)*[1 1 1 1 1 1 1 1 1 1]';
Al = 10^-8*[1 1 1 1 1 1 1 1 1 1]';
Au = 2*10^-4*[1 1 1 1 1 1 1 1 1 1]';
c = 0.99;

%if uad is one then use a quadratic penalty 
global quad  rho
quad = 1;
rho = 10000;

[best, x_best, x, d ] = SA(A0, Au, Al, epsilon, maxiter, Tstart, c, @trussweight);

[finalweight, isvalid] = trussweight(x_best');
fprintf('min of truss weight at A = ')
x_best
fprintf('with weight (kg) = ')
best(maxiter)
run plotSA_truss
plot_truss(x_best);

%% Convergence of the direct penalty approach and quadratic penalty approach
statistical_test = 0; 
M = 5;
P = [1 100 10000 1000000];
run p_statistical_test.m 
%%
if statistical_test == 0
load q3final.mat %load results for a statsical test done with 100 samples 
end
%objective functions
run plothistograms.m