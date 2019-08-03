function [Y] = vl_normal(X,step,dzdy,Z)



if step==1
    
    if nargin < 3
        [n1,n2,n3,n4,n5] = size(X);
        Xt =reshape(X,n1,n2,n3*n4,n5);
        Y=Xt;
        k = n3*n4;
    parfor i5=1:n5
            for i3 = 1:k
                X_t = Xt(1,1,:,i5);
                Xmax = max(X_t,[],'all');
                Xmin = min(X_t,[],'all');
                Y(1,1,i3,i5) = ( Xt(1,1,i3,i5) - Xmin) / (Xmax -Xmin) ;
            end
        end
    else
        
        
        [n1,n2,n3,n4,n5] = size(X);
        Xt = reshape(X,n1,n2,n3*n4,n5);
        Y = zeros(n1,n2,n3*n4,n5);
        k = n3*n4;
        
        parfor i5 = 1: n5
            for i3 = 1:k
                X_t = Xt(1,1,:,i5);
                Xmax = max(X_t,[],'all');
                Xmin = min(X_t,[],'all');
                Y(1,1,i3,i5) =(-1)*dzdy(1,1,i3,i5)  / (Xmax-Xmin) ; 
                
            end
        end
        
        for i5= 1:n5
            X_t = Xt(1,1,:,i5);
            Xmax = max(X_t,[],'all');
            Xmin = min(X_t,[],'all');
            a = find(X_t == Xmax);
            b = find(X_t == Xmin);
            Y(1,1,floor(a(1)/9)+1,i5) =sum(dzdy(1,1,:,i5).*Z(1,1,:,i5))*(-1) / (Xmax-Xmin);
            Y(1,1,floor(b(1)/9)+1,i5) =sum(dzdy(1,1,:,i5).*(Z(1,1,:,i5)+1)) / (Xmax-Xmin);
        end
    end
                
        
        
        
        
        
        
elseif step==2
    
    if nargin < 3
        [n1,n2,n3,n5] = size(X);

        Xt =reshape(X,n1,n2,n3,n5);
        Y=Xt;
        k = n3;
        
        parfor i5=1:n5
            for i3 = 1:k
                X_t = Xt(1,1,:,i5);
                Xmax = max(X_t,[],'all');
                Xmin = min(X_t,[],'all');
                Y(1,1,i3,i5) = ( Xt(1,1,i3,i5) - Xmin) / (Xmax -Xmin) ;
            end
        end
    else
        
        
        [n1,n2,n3,n5] = size(X);
        Xt = reshape(X,n1,n2,n3,n5);
        Y = zeros(n1,n2,n3,n5);
        k = n3;
        
        parfor i5 = 1: n5
            for i3 = 1:k
                X_t = Xt(1,1,:,i5);
                Xmax = max(X_t,[],'all');
                Xmin = min(X_t,[],'all');
                Y(1,1,i3,i5) =(-1)*dzdy(1,1,i3,i5)  / (Xmax-Xmin) ; 
                
            end
        end
        
        for i5= 1:n5
            X_t = Xt(1,1,:,i5);
            Xmax = max(X_t,[],'all');
            Xmin = min(X_t,[],'all');
            a = find(X_t == Xmax);
            b = find(X_t == Xmin);
            Y(1,1,floor(a(1)/9)+1,i5) =sum(dzdy(1,1,:,i5).*Z(1,1,:,i5))*(-1) / (Xmax-Xmin);
            Y(1,1,floor(b(1)/9)+1,i5) =sum(dzdy(1,1,:,i5).*(Z(1,1,:,i5)+1)) / (Xmax-Xmin);
        end
        
    end
end


                
    
    
    
            
            


        
        
                
        
        

    
    
    

