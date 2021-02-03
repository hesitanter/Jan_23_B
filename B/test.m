


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 540, 567 didn't exercise
% 544 exercise data at another time, has no record at that time
% 552,584, 596 ok
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;
str = 'C:\Users\Ke Ma\Dropbox\dage&laodi\OhioT1DM-training\OhioT1DM-training\584-ws-training.xml';
[insulin, i_time] = read_in_insulin(str);
[gsr, gsr_time] = read_in_gsr(str);
[step, s_time] = read_in_exercise(str);
[truth, t_time] = read_in_truth(str);
[temp, t_temp] = read_in_skin_temperature(str);

[output, output_t] = merge_with_insulin(temp, t_temp, step, s_time, gsr, gsr_time, insulin, i_time);
%[output, output_t] = merge_data_3(step, s_time, gsr, gsr_time, temp, t_temp);
[data, time] = meage_label_4(output, output_t, truth, t_time);


plot(data(:, 4));
hold on
plot(data(:, 5));
