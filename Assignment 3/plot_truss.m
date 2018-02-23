function [x] = plot_truss( x_best )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
run('tenbartruss.m')
%Visualize the truss structure
%Note the element numbers are in black and the degrees of freedom are red
figure
plot(coords(:,1),coords(:,2),'ob','LineWidth',3);hold on;%plot the nodes
for i = 1:size(connec,1) %plotting the undeformed truss bars in red
    x = coords(connec(i,:),1);
    y = coords(connec(i,:),2);
    plot(x,y,'-r','LineWidth',x_best(i)/max(x_best)*10)
    text(0.8*x(1)+0.2*x(2)+0.1,0.8*y(1)+0.2*y(2),num2str(i),'FontWeight', 'bold','FontSize',12)
end
x = 1

end

