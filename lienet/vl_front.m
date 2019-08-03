function [Y,Z] = vl_front(Z,dzdy)
X=Z.x;
A=Z.aux;
[n1,n2,n3,n4] = size(X);
if nargin ==1
    A= zeros(3,3,n3,n4);
    for i = 1 : n4
        for j = 1: n3
            a = zeros(3,3);
            x = X(:,:,j,i);
            Y(j,i) = X(1,1,j,i)*max(abs(x([2 3 6])));
            a(abs(x)==max(abs(x([2 3 6])))) = 1;
            A(:,:,j,i)=a;
        end
    end
    Z.aux = A;
else
    Y = zeros(n1,n2,n3,n4);
    for i4 = 1:n4
        for i3 = 1:n3
            x = X(:,:,i3,i4);
            Y(:,:,i3,i4) = x(1)*x.*A(:,:,i3,i4);
            Y(1,1,i3,i4) = dzdy(i3,i4)*max(abs(x([2 3 6])));
        end
    end
end
    


