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
nn = feedforwardnet;
nn = train(nn, trainin, trainout);

% saving neural network
save('nn.mat', 'nn');