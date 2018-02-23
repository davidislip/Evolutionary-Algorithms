% Plot the data reults 
figure
hold on
c = ['r','b','g','m' 'b'];
for i = 1:length(P)+1
    results = reshape(data(i,:,maxiter),M,[]);
    plot(ksdensity(results(~isnan(results))),c(i),'Linewidth',2)
end
legend('Direct Penalty','Quadratic Penalty Function:1','Quadratic Penalty Function:100', 'Quadratic Penalty Function:10,000',  'Quadratic Penalty Function:10^6')
hold off
%%
figure
hold on
hist(reshape(data(:,:,maxiter),length(P)+1,[])',20)
legend('Direct Penalty','Quadratic Penalty Function:1','Quadratic Penalty Function:100', 'Quadratic Penalty Function:10,000',  'Quadratic Penalty Function:10^6')