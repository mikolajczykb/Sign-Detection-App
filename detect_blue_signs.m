% function detecting potential information signs in given image
% returns binary image of potential information signs (1) and background (0)
function bin_info = detect_blue_signs(im,threshold)

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
formulas_value = (r+g)./(2.*b);
% binarize image using threshold

my_bin(formulas_value <= threshold) = 255;
my_bin(formulas_value > threshold) = 0;
% subplot(2,3,4); imshow(my_bin);

% noise reduction
bin_info=my_bin;
numberOfPixels = numel(my_bin);
% dilatation to reduce signs' inner part
% bin_info = bwmorph(my_bin, 'dilate', 10);
bin_info = imfill(my_bin,'holes');
bin_info = bwareaopen(bin_info, round(numberOfPixels/100));
bin_info = bwmorph(bin_info, 'dilate', 3);
bin_info= imfill(bin_info,'holes');

% bin_info = my_bin;
% subplot(2,3,5); imshow(bin_info);

end