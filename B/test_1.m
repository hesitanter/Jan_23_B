





clear;
in = 596
y = load('data_file_test_'+string(in)+'.txt');
[truth, truth_time] = read_in_truth('C:\Users\Ke Ma\Dropbox\dage&laodi\OhioT1DM-testing\OhioT1DM-testing\'+string(in)+'-ws-testing.xml');
pre_data = y(:, 1:4);
test_time = y(:, 5:10);

[step, s_time] = read_in_glucose('C:\Users\Ke Ma\Dropbox\dage&laodi\OhioT1DM-testing\OhioT1DM-testing\'+string(in)+'-ws-testing.xml');

vec = step';
t = s_time;
m = length(vec(:, 1));
n = length(truth);

i = 1; % vec index
j = 1; % truth index
while i <= m && j <= n
    if which_bigger(t(i), truth_time(j)) == 1
        vec(i, 2) = -1;
        i = i + 1;
    elseif which_bigger(truth_time(j), t(i)) == 1 && interval_2(truth_time(j), t(i)) <= truth(j)
        vec(i, 2) = 1;
        i = i + 1;
    else
        vec(i, 2) = -1;
        j = j + 1;
    end
end
vec(i:m, 2) = -1;
data = vec;
time = t;

h = figure;
plot(data(:, 2)*max(data(:, 1)));
hold on
plot(data(:, 1));
hold off
legend()
corrcoef(data(:, 1), data(:, 2))
saveas(h, sprintf('glucose_truth_%d.fig', in));



%average_exercise_bio_signal(pre_data);

test_data(:, 1:3) = mapminmax(pre_data(:, 1:3)')';
test_data(:, 4) = pre_data(:, 4);
[test_data, test_time] = sliding_mean(test_data, test_time);

test_label = test_data(:, 4);
test_label(test_label == -1) = 0; 
test_time = test_time(4:size(test_time, 1), :);

n = size(test_data, 1);
for i = 4:n
   xx = test_data(i-3:i, :);
   output(:, i-3) = reshape(xx(:, 1:3), [12,1]);
end








