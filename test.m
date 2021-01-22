clear; clc;
% j=1;
% A(j,:) = [1,2]
% j=j+1;
% A(j,:) = [3,4]
% j=j+1;
% B = [5,6;7,8]
% % size(B,1)
% % size(B,2)
% % A(j,:) = B(1,:);
% % A(j+1,:) = B(2,:)
% 
% a = [1 2 3 ; 4 5 6; 7 8 9];
% b=[5 5 5 ; 2 3 4]  
% c=[a;b]% add one row
% c=[a;repmat(b,7,1)]  %add 7rows


N=[1,2,3;3,2,3;5,2,3;4,5,5;5,5,5]
N_sizes = size(N)



R = [1,2,3,4,5,6,7;3,4,5,6,7,8,9;5,6,7,8,9,10,11]

R_sizes = size(R)

R(R_sizes(1)+1,:) = 0

for i=1:N_sizes(1)
    R(R_sizes(1)+1,i) = 1;
end
R


a = [0;0;0;0]
fprintf('elo\nelo');

q = char(zeros(5,12));
q(1,1:12) = 'INFORMACYJNY';
q(2,1:12) = '   NAKAZU   ';
q(3,1:12) = 'OSTRZEGAWCZY';
q(4,1:12) = '   ZAKAZU   ';
q(5,1:12) = ' BRAK ZNAKU ';
q(1,:)
S = size(q)