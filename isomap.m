function [ ret ] = isomap( data, dimension )
% a simple implementation of isometric mapping
% data : a d*n data matrix where each record is col vector of size d*1
% dimension : desired dimension and dimension b is less than d
% ret : a dimension-reduced data matrix (b*n)

n = size(data, 2);

% distance matrix
D = createDistanceMatrix( data );

gap = 1e10;
% remain 7 nearest neighbors to construct local geometry
nn = 7;
for k = 1 : n
    [~, idx] = sort(D(k,:));
    D(k,idx(k+1:nn)) = gap;
end

DD = zeros(size(D));
for k = 1 : n
    % the shortest distances between node k to other nodes
    [dist,~] = dijkstra(D,k);
    % update the distance from node k to other nodes
    DD(k,:) = dist;
%     dist_t = dist';
%     tmp = D(:,k);
%     ret = zeros(n,1);
%     ret(dist_t < tmp) = dist_t(dist_t < tmp);
%     ret(tmp < dist_t) = tmp(tmp < dist_t);
%     D(:,k) = ret;
end
D = DD;
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

