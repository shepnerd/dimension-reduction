function [ ret ] = lle( data, dimension )
% a simple implementation of locally linear embedding
% data : a d*n data matrix where each record is col vector of size d*1
% dimension : desired dimension and dimension b is less than d
% ret : a dimension-reduced data matrix (b*n)

n = size(data, 2);

% distance matrix
D = createDistanceMatrix( data );
W = zeros(size(D));

% remain 5 nearest neighbors to construct local geometry
nn = 5;
lambda = 1e-4;
I = eye(nn);
for i = 1 : n
    [~, idx] = sort(D(i,:));
    dict = data(:,idx(2:nn+1));
    w = (dict'*dict+lambda * I)\dict'*data(:,i);
    w = w ./ sum(w);
    W(i,idx(2:nn+1)) = w';
end
I = eye(n);
M = (I-W)'*(I-W);
[~,S,V] = svd(M);
[~,idx] = sort(diag(S));
V = V';
ret = V(idx(1:dimension),:);

end

