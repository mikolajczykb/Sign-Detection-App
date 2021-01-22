clear; clc;

% script to train the neural network from scratch

% thresholds
threshold_blue = 0.65;
threshold_red = 0.65;

% indexes of images in learning set
start_index_of_refs = 1;
end_index_of_refs = 26;

% square shape
square_ref_coeffs = [];
for i = start_index_of_refs : end_index_of_refs
    fname = sprintf('images/infos/info%d.png', i);
    im = double(imread(fname));
    im_cpy = im;
    square_signs = detect_objects("blue", im_cpy, threshold_blue); % detecting potential information signs
    square_ref_coeffs = [square_ref_coeffs; geom_coeffs(square_signs)]; % calculate geometry coefficients
    subplot(5,10,i); imshow(square_signs);
end
square_ref_coeffs;

% circle shape
figure;
circle_ref_coeffs = [];
for i = start_index_of_refs : end_index_of_refs
    fname = sprintf('images/reguls/regul%d.png', i);
    im = double(imread(fname));
    im_cpy = im;
    circle_signs = detect_objects("blue", im_cpy, threshold_blue); % detecting potential regulatory signs
    circle_ref_coeffs = [circle_ref_coeffs; geom_coeffs(circle_signs)]; % calculate geometry coefficients
    subplot(5,10,i); imshow(circle_signs);
end
circle_ref_coeffs;

% triangle shape
figure;
triangle_ref_coeffs = [];
for i = start_index_of_refs : end_index_of_refs
    fname = sprintf('images/warns/warn%d.png', i);
    im = double(imread(fname));
    im_cpy = im;
    triangle_signs = detect_objects("red", im_cpy, threshold_red); % detecting potential regulatory signs
    triangle_ref_coeffs = [triangle_ref_coeffs; geom_coeffs(triangle_signs)]; % calculate geometry coefficients
    subplot(5,10,i); imshow(triangle_signs);
end
triangle_ref_coeffs;

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
trainin = transpose([square_ref_coeffs; circle_ref_coeffs; triangle_ref_coeffs]);
% number of testing objects
num = end_index_of_refs - start_index_of_refs + 1;
% trainout-set
trainout = [repmat([1;0;0], 1, num), repmat([0;1;0], 1, num), repmat([0;0;1], 1, num)];

% % creating new neural network
nn = feedforwardnet;
nn = train(nn, trainin, trainout);

% saving neural network
save('nn.mat', 'nn');