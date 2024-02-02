function A_smooth = channel_smooth(A,mean,std)

A_smooth = A;
[r,c] = size(A);
for i = 1:r
    for j = 1:c
        diff = A(i,j) - mean;
        if abs(diff) > 3*std
            if i>1 && i<r && j>1 && j<c
                A_smooth(i,j) = (A(i-1,j) + A(i,j-1) + A(i,j+1) + A(i+1,j)) / 4;
            elseif i==1
                if j==1
                    A_smooth(i,j) = (A(i,j+1) + A(i+1,j)) / 2;
                elseif j==c
                    A_smooth(i,j) = (A(i,j-1) + A(i+1,j)) / 2;
                else
                    A_smooth(i,j) = (A(i,j-1) + A(i,j+1) + A(i+1,j)) / 3;
                end
            elseif i==r
                if j==1
                    A_smooth(i,j) = (A(i-1,j) + A(i,j+1)) / 2;
                elseif j==c
                    A_smooth(i,j) = (A(i-1,j) + A(i,j-1)) / 2;
                else
                    A_smooth(i,j) = (A(i,j-1) + A(i,j+1) + A(i-1,j)) / 3;
                end
            else
                if j==1
                    A_smooth(i,j) = (A(i-1,j) + A(i+1,j) + A(i,j+1)) / 3;
                else
                    A_smooth(i,j) = (A(i-1,j) + A(i+1,j) + A(i,j-1)) / 3;
                end
            end
        end
    end
end
