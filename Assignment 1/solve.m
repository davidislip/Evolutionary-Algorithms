function [ F U ] = solve(u_in, f_in, connec_dof,K )
%This function solves for the force and displacement vector for the
%structure. 

%u_known_node = cell2mat(keys(u_in));
known_udof = sort(cell2mat(keys(u_in)));
%f_known_node = cell2mat(keys(f_in));
known_fdof = sort(cell2mat(keys(f_in)));
U = zeros(size(K,1),1);

for i = known_udof
    U(i) = u_in(i);
end

F = zeros(size(K,1),1);
for i = known_fdof
    F(i) = f_in(i);
end

unknown_udof = sort(setdiff(1:size(K,1), known_udof));

unknown_u = inv(K(unknown_udof,unknown_udof))*(F(unknown_udof) - K(unknown_udof,known_udof)*U(known_udof));

U(unknown_udof) = unknown_u;
F = K*U;

end

