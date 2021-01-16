clear; clc;

% image reading
% im = double(imread('images/info06.png'));

% information signs service
% im_cpy = im;
% info_signs = detect_info_signs(im_cpy); % detecting potential information signs
% info_coeffs = geom_coeffs(info_signs) % calculate geometry coefficients
% subplot(2,2,1); imshow(info_signs);

% thresholds
threshold_blue = 0.65;
threshold_red = 0.5;

% number of images in learning set
num_of_refs = 4;

info_ref_coeffs = [];
for i=0:num_of_refs-1
    fname = sprintf('images/info%d.png', i);
    im = double(imread(fname));
    im_cpy = im;
    info_signs = detect_blue_signs(im_cpy,threshold_blue); % detecting potential information signs
    info_ref_coeffs = [info_ref_coeffs; geom_coeffs(info_signs)]; % calculate geometry coefficients
%     subplot(2,2,i+1); imshow(info_signs);
end
info_ref_coeffs


% regulatory signs service
% im_cpy = im;
% regul_signs = detect_regul_signs(im_cpy); % detecting potential regulatory signs
% regul_coeffs = geom_coeffs(regul_signs); % calculate geometry coefficients
% subplot(2,2,2); imshow(regul_signs);

regul_ref_coeffs = [];
for i=0:num_of_refs-1
    fname = sprintf('images/regul%d.png', i);
    im = double(imread(fname));
    im_cpy = im;
    regul_signs = detect_blue_signs(im_cpy,threshold_blue); % detecting potential regulatory signs
    regul_ref_coeffs = [regul_ref_coeffs; geom_coeffs(regul_signs)]; % calculate geometry coefficients
%     subplot(2,2,i+1); imshow(regul_signs);
end
regul_ref_coeffs

% warning signs service
% im_cpy = im;
% warn_signs = detect_warn_signs(im_cpy); % detecting potential warning signs
% warn_coeffs = geom_coeffs(warn_signs); % calculate geometry coefficients
% subplot(2,2,3); imshow(warn_signs);

warn_ref_coeffs = [];
for i=0:num_of_refs-1
    fname = sprintf('images/warn%d.png', i);
    im = double(imread(fname));
    im_cpy = im;
    warn_signs = detect_red_signs(im_cpy,threshold_red); % detecting potential regulatory signs
    warn_ref_coeffs = [warn_ref_coeffs; geom_coeffs(warn_signs)]; % calculate geometry coefficients
%     subplot(2,2,i+1); imshow(warn_signs);
end
warn_ref_coeffs

% prohibition signs service
% im_cpy = im;
% proh_signs = detect_proh_signs(im_cpy); % detecting potential prohibition signs
% proh_coeffs = geom_coeffs(proh_signs); % calculate geometry coefficients
% 

proh_ref_coeffs = [];
for i=0:num_of_refs-1
    fname = sprintf('images/proh%d.png', i);
    im = double(imread(fname));
    im_cpy = im;
    proh_signs = detect_red_signs(im_cpy,threshold_red); % detecting potential regulatory signs
    proh_ref_coeffs = [proh_ref_coeffs; geom_coeffs(proh_signs)]; % calculate geometry coefficients
%     subplot(2,2,i+1); imshow(proh_signs);
end
proh_ref_coeffs



test_im = double(imread('images/test5.png'));
test_coeffs = [];
break_row = [0,0,0,0,0,0,0,0];
% blue signs
im_cpy = test_im;
test_blue_ver = detect_blue_signs(im_cpy,threshold_blue);
test_coeffs = [test_coeffs;geom_coeffs(test_blue_ver)];
test_coeffs = [test_coeffs;break_row];
subplot(2,1,1); imshow(test_blue_ver);
% red signs
im_cpy = test_im;
test_red_ver = detect_red_signs(im_cpy,threshold_red);
test_coeffs = [test_coeffs;geom_coeffs(test_red_ver)];
subplot(2,1,2); imshow(test_red_ver);

test_coeffs
