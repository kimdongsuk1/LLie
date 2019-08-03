function [Y,Y_w] = vl_myfc(X, W,step, dzdy,Z)

eps = 1e-14;

if step ==1
    [n1,n2,n3,n4,batchSize] = size(X);
    n5 = n3*n4;
    [m1,m2] = size(W);
    weightSize = m1;
    A= zeros(3,3,m1,batchSize);
 
    
    
    if nargin < 4
        X_t = reshape(X, n1,n2,n5,batchSize);
        Y = zeros(3,3,m1,batchSize);
        parfor i4 = 1:batchSize
            for i3 = 1 : weightSize
                for i5 = 1 : n5
                    for i = 1:3
                        for j = 1:3
                            if i ~=j
                                A(i,j,i3,i4) = A(i,j,i3,i4) + X_t(1,1,i5,i4)*W(i3,i5)*X_t(i,j,i5,i4);
                            end
                        end
                    end
                end
            end
        end

        Y=A;

    else
        Y = zeros(n1,n2,n5,batchSize);
        Y_w = zeros(m1,m2);
        temp = zeros(n1,n2,n5,batchSize);
        X_t = reshape(X, n1,n2,n5,batchSize);
        tem = zeros(n1,n2,n5,batchSize);

        %%%%%%
        parfor i3 = 1 : n5
             for i4 = 1 : batchSize 
                for i5 = 1 : m1
                    dk=dzdy(:,:,i5,i4);
                    Y(:,:,i3,i4) = Y(:,:,i3,i4) +X_t(1,1,i5,i4)* W(i5,i4)*dk.*X_t(:,:,i3,i4);
                end
             end
        end
        
        
        
%%% phi part
        
        
        
        parfor i5 = 1 : n5
            for i4 = 1 : batchSize
                temp(1,1,i5,i4) = temp(1,1,i5,i4) + ( X_t(2,1,i5,i4)+X_t(3,1,i5,i4)+X_t(3,2,i5,i4)) ;
            end
        end
        
        parfor i3 = 1 : n5
             for i4 = 1 : batchSize 
                for i5 = 1 : m1

                    if Z(1,1,i5,i4) > eps
                        Y(1,1,i3,i4) = Y(1,1,i3,i4) + W(i5,i4)*dzdy(1,1,i5,i4)*temp(1,1,i3,i4);
                    else
                        Y(1,1,i3,i4) = 0;
                    end
                end
             end
        end
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

        parfor i1 = 1 : m1
            for i2= 1 : m2
                for i4 = 1 : batchSize
                    x= X_t(:,:,i2,i4)
                    y=dzdy(:,:,i1,i2)
                    Y_w(i1,i2) =  X_t(1,1,i2,i4)*(x(2)*y(2)+x(3)*y(3)+x(6)*y(6));
                    
                end
            end
        end
    end


elseif step == 2

    if step ==1
        [n1,n2,n3,batchSize] = size(X);
        [m1,m2] = size(W);
        weightSize = m1;
        A= zeros(3,3,m1,batchSize);



        if nargin < 4
            X_t = reshape(X, n1,n2,n3,batchSize);
            Y = zeros(3,3,m1,batchSize);
            parfor i4 = 1:batchSize
                for i3 = 1 : weightSize
                    for i5 = 1 : n3
                        for i = 1:3
                            for j = 1:3
                                if i ~=j
                                    A(i,j,i3,i4) = A(i,j,i3,i4) + X_t(1,1,i5,i4)*W(i3,i5)*X_t(i,j,i5,i4);
                                end
                            end
                        end
                    end
                end
            end

            Y=A;

        else
            Y = zeros(n1,n2,n3,batchSize);
            Y_w = zeros(m1,m2);
            temp = zeros(n1,n2,n3,batchSize);
            X_t = reshape(X, n1,n2,n3,batchSize);
            tem = zeros(n1,n2,n3,batchSize);

            %%%%%%
            parfor i3 = 1 : n3
                 for i4 = 1 : batchSize 
                    for i5 = 1 : m1
                        dk=dzdy(:,:,i5,i4);
                        Y(:,:,i3,i4) = Y(:,:,i3,i4) +X_t(1,1,i5,i4)* W(i5,i4)*dk.*X_t(:,:,i3,i4);
                    end
                 end
            end



    %%% phi part



            parfor i5 = 1 : n3
                for i4 = 1 : batchSize
                    temp(1,1,i5,i4) = temp(1,1,i5,i4) + ( X_t(2,1,i5,i4)+X_t(3,1,i5,i4)+X_t(3,2,i5,i4)) ;
                end
            end

            parfor i3 = 1 : n3
                 for i4 = 1 : batchSize 
                    for i5 = 1 : m1

                        if Z(1,1,i5,i4) > eps
                            Y(1,1,i3,i4) = Y(1,1,i3,i4) + W(i5,i4)*dzdy(1,1,i5,i4)*temp(1,1,i3,i4);
                        else
                            Y(1,1,i3,i4) = 0;
                        end
                    end
                 end
            end


            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            parfor i1 = 1 : m1
                for i2= 1 : m2
                    for i4 = 1 : batchSize
                        x= X_t(:,:,i2,i4)
                        y=dzdy(:,:,i1,i2)
                        Y_w(i1,i2) =  X_t(1,1,i2,i4)*(x(2)*y(2)+x(3)*y(3)+x(6)*y(6));

                    end
                end
            end
        end


