function [ f ] = bump(x)
%Computes the 2-D bump function modified by the direct penalty 
%input x: decision vector 
%output f: objective function value
M = 10^8;
n = 2;
denom = (sum((1:n).*x.^2))^0.5;
f = -abs((sum(cos(x).^4) - 2*prod(cos(x).^2)))/denom + M*((prod(x)<=0.75)|(sum(x)>= 15*n/2));
end

