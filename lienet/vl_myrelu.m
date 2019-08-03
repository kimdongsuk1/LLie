function [Y, R] = vl_myrelu(R, step,dzdy)
%ReLU layer
X = R.x;
A = R.aux;
epslon = 0.001;

if step == 1
    if nargin < 3
        
        [n1,n2,n3,n4,n5] = size(X);
        Y = zeros(n1,n2,n3,n4,n5);
        A = zeros(n1,n2,n3,n4,n5);
        parfor i3 = 1  : n3
            for i4 = 1 : n4
                for i5 = 1 : n5

                    r_t = X(:,:,i3,i4,i5);

                    if pi-r_t(1) < epslon || r_t(1) < epslon 
                        A(:,:,i3,i4,i5) = zeros(3,3);
                        Y(:,:,i3,i4,i5) = zeros(3,3);
                    else
                        A(:,:,i3,i4,i5)=r_t;
                        Y(:,:,i3,i4,i5)=r_t;
                    end
                end
            end
        end
        R.aux = A;
    else
        
        [n1,n2,n3,n4,n5] = size(X);
        Y = zeros(n1,n2,n3,n4,n5);
        dzdy = reshape(dzdy,n1,n2,n3,n4,n5); 

        parfor i3 = 1  : n3        
            for i4 = 1 : n4
                for i5 = 1 : n5
                    
                    if A==zeros(3,3)
                        Y(:,:,i3,i4,i5)=0;
                    else
                        Y(:,:,i3,i4,i5)=dzdy(:,:,i3,i4,i5);
                    end
                end
            end
        end
        
    end
        
else
    if nargin<3
        [n1,n2,n3,n5] = size(X);
        Y = zeros(n1,n2,n3,n5);
        A = zeros(n1,n2,n3,n5);
        parfor i3 = 1  : n3
            for i5 = 1 : n5

                r_t = X(:,:,i3,i5);

                if r_t(1) < epslon 
                    A(:,:,i3,i5) = zeros(3,3);
                    Y(:,:,i3,i5) = zeros(3,3);
                else
                    A(:,:,i3,i5)=r_t;
                    Y(:,:,i3,i5)=r_t;
                end
            end
            
        end
        R.aux = A;
    else
        [n1,n2,n3,n5] = size(X);
        Y = zeros(n1,n2,n3,n5);

        dzdy = reshape(dzdy,n1,n2,n3,n5); 
        
        parfor i3 = 1  : n3        
            for i5 = 1 : n5
                if A==zeros(3,3)
                    Y(:,:,i3,i5)=0;
                else
                    Y(:,:,i3,i5)=dzdy(:,:,i3,i5);
                end
            end
        end
        
    end
        
    
end
    
