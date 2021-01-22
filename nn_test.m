clear; clc;

% thresholds
threshold_blue = 0.65;
threshold_red = 0.65;

% loading working neural network
load('nn_2nd_best_rescue.mat');

% indexes of testing images
start_index_of_tests = 1;
end_index_of_tests = 10;
num_of_tests = end_index_of_tests - start_index_of_tests + 1;
% testing neural network
for i=start_index_of_tests:end_index_of_tests
    % loading file
    fname = sprintf('images/tests/test (%d).png', i);
    test_im = double(imread(fname));
    test_coeffs = [];
    % testing blue objects
    im_cpy = test_im;
    test_blue_ver = detect_blue_signs(im_cpy,threshold_blue);
    test_coeffs = [geom_coeffs(test_blue_ver)];
    blue_sizes = size(test_coeffs);
    subplot(2,num_of_tests,i-start_index_of_tests+1); imshow(test_blue_ver); % showing objects
    % testing red objects
    im_cpy = test_im;
    test_red_ver = detect_red_signs(im_cpy,threshold_red);
    test_coeffs = [test_coeffs;geom_coeffs(test_red_ver)];
    subplot(2,num_of_tests,num_of_tests+i-start_index_of_tests+1); imshow(test_red_ver); % showing objects

    % % showing test-image's coeffs 
    % test_coeffs;
    
    % inserting coeffs into neural network
    result = nn(transpose(test_coeffs));
    
    % adding color coeff (1 -> blue, 0-> red)
    result_sizes = size(result);
    result(result_sizes(1)+1,:) = 0;
    for j=1:blue_sizes(1)
        result(result_sizes(1)+1,j) = 1;
    end
    
    % showing testing results
    i
    result
    orac_res = oracle(result);
    s = size(orac_res);
    for j=1:s(1)
        fprintf(orac_res(j,:));
    end
end