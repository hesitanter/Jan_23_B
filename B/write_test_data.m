function write_test_data(input)
% write test data
str = 'C:\Users\Ke Ma\Dropbox\dage&laodi\OhioT1DM-testing\OhioT1DM-testing\'+string(input)+'-ws-testing.xml';
sleep = read_in_sleep_data(str);
[gsr, gsr_time] = read_in_gsr(str);
[step, s_time] = read_in_exercise(str);
[truth, t_time] = read_in_truth(str);
[temp, t_temp] = read_in_skin_temperature(str);
%[glucose, glucose_time] = read_in_glucose(str);
[output, output_t] = merge_data_3(step, s_time, gsr, gsr_time, temp, t_temp);
[data, time] = meage_label_3(output, output_t, truth, t_time);


fp = fopen('data_file_test_'+string(input)+'.txt', 'w+');
count = 1;
for i = 1:size(data,1)
    if which_bigger(time(i), sleep(count, 2))
        fprintf(fp, '%d %d %d %d %d ' , data(i, :));
        day = str2double(time{i,1}(1:2));
        month = str2double(time{i,1}(4:5));
        year = str2double(time{i,1}(7:10));
        hour = str2double(time{i,1}(12:13));
        min = str2double(time{i,1}(15:16));
        sec = str2double(time{i,1}(18:19));
        fprintf(fp, '%d %d %d %d %d %d\r\n', day, month, year, hour, min, sec);
    elseif which_bigger(sleep(count, 2), time(i)) && which_bigger(time(i), sleep(count, 1))
        continue;
    elseif which_bigger(sleep(count, 1), time(i)) && count+1< size(sleep,1) && which_bigger(time(i), sleep(count+1, 2))
        fprintf(fp, '%d %d %d %d %d ' , data(i, :));
        day = str2double(time{i,1}(1:2));
        month = str2double(time{i,1}(4:5));
        year = str2double(time{i,1}(7:10));
        hour = str2double(time{i,1}(12:13));
        min = str2double(time{i,1}(15:16));
        sec = str2double(time{i,1}(18:19));
        fprintf(fp, '%d %d %d %d %d %d\r\n', day, month, year, hour, min, sec);
    elseif count+1<= size(sleep,1) 
        count = count + 1;
    end
end
fclose(fp);


