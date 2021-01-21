function Circ = RegionPropsCircularity(im)
a = regionprops(im,'all');
Circ = a.Circularity;
end

