% function detecting potential warning signs in given image
% returns binary image of potential information signs (1) and background (0)
function bin_info = detect_warn_signs(im)

% set apart certain color masks
r = im(:,:,1);
g = im(:,:,2);
b = im(:,:,3);
% subplot(2,3,1); imshow(r);
% subplot(2,3,2); imshow(g);
% subplot(2,3,3); imshow(b);

% transforming image to 1-dimension gray scale
my_bin = rgb2gray(im);
% formula to take information signs by color
formulas_value = (g+b)./(2.*r);
% threshold determined empirically
threshhold = 0.29;
% binarize image using threshold
my_bin(formulas_value <= threshhold) = 255;
my_bin(formulas_value > threshhold) = 0;
% subplot(2,3,4); imshow(my_bin);

% noise reduction
my_bin = bwareaopen(my_bin, 50);
% dilatation to reduce signs' inner part
bin_info = bwmorph(my_bin, 'dilate', 10);
% subplot(2,3,5); imshow(bin_info);

end