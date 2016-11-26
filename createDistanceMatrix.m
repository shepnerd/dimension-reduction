function [ D ] = createDistanceMatrix( data )
% create a distance matrix of data
% data : a d*n data matrix where each record is col vector of size d*1
% D: Dij records the Euclidean distance between data(:,i) and data(:,j)
n = size(data,2);

% distance matrix
D = zeros(n, n);
for i = 1 : n
    residual = bsxfun(@minus, data(:,i:n), data(:,i));
    D(i,i:n) = sum(residual.^2);
end
D = D + D';

end

