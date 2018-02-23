function [ T ] = schedule( T_start,c,t )
%Compute the temperature at iteration t, based on an exponential cooling
%model
%Inputs:
%c: cooling parameter
%T_start: Initial temperrature 
%t: iteration counter 
T = T_start*c^t;

end

