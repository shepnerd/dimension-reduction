
clear; clc;

load mnist;

sz = 1000;

data = teData(:,1:sz);
label = teLabel(1:sz);

d = 3;

n = size(data,2);

data_compressed = lle(data, d);

label_class = unique(label);

props = {'ro', 'b*', 'k^', 'ys', 'g+'};

for i = 1 : 5
    class = label_class(i);
    idx = (label == class);
    plot3(data_compressed(1,idx),data_compressed(2,idx),data_compressed(3,idx),props{i});
    hold on;
end
grid on;
saveas(gcf, 'visualization_digits_0-4_lle.jpg');




