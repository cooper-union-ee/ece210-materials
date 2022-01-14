function b = myFunction(a) % main function
   b = squareMe(a)+doubleMe(a);
end
function y = squareMe(x) % local functions; can only be referenced by functions in the same file
   y = x.^2;
end
function y = doubleMe(x)
   y = x.*2;
end