function [success] = freevibration( EA, EI, rhoA, N_files )
%This function computes the free vibration modes and plots the frequencies
%for each mesh refinement 
figure 
hold on
for i = 1:N_files
    run(['Mesh' num2str(i) '.m'])
    coords = [X;Y]';
    connec = NOD;
    connec_dof = reshape(1:3*size(coords,1),3,[])';
    [K, M]= assembly(X,Y,coords, connec, connec_dof, EA, EI, rhoA);
    K = K(dof_active, dof_active);
    M = M(dof_active, dof_active);
    [phi,lambda] = eig(K,M);
    frq = diag(lambda).^0.5/(2*pi);
     
    plot(frq(1:12),'LineWidth',3)
end
title('First 12 natural frequencies in Hz as element mesh is refined','interpreter','latex')
legend('iteration 1','iteration 2','iteration 3','iteration 4')
xlabel('eigenmode No.' ,'interpreter','latex')
ylabel('Frequency (Hz)' ,'interpreter','latex')
text(1,300,'$$ K\phi = \lambda M \phi$$','Interpreter','latex')
hold off
success = 1;
end

