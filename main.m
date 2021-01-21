clear; clc;

% thresholds
threshold_blue = 0.65;
threshold_red = 0.65;

% indexes of images in learning set
start_index_of_refs = 1;
end_index_of_refs = 26;

% square shape
info_ref_coeffs = [];
for i=start_index_of_refs:end_index_of_refs
    fname = sprintf('images/infos/info%d.png', i);
    im = double(imread(fname));
    im_cpy = im;
    info_signs = detect_blue_signs(im_cpy,threshold_blue); % detecting potential information signs
    info_ref_coeffs = [info_ref_coeffs; geom_coeffs(info_signs)]; % calculate geometry coefficients
    subplot(5,10,i); imshow(info_signs);
end
info_ref_coeffs

% circle shape
figure;
regul_ref_coeffs = [];
for i=start_index_of_refs:end_index_of_refs
    fname = sprintf('images/reguls/regul%d.png', i);
    im = double(imread(fname));
    im_cpy = im;
    regul_signs = detect_blue_signs(im_cpy,threshold_blue); % detecting potential regulatory signs
    regul_ref_coeffs = [regul_ref_coeffs; geom_coeffs(regul_signs)]; % calculate geometry coefficients
    subplot(5,10,i); imshow(regul_signs);
end
regul_ref_coeffs

% triangle shape
figure;
warn_ref_coeffs = [];
for i=start_index_of_refs:end_index_of_refs
    fname = sprintf('images/warns/warn%d.png', i);
    im = double(imread(fname));
    im_cpy = im;
    warn_signs = detect_red_signs(im_cpy,threshold_red); % detecting potential regulatory signs
    warn_ref_coeffs = [warn_ref_coeffs; geom_coeffs(warn_signs)]; % calculate geometry coefficients
    subplot(5,10,i); imshow(warn_signs);
end
warn_ref_coeffs

% % circle shape - do not need due to regul-signs
% figure;
% proh_ref_coeffs = [];
% for i=start_index_of_refs:end_index_of_refs
%     fname = sprintf('images/prohs/proh%d.png', i);
%     im = double(imread(fname));
%     im_cpy = im;
%     proh_signs = detect_red_signs(im_cpy,threshold_red); % detecting potential regulatory signs
%     proh_ref_coeffs = [proh_ref_coeffs; geom_coeffs(proh_signs)]; % calculate geometry coefficients
%     subplot(4,14,42+i); imshow(proh_signs);
% end
% proh_ref_coeffs;

% trainin-set
trainin = transpose([info_ref_coeffs; regul_ref_coeffs; warn_ref_coeffs]);
% number of testing objects
num = end_index_of_refs - start_index_of_refs + 1;
% trainout-set
trainout = [repmat([1;0;0], 1, num), repmat([0;1;0], 1, num), repmat([0;0;1], 1, num)];

% % creating new neural network
% nn = feedforwardnet;
% nn = train(nn, trainin, trainout);

% loading working neural network
load('nn_2nd_best_rescue.mat');

figure;
% indexes of testing images
start_index_of_tests = 1;
end_index_of_tests = 30;
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
    subplot(2,num_of_tests,i-start_index_of_tests+1); imshow(test_blue_ver); % showing objects
    % testing red objects
    im_cpy = test_im;
    test_red_ver = detect_red_signs(im_cpy,threshold_red);
    test_coeffs = [test_coeffs;geom_coeffs(test_red_ver)];
    subplot(2,num_of_tests,num_of_tests+i-start_index_of_tests+1); imshow(test_red_ver); % showing objects

    % % showing test-image's coeffs 
    % test_coeffs;
    
    % showing testing results
    i
    nn(transpose(test_coeffs))
end

% saving neural network
% save('nn.mat', 'nn');