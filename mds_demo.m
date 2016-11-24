
clear; clc;

load mnist;

data = teData;
label = teLabel;

n = size(data,2);

% distance matrix
D = zeros(n, n);
for i = 1 : n
    residual = bsxfun(@minus, data(:,i:n), data(:,i));
    D(i,i:n) = sum(residual.^2);
end
D = D + D';
di_ = sum(D,2) / n;
d_j = sum(D,1) / n;
d__ = sum(sum(D))/ n / n;

Di_ = repmat(di_,[1 n]);
D_j = repmat(d_j,[n 1]);
D__ = repmat(d__,[n n]);

% B = data_compressed'*data_compressed
B = -0.5*(D-Di_-D_j+D__);

[U,S,V] = svd(B);
s = diag(S);
[~,idx] = sort(s,'descend');

d = 3;
data_compressed = diag(s(idx)).^0.5*V(:,idx)';

label_class = unique(label);

props = {'ro', 'b*', 'k^', 'ys', 'g+'};

for i = 1 : 5
    class = label_class(i);
    idx = (label == class);
    plot3(data_compressed(1,idx),data_compressed(2,idx),data_compressed(3,idx),props{i});
    hold on;
end
grid on;
saveas(gcf, 'visualization_digits_0-4.jpg');




