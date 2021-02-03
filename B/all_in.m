

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% make changes:
% add glucose, insulin, bolus and basal
% also need to test with the remaining patients 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;
% a = [559,563,570,575,588,591];
% b = [0.15, 0.034, 0.011, 0.45, 0.086, 0.081];
% for i = 1:6
%     write_test_data(a(i));
%     write_train_data(a(i));
%     A_one_shot_7(a(i), b(i));
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 540, 567 didn't exercise
% 544 exercise data at another time, has no record at that time
% 552,584, 596 ok
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a = [552,584,596];
b = [0, 0, 0];
for i = 1:3
    write_test_data(a(i));
    write_train_data(a(i));
    A_one_shot_7(a(i), b(i));
end

% i=1;
% A_one_shot_7(a(i), b(i));

