function [ weight isvalid ] = trussweight(A0)
%Computes the weight of the aluminum truss specified in assignment 1
%Adds a penalty to the weight based on the proposed structures ability to
%handle the loading conditions
%Inputs
%A0 = nx1 vector of cross sectional areas
%Outputs
%weight: objective function value
%islvalid: is this solution valid?
    global quad rho
    %defining problem data as per assignment 1
    A0 = A0';
    coords = [[0,0];[1,0];[2,0];[0,1];[1,1];[2,1]];
    connec_dof = [[1,2];[3,4];[5,6];[7,8];[9 10];[11 12]];
    connec = [[1 2];[2 3];[1 5];[4 2];[4,5];[5,2];[5,3];[2,6];[5,6];[6,3]];
    E = (10^9)*[70 70 70 70 70 70 70 70 70 70]';
    f_in = containers.Map({4,6},{-100,-100});
    u_in = containers.Map({1,2,7,8},{0,0,0,0});
    density = 2700; %kg/m^3
    %using the finite element method to compute stresses
    [L, l, m] = elementmatrixproperties(connec, coords);
    sigma_y =  276*10^6;
    stress = computestress( coords, connec, connec_dof,L,A0,E,l,m,f_in,u_in);
    M = 10^8;
    weight = density*A0'*L + M*(sum(abs(stress) > sigma_y)>0);
    
    isvalid = 1;
    g = abs(stress)/sigma_y - 1;
    if quad == 1
        weight = density*A0'*L + rho*(sum(g(g>0).^2));
    end
    isvalid = 1;
    if sum(g(g>0))>0
        isvalid = 0;
    end
end

