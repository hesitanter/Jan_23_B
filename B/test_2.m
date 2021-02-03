
clear;
str = 'C:\Users\Ke Ma\Dropbox\dage&laodi\OhioT1DM-testing\OhioT1DM-testing\552-ws-testing.xml';
[insulin, i_time] = read_in_insulin(str);
[gsr, gsr_time] = read_in_gsr(str);
[step, s_time] = read_in_exercise(str);
%[heart, h_time] = read_in_hearate(str);
[glucose, g_time] = read_in_glucose(str);
[truth, t_time] = read_in_truth(str);
%[output, output_t] = merge_with_insulin(heart, h_time, step, s_time, gsr, g_time, insulin, i_time);
[output, output_t] = merge_data_3(step, s_time, gsr, gsr_time, glucose, g_time);
[data, time] = meage_label(output, output_t, truth, t_time);

test_label = data(:, 5);
test_label(test_label == -1) = 0; 


sz = length(output);
vec = output(:, 3);
for i = 2:sz
   vec(i, 1) = vec(i, 1) - vec(i-1, 1); 
end



plot(test_label*max(data(:, 3)));
hold on
plot(data(:, 3));
