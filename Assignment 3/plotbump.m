figure
[X,Y] = meshgrid(0:0.1:10,0:0.1:10);
x = [reshape(X, numel(X),[]) reshape(Y,numel(Y),[])];
g = zeros([numel(X),1]);
for i = 1: numel(X)
g(i) = bump(x(i,:));
end
Z = reshape(g, size(X));
Z(Z>1) = 0;
surf(X,Y,-Z)