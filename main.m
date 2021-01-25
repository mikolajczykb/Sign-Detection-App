function answer_to_display = main(filename)
    
    % thresholds
    threshold_blue = 0.65;
    threshold_red = 0.65;
    
    load('nn_final.mat');
    passed_image = double(imread(filename));
    
    % testing blue objects
    im_cpy = passed_image;
    test_blue_ver = detect_objects("blue", im_cpy, threshold_blue);
    test_coeffs = [geom_coeffs(test_blue_ver)];
    blue_sizes = size(test_coeffs);
    
    % testing red objects
    im_cpy = passed_image;
    test_red_ver = detect_objects("red", im_cpy, threshold_red);
    test_coeffs = [test_coeffs; geom_coeffs(test_red_ver)];
    
    % inserting coeffs into neural network
    result = nn(transpose(test_coeffs));
    
    % adding color coeff (1 -> blue, 0-> red)
    result_sizes = size(result);
    result(result_sizes(1) + 1, :) = 0;
    for j = 1 : blue_sizes(1)
        result(result_sizes(1) + 1, j) = 1;
    end
    
    answer_to_display = oracle(result);

end