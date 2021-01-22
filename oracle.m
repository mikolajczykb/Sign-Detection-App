function answer = oracle(nn_result)

    % is info-regul-warn-proh sign
    present_sign_types = [0,0,0,0];
    
    nn_result_sizes = size(nn_result);
    
    for j=1:nn_result_sizes(2)
        for i=1:nn_result_sizes(1)-1
            diff = abs(nn_result(i,j)-1);
            if diff<=0.1
                switch i
                    case 1
                        if nn_result(4,j)==1
                            present_sign_types(1) = 1;
                        end
                    case 2
                        if nn_result(4,j)==1
                            present_sign_types(2) = 1;
                        elseif nn_result(4,j)==0
                            present_sign_types(4) = 1;
                        end
                    case 3
                        if nn_result(4,j)==0
                            present_sign_types(3) = 1;
                        end
                    otherwise
                        fprintf('I am an oracle but I dunno O_O')
                end
            end
        end
    end
    
    num_of_sign_types_detected = sum(present_sign_types);
    if num_of_sign_types_detected>0
        answer = char(zeros(num_of_sign_types_detected,12));

        i=1;
        if present_sign_types(1)==1
            answer(i,1:12) = 'INFORMACYJNY';
            i=i+1;
        end
        if present_sign_types(2)==1
            answer(i,1:12) = '   NAKAZU   ';
            i=i+1;
        end
        if present_sign_types(3)==1
            answer(i,1:12) = 'OSTRZEGAWCZY';
            i=i+1;
        end
        if present_sign_types(4)==1
            answer(i,1:12) = '   ZAKAZU   ';
        end
    elseif num_of_sign_types_detected == 0
        answer = char(zeros(1,12));
        answer(1,1:12) = ' BRAK ZNAKU ';
    end
end

