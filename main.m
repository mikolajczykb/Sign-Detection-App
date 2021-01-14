clear; clc;

% image reading
im = double(imread('images/info06.png'));

% information signs service
info_signs = detect_info_signs(im); % detecting potential information signs
info_coeffs = geom_coeffs(info_signs) % calculate gometry coefficients

