function [data, time] = meage_label(vec, t, truth, truth_time)
m = length(vec(:, 1));
n = length(truth);

if n==0
   vec(:, 5) = -1; 
end

i = 1; % vec index
j = 1; % truth index

while i <= m && j <= n
    if which_bigger(t(i), truth_time(j)) == 1
        vec(i, 5) = -1;
        i = i + 1;
    elseif which_bigger(truth_time(j), t(i)) == 1 && interval_2(truth_time(j), t(i)) <= truth(j)
        vec(i, 5) = 1;
        i = i + 1;
    %elseif which_bigger(truth_time(j), t(i)) == 1 && interval_2(truth_time(j), t(i)) > truth(j)
    else
        vec(i, 5) = -1;
        j = j + 1;
    end
end
vec(i:m, 5) = -1;
data = vec;
time = t;