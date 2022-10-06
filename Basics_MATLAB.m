%assign a value to a variable and print it
val=10;
disp(val);
disp('');

%identity matrix of 10 rows and 5 columns
eye(10,5);
disp(eye(10,5));
disp('');

%matrix containing only ones and a matrix containing only zeros
disp(ones(2,4));
disp('');
disp(zeros(3,2));

%create a 2-d matrix
matr=[1 2;5 7;8 9;7 0];
disp('');
disp(matr);

matr1=[1 2 3 -4 5;5 7 9 0 6;8 9 1 2 3;7 0 5 6 7];
disp('');
disp('2-D matrix');
disp(matr1);
disp('');

%size of the matrix
res=size(matr1);
disp(res);

%add the matrix
a=[1 2; 3 4];
b=[5 6; 9 7];
disp('');
disp(b./a);
disp('');
disp(a+b);

%display the sum,mean,product,variance,standard of all columns of a matrix
disp('');
disp(sum(a,2));
disp('');
disp(mean(b,2));
disp('');
disp(prod(a,2));
disp('');
disp(var(b,0));
disp('');
disp(std(b,0));
disp('');

%refer ith row and jth column of a matrix
matr=[1 2 3; 4 5 6];
i=2;
j=1;
disp(matr(2,2));
disp('');

%taking a submatrix from a matrix
a=[1 2 3 4; 5 6 7 8; 8 9 0 1];
b=a(2:3,1:2);
disp(a);
disp('');
disp(b);
disp('');

%random values
m=rand(2,2);
disp(m);

%inverse of a matrix
matr=[1 2; 4 5];
disp(matr);
disp('');
i=inv(matr);
disp(i);

%refer ith row and jth column of a matrix
a=[1 2; 4 5];
b=[3 4; 7 8];
disp(a);
disp('');
disp(b);
disp('');

%Basic operations on matrices
disp('Addition of 2 matrices');
add=plus(a,b);
disp(add);
disp('');

disp('Multiplication of 2 matrices');
mul=mtimes(a,b);
disp(mul);
disp('');

disp('Subtraction of 2 matrices');
sub=minus(b,a);
disp(sub);
disp('');

disp('Determinant of a matrix b:')
deter=det(b);
disp(deter);
disp('');

m1=[1 2 3; 4 5 6; 7 8 9; 0 3 5];
disp(m1);
disp('');
disp('Sum of diagonals of matrix m1')
trace_sum=trace(m1);
disp(trace_sum);
disp('');

m=[1 2; 3 4; 5 6];
disp(m);
disp('Rank of matrix m');
disp(rank(m));
disp('');
disp('Transpose of matrix m');
disp(m');
