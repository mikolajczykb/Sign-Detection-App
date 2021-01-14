% function detecting potential information signs in given image
% returns binary image of potential information signs (1) and background (0)
function bin_info = detect_info_signs(im)

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
% formulas_value = (r+g)./(2.*b);

r_end = r./(b+0.000001);
g_end = g./(b+0.000001);
r_end(r_end < 0.11) = 0.000001;
g_end(g_end < 0.11) = 0.000001;
final_matrix = cat(3,r_end,g_end);
formulas_value = harmmean(final_matrix, 3);
test_value = harmmean(formulas_value, 'all')

% threshold determined empirically
threshhold = 0.45;
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