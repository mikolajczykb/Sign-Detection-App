% function detecting potential warning signs in given image
% returns binary image of potential information signs (1) and background (0)
function bin_info = detect_objects(color, im, threshold)

% set apart certain color masks
r = im(:,:,1);
g = im(:,:,2);
b = im(:,:,3);
% subplot(2,3,1); imshow(r);
% subplot(2,3,2); imshow(g);
% subplot(2,3,3); imshow(b);

% transforming image to 1-dimension gray scale
my_bin = rgb2gray(im);
my_bin = medfilt2(my_bin, [3 3]);

% formula to take information signs by color
if strcmp(color, "red")
    formulas_value = (g./r)<threshold & (b./r)<threshold;
elseif strcmp(color, "blue")
    formulas_value = (g./b)<threshold & (r./b)<threshold;
else
    fprintf("This isn't how this function works");
    return;
end


% binarize image using threshold
my_bin(formulas_value == 1) = 255;
my_bin(formulas_value == 0) = 0;

% subplot(2,3,4); imshow(my_bin);

% noise reduction
pic_size = size(im);
my_bin = bwareaopen(my_bin, round(pic_size(1)*pic_size(2)/500));

% dilatation to reduce signs' inner part
my_bin = bwmorph(my_bin, 'dilate', 4);

% labeling objects on image
l = bwlabel(my_bin);

% getting major and minor axis' length
coeffs = regionprops(my_bin, 'MajorAxisLength', 'MinorAxisLength');
max_value = max(l, [], 'all');

% further removal of noise from image, based on major / minor axis ratio
for i = 1 : max_value
    ratio = coeffs(i).MajorAxisLength / coeffs(i).MinorAxisLength;
    if ratio > 2.0 || ratio < 0.3
        my_bin(l == i) = 0;
    end
end

bin_info = my_bin;

% closing and filling objects to create a better defined shape
bin_info = imclose(bin_info, strel('disk', 10));
bin_info = imfill(bin_info, 'holes');
% subplot(2,3,5); imshow(bin_info);

end