function [Y,Y_w] = vl_convmap(X, W,dzdy)


[n1,n2,n3,n4,n5]=size(X);

if nargin <3
    
    [m1,m2,m3] = size(W);
    Y = zeros(n1,n2,n3,(n4-1),n5,cha);


    parfor i6 = 1:cha
        for i3 = 1:n3
            for i4 = 1:n4-1 
                for i5 = 1:n5
                    Y(:,:,i3,i4,i5,i6) = W(:,:,i3+342*(i6-1))*X(:,:,i3,i4,i5)*W(:,:,171+i3+342*(16-1))*X(:,:,i3,i4+1,i5);
                end
            end
        end
    end
   
    
    
else
    
    
    Y_w = zeros(n1,n2,m3);
    
    parfor i6 = 1:cha
        for i5 = 1:n5
            for i3 = 1:n3
                Y(:,:,i3,1,i5,i6) = X(:,;,i3,2,i5)'*W(:,:,171+i3+(i6-1)*342)'dzdy(:,:,i3,1,i5)*W(:,:,i3+342*(i6-1))';
            end
        end
    end
    
    parfor i6 = 1:cha
        for i5 = 1:n5
            for i3 = 1:n3
                for i4 = 2:n4-1
                    Y(:,:,i3,i4,i5,i6) = X(:,:,i3,i4+1,i5)'*W(:,:,171+i3+(i6-1)*342)'dzdy(:,:,i3,i4,i5)*W(:,:,i3+(i6-1)*342)'+W(:,:,171+i3+(i6-1)*342)'*X(:,:,i3,i4-1,i5)'*W(:,:,i3+(i6-1)*342)'*dzdy(:,:,i3,i4-1,i5);
                end
            end
        end
    end
    
    parfor i6 = 1:cha
        for i5 = 1:n5
            for i3 = 1:n3
                Y(:,:,i3,n4,i5,i6) = W(:,:,171+i3+(i6-1)*342)'*X(:,:,i3,n4-1,i5)'*W(:,:,i3+(i6-1)*342)'*dzdy(:,:,i3,n4-1,i5);
            end
        end
    end
    
    for i3 = 1:n3
        for i6 = 1:cha
            for i4 = 1:n4-1 
                for i5 = 1:n5
                    Y_w(:,:,i3+(i6-1)*342) =dzdy(:,:,i3,i4,i5)*X(:,:,i3,i4+1,i5)'*W(:,:,171+i3+(i6-1)*342)'*X(:,:,i3,i4,i5)';
                end
            end
        end
    end

    
    
    
    
    for i3 = 1:n3
        for i4 = 1:n4-1 
            for i5 = 1:n5
                Y_w(:,:,171+i3+(i6-1)*342) = X(:,:,i3,i4,i5)'*W(:,:,i3+(i6-1)*342)'*dzdy(:,:,i3,i4,i5)'*X(:,:,i3,i4+1,i5)';
            end
        end
    end

end
    
    

