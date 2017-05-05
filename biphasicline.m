function [val,dval,ddval] = biphasicline(x, a, b, x0, y0, n)
% Integral wrt x of b/(1+exp(x0-x)^n) + a/(1+exp(x-x0)^n), two slopes multiplied
% by x-flipped sigmoidal functions, with a cooperativity coefficient of n.
% The function switches smoothly between the two slopes as we move along x.
% y0 is the height of the intersection of the two lines.

% Determine which x's are close enough to x0 to need the exponential form
xdiff = x-x0;
isa = n.*xdiff < -10;
isb = n.*xdiff > 10;
islowdiff = ~isa & ~isb;

val = zeros(size(x));
val(islowdiff) = (n.*x(islowdiff).*(a+b) + b.*log(exp(n.*(x0-x(islowdiff)))+1) - a.*log(exp(n.*(x(islowdiff)-x0))+1))/n - x0*(a+b) + y0;
val(isa) = a.*(x(isa)-x0)+y0;
val(isb) = b.*(x(isb)-x0)+y0;

if nargout > 1
    dval = zeros(size(x));
    dval(islowdiff) = b./(1+exp(x0-x(islowdiff)).^n) + a./(1+exp(x(islowdiff)-x0).^n);
    dval(isa) = a;
    dval(isb) = b;
    
    if nargout > 2
        error('Second order derivatives are currently incomplete!')
        ddval = zeros(size(x));
        ddval(islowdiff) = a.*n.*(exp(x0-x(islowdiff))).^n;
        ddval(isa) = 0;
        ddval(isb) = 0;
    end
end

end