%% Homework 3 Answer key

%Husam Almanakly 

clc
clear
close all 

%% Number 1

%a 
A = ones(100,100);
B = zeros(100,100);

%c and d
[i,j] = meshgrid(1:100,1:100);
A(sqrt((i-50).^2 + (j-50).^2)<20) = 0;
B(sqrt((i-40).^2 + (j-40).^2)<20) = 1;

%e
figure
imshow(A)

figure
imshow(B)

figure
imshow(A | B)

figure 
imshow(A & B)

figure
imshow(~(A | B))

figure
imshow(~(A & B))

%% Number 2

test = sin(linspace(0,5,100)) + 1;
[val, ind] = findClosest(test, 3/2);

val
ind


%% Number 3

N = 10001;
x = linspace(-2*pi, 2*pi, N);
y = sinc(x);

figure
plot(x,y)
hold on;

xinds = zeroCrossings(y);
xRoots = x(xinds);
yRoots = y(xinds);
plot(xRoots, yRoots, 'ko')


dydx = diff(y)./diff(x);
xEinds = zeroCrossings(dydx)
extrema = x(xEinds);
yExtrema = y(xEinds);

plot(extrema, yExtrema, "r*")


title("Sinc function with Zeros and Extrema")
xlabel("x")
ylabel("y")




    

%% Functions for 2 and 3

function [val, ind] = findClosest(x, desiredValue)
    y = x(:);
    y(y>desiredValue) = 0;
    val = max(y);
    ind = find(y==val);
end


function zeros = zeroCrossings(y)
    tmp = y(2:end);
    y = y(1:end-1);
    i = (tmp>0 & y<0) | (tmp<0 & y>0);
    zeros = find(i);

end