% function calculating geometry coefficients of objects in given binary image
function coeffs = geom_coeffs(im)

% label objects
l = bwlabel(im);
% subplot(2,3,6); imshow(label2rgb(l));

% calculate how objects there are on image
n = max(l,[],'all');

% preparing region props and the most valuable coefficients
a = regionprops(im,'all');
fun = {@AO5RBlairBliss,@AO5RMalinowska,@AO5RShape,@RegionPropsCircularity,@AO5RDanielsson};

% calculate coefficients
coeffs = zeros(n, length(fun));
for i=1:n
    for j=1:length(fun)
        coeffs(i,j) = fun{j}(a(i).Image);
    end
end

end