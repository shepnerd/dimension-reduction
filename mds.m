function [ ret ] = mds( data, dimension )
% a simple implementation of multiple dimensional scaling
% data : a d*n data matrix where each record is col vector of size d*1
% dimension : desired dimension and dimension b is less than d
% ret : a dimension-reduced data matrix (b*n)

n = size(data,2);

% distance matrix
D = createDistanceMatrix( data );
di_ = sum(D,2) / n;
d_j = sum(D,1) / n;
d__ = sum(sum(D))/ n / n;

Di_ = repmat(di_,[1 n]);
D_j = repmat(d_j,[n 1]);
D__ = repmat(d__,[n n]);

% B = data_compressed'*data_compressed
B = -0.5*(D-Di_-D_j+D__);

[~,S,V] = svd(B);
s = diag(S);
[~,idx] = sort(s,'descend');
idx = idx(1:dimension);

ret = diag(s(idx)).^0.5*V(:,idx)';

end

