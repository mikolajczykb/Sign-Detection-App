% function calculating geometry coefficients of objects in given binary image
function coeffs = geom_coeffs(im)

% label objects
l = bwlabel(im);
% subplot(2,3,6); imshow(label2rgb(l));

% calculate how objects there are on image
n = max(l,[],'all');

% preparing region props and the most valuable coefficients
a = regionprops(im,'all');
fun = {@AO5RMalinowska,@AO5RShape,@AO5RHaralick,@AO5RCircularityS,@AO5RCircularityL,@AO5RFeret,@AO5RDanielsson};

% calculate coefficients
coeffs = zeros(n, length(fun));
for i=1:n
    for j=1:length(fun)
        coeffs(i,j) = fun{j}(a(i).Image);
    end
end

% mean value of coefficients
m = mean(coeffs);
% standard deviation of coefficients
s = std(coeffs);
% result normalization
stand_normalization = (coeffs-m)./s;

% showing unusual coefficients' values
unusual_coeffs = abs(stand_normalization)>2;

end