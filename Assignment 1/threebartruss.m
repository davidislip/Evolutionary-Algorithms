%
%This example is the verification example for the three bar truss 

coords = [[0,0];[1,0];[2,0];[1,-1]]; %node coordinates

connec_dof = [[1,2];[3,4];[5,6];[7,8]]; %mapping the coordinates to a degree 
%of freedom i.e node 1 has dof 1 and 2 in the x and y directions %respectively 

connec = [[1 4];[2 4];[3 4]]; %How each node is connected to one another

E = (10^9)*[70 70 70]'; % Young's modulus in Pa

A = (10^-4)*[1 1 1]'; %Cross sectional area in m^2

f_in = containers.Map({7},{100}); %Applying loads (N) to the structure
% in this case dof 7 is getting 100N.I.e Node 4 is being pushed to the
% right 100 N

u_in = containers.Map({1,2,3,4,5,6},{0,0,0,0,0,0}); %Applying displacement 
%boundary conditions (m),in this case nodes 1:3 are locked ie dofs 1:6 have
%u = 0