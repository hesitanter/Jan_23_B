function [output, output_t] = merge_with_insulin(heart, h_time, exercise, e_time, gsr, gsr_time, insulin, i_time)
% IMPORTANT!!!! Assume size(glucose) > size(insulin)
% steps, heart rate, gsr, skin temperature
n = size(exercise, 2); 
l = size(heart, 2);

count = 1; % value index
i = 1; % exercise time index
j = 1; % heart rate time index
value = zeros(2, 100); % exercise + hearate
time = strings(1, 100);
[i, j] = neat_time(e_time, i, h_time, j);   % neat time of exercise and heart rate

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% merge basis_step and heart rate 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while i < n && j < l
    % a is the smaller one
    if (which_bigger(h_time(j), e_time(i)) == 1)
        a = h_time(j);
        b = e_time(i);
    else
        a = e_time(i);
        b = h_time(j);
    end
    % c is the bigger one
    if (which_bigger(e_time(i), h_time(j+1)) == 1)
        c = h_time(j+1);
        d = e_time(i);
    else
        c = e_time(i);
        d = h_time(j+1);
    end
    
    if interval_2(a, b) <= 3
        value(1, count) = exercise(i);
        value(2, count) = heart(j);
        time(1, count) = e_time(i); 
        i = i + 1;
        j = j + 1;
        count = count + 1;
    elseif interval_2(d, c) <= 3
        value(1, count) = exercise(i);
        value(2, count) = heart(j);
        time(1, count) = e_time(i); 
        i = i + 1;
        j = j + 2;
        count = count + 1;
    else
        i = i + 1;
        [i, j] = neat_time(e_time, i, h_time, j);
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% merge value(step + heart) with gsr
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n = size(value, 2); 
l = size(gsr, 2);

count = 1; % value index
i = 1; % value time index
j = 1; % gsr  time index
value_f = zeros(3, 100); % exercise + hearate
time_f = strings(1, 100);
[i, j] = neat_time(time, i, gsr_time, j);   % neat time of exercise and heart rate

while i < n && j < l
    % a is the smaller one
    if (which_bigger(gsr_time(j), time(i)) == 1)
        a = gsr_time(j);
        b = time(i);
    else
        a = time(i);
        b = gsr_time(j);
    end
    % c is the bigger one
    if (which_bigger(time(i), gsr_time(j+1)) == 1)
        c = gsr_time(j+1);
        d = time(i);
    else
        c = time(i);
        d = gsr_time(j+1);
    end
    
    if interval_2(a, b) <= 3
        value_f(1:2, count) = value(:, i);
        value_f(3, count) = gsr(j);
        time_f(1, count) = time(i); 
        i = i + 1;
        j = j + 1;
        count = count + 1;
    elseif interval_2(d, c) <= 3
        value_f(1:2, count) = value(:, i);
        value_f(3, count) = gsr(j);
        time_f(1, count) = time(i); 
        i = i + 1;
        j = j + 2;
        count = count + 1;
    else
        i = i + 1;
        [i, j] = neat_time(time, i, gsr_time, j);
    end
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% merge value1(step, heart rate, gsr) and insulin, 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
i = 1; % index of value1
j = 1; % index of insulin
k = 1;
[i, j] = neat_time(time_f, i, i_time, j);
n = size(value_f, 2); % column of value1
m = size(insulin, 2); 
output = zeros(4, 100);
output_t = strings(1, 100);
while i <= n
    while j ~= m-1
        if which_bigger(i_time(j), time_f(i)) && which_bigger(time_f(i), i_time(j+1))
            break;
        end
        j = j + 1;
    end
    
    
    output(1:3, k) = value_f(:, i);
    output(4, k) = insulin(1, j);% insulin
    output_t(1, k) = time_f(1, i);
    i = i + 1;
    k = k + 1;
end


output = output';
output_t = output_t';