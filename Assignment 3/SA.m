function [ best, x_best, x, path ] = SA(x0, xu, xl, epsilon, maxiter, Tstart, c, objfunct )
% This code implements a simulated annealing heuristic algorithm to
% minimize a specified objective function 
% x0:the initial guess 
% xu and xl: the upper and lower bounds
% epsilon: exploratory parameter
% maxiter: maximum number of iteations
% Tstart: starting temperature 
% c: rate of cooling 
% objfunc: handle to the objective function to be minimized

x0 = x0./(xu-xl); %normalize the initial guess
x = x0;
T = Tstart;
path = zeros([maxiter,1]);
best = zeros([maxiter,1]); %variable to track the lowest objective function value
x_best = x0;
for t = 1:maxiter
   x1 = move(x, zeros(size(x)), ones(size(x)), epsilon);   
   f = objfunct((x.*(xu-xl))');
   path(t) = f;
   dE = objfunct((x.*(xu-xl))') - objfunct((x1.*(xu-xl))');
   if dE > 0
       x = x1; 
   elseif exp(dE/T) > rand() && dE < 0
       x = x1; 
   else 
       x = x; %being pedantic 
   end
   T = schedule(Tstart,c,t);
   dE_best = objfunct((x_best.*(xu-xl))') - objfunct((x1.*(xu-xl))');
   if dE_best > 0
       x_best = x1;
   end
   best(t) = objfunct((x_best.*(xu-xl))');
end
x_best = x_best.*(xu-xl);
end

