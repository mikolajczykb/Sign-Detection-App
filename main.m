clear; clc;

% image reading
im = double(imread('images/zakaz02.png'));
gim = im;
for i = 1:275
    for j = 1:275
       if gim(i,j,1) > 253 & gim(i,j,2) > 253 & gim(i,j,3) > 253
           gim(i,j,1) = 155;
           gim(i,j,2) = 85;
           gim(i,j,3) = 215;
       end
    end
end

imshow(gim);
% information signs service
im_cpy = im;
info_signs = detect_info_signs(im_cpy); % detecting potential information signs
info_coeffs = geom_coeffs(info_signs); % calculate gometry coefficients
subplot(2,2,1); imshow(info_signs);

% regulatory signs service
im_cpy = im;
regul_signs = detect_regul_signs(im_cpy); % detecting potential information signs
regul_coeffs = geom_coeffs(regul_signs); % calculate gometry coefficients
subplot(2,2,2); imshow(regul_signs);

% warning signs service
im_cpy = im;
warn_signs = detect_warn_signs(im_cpy); % detecting potential information signs
warn_coeffs = geom_coeffs(warn_signs); % calculate gometry coefficients
subplot(2,2,3); imshow(warn_signs);

% prohibition signs service
im_cpy = im;
proh_signs = detect_proh_signs(im_cpy); % detecting potential information signs
proh_coeffs = geom_coeffs(proh_signs); % calculate gometry coefficients
subplot(2,2,4); imshow(proh_signs);

