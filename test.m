clear; clc;
j=1;
A(j,:) = [1,2]
j=j+1;
A(j,:) = [3,4]
j=j+1;
B = [5,6;7,8]
% size(B,1)
% size(B,2)
% A(j,:) = B(1,:);
% A(j+1,:) = B(2,:)

a = [1 2 3 ; 4 5 6; 7 8 9];
b=[5 5 5 ; 2 3 4]  
c=[a;b]% add one row
c=[a;repmat(b,7,1)]  %add 7rows