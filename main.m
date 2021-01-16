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



test_im = double(imread('images/test9.png'));
test_coeffs = [];
% break_row = [0,0,0,0,0,0,0,0,0];
% blue signs
im_cpy = test_im;
test_blue_ver = detect_blue_signs(im_cpy,threshold_blue);
test_coeffs = [geom_coeffs(test_blue_ver)];

% tutaj probowalem dodac te wspolczynniki
% blue_coeffs = [geom_coeffs(test_blue_ver)];
% sz = size(blue_coeffs);
% test_coeffs = [];
% for i = 1 : sz(1)
%    test_coeffs = [test_coeffs; blue_coeffs(i,:) 1];
% end

% test_coeffs = [test_coeffs;break_row];
subplot(2,1,1); imshow(test_blue_ver);
% red signs
im_cpy = test_im;
test_red_ver = detect_red_signs(im_cpy,threshold_red);

% tutaj zas czerwone
% red_coeffs = geom_coeffs(test_red_ver);
% sz = size(red_coeffs);
% for i = 1 : sz(1)
%    test_coeffs = [test_coeffs; red_coeffs(i,:) 0];
% end

test_coeffs = [test_coeffs;geom_coeffs(test_red_ver)];
% test_coeffs = [test_coeffs; red_coeffs];
subplot(2,1,2); imshow(test_red_ver);

test_coeffs
% z ukladaniem wspolczynnikow wzdluz kolumn zamiast wierszy to inspirowalem
% sie labkami jezusa
%kazda kolumna przechowuje wspolczynniki kolejnych obiektow, 16 obiektow -
%16 kolumn
trainin = transpose([info_ref_coeffs; regul_ref_coeffs; warn_ref_coeffs; proh_ref_coeffs]);
%tez 16 kolumn, ale 4 wiersze poniewaz mamy 4 rodzaje znakow
trainout = [repmat([1;0;0;0], 1, 4), repmat([0;1;0;0], 1, 4), repmat([0;0;1;0], 1, 4), repmat([0;0;0;1], 1, 4)];


nn = feedforwardnet;
nn = train(nn, trainin, trainout);

%transpozycja zeby wspolczynniki byly ulozone wzdluz kolumn, nie wierszy
nn(transpose(test_coeffs))