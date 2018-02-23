function [ stress ] = stress( coords, connec, connec_dof,L,A,E,l,m,f_in,u_in  )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
K = assembly(coords, connec, connec_dof,L,A,E,l,m);

[F, U] = solve(u_in, f_in, connec_dof,K );

[strain, stress, tension] = postprocess( connec, connec_dof, U, l, m, E, L, A);

end

