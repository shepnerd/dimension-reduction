function [ dist, prev ] = dijkstra( G, pt_start )
% a simple implementation of Dijkstra algorithm for searching the shortest
% distance between the start point to other point
% G: a directed Graph where Gij stores the Euclidean distance between
% Node i and Node j. Besides, if Gij is 1i, it means dist_ij is infinite.
% pt_start: the index of starting point
% dist: a row vector records the distances between node 1 to node j (2=<j<=n)
% prev: a row vector records the previous node which current node passes by

gap = 1e10;

n = size(G,2);
flag = zeros(1,n);
dist = G(pt_start,:);
prev = ones(1,n)*pt_start;
prev(dist==gap) = 0;

hasVisited = @(x,f)(f(x)==1);

dist(pt_start) = 0;
% mark the using start point
flag(pt_start) = 1;

for j = 2 : n
    tmp = gap;
    pt = pt_start;
    for k = 1 : n
        if ~hasVisited(k,flag) && dist(k) < tmp
            pt = k;
            tmp = dist(k);
        end
    end
    flag(pt) = 1;
    
    for k = 1 : n
        if ~hasVisited(k,flag)
            newdist = dist(pt) + G(pt,k);
            if newdist < dist(k)
                dist(k) = newdist;
                prev(k) = pt;
            end
        end
    end
end

end

