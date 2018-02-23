% AER501 Assignment 1
% David Ryan Islip - 1000552797


%Load in structure information (nodes, connectivities, element info ... etc
%Uncommment the tenbartruss line to view results for the ten bar truss
%specified in the assignment 

run('threebartruss.m')
%run('tenbartruss.m')

%% Full computations. See function files for descriptions

[L, l, m] = elementmatrixproperties(connec, coords);

K = assembly(coords, connec, connec_dof,L,A,E,l,m);

[F, U] = solve(u_in, f_in, connec_dof,K );

[strain, stress, tension] = postprocess( connec, connec_dof, U, l, m, E, L, A);


%%
%Visualize the truss structure
%Note the element numbers are in black and the degrees of freedom are red

plot(coords(:,1),coords(:,2),'ob','LineWidth',3);hold on;%plot the nodes
for i = 1:size(connec,1) %plotting the undeformed truss bars in red
    x = coords(connec(i,:),1);
    y = coords(connec(i,:),2);
    plot(x,y,'-r','LineWidth',2)
    text(0.8*x(1)+0.2*x(2)+0.1,0.8*y(1)+0.2*y(2),num2str(i),'FontWeight', 'bold','FontSize',12)
end

deformed = 1000*U(connec_dof(:,:))+coords; %the deformed truss with 
%displacements (scaled by 1000)

plot(deformed(:,1),deformed(:,2),'ob','LineWidth',3)%plot the displaced nodes

for i = 1:size(connec,1)%plot the displaced truss bars
     plot(deformed(connec(i,:),1),deformed(connec(i,:),2),'-g','LineWidth',2);
end

ff=F(connec_dof);%plotting the forces on the structure (verify that they are indeed axial)
uu=U(connec_dof);
text(coords(:,1)+0.1,coords(:,2)-0.1,num2str(connec_dof),'Color','r','FontWeight', 'bold','FontSize',12)