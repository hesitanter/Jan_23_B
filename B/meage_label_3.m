function [data, time] = meage_label_3(vec, t, truth, truth_time)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% vec has 3 features
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%disp("asdfasdfadfasfasdf");
m = length(vec(:, 1));
n = length(truth);

if n==0
   vec(:, 4) = -1; 
end

i = 1; % vec index
j = 1; % truth index

while i <= m && j <= n
    if which_bigger(t(i), truth_time(j)) == 1
        vec(i, 4) = -1;
        i = i + 1;
    elseif which_bigger(truth_time(j), t(i)) == 1 && interval_2(truth_time(j), t(i)) <= truth(j)
        vec(i, 4) = 1;
        i = i + 1;
    %elseif which_bigger(truth_time(j), t(i)) == 1 && interval_2(truth_time(j), t(i)) > truth(j)
    else
        vec(i, 4) = -1;
        j = j + 1;
    end
end
vec(i:m, 4) = -1;
data = vec;
time = t;