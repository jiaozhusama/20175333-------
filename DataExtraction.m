function [Bdec,bitData] = DataExtraction(M,Kh,bit_num,T1, T2, BoDongJuZhen)
%Input: Two-dimensional matrix, Char string, Integer
%Output: Two-dimensional matrix, Char string
%Given an image M a Kh key and the number of hidden bits, it calculates the number and size of blocks
%in which to divide the image based on the number of hidden bits, and for each block (getBlock):
%Recall FlipBlock twice (With b = 0 and b = 1) to obtain H1 and H2.
%Calculates the fluctuation (calculateFluctuation) of H1 and H2, compares them and chooses the minor.
%Reconstruct the original image with the matrices and bits chosen in the previous step


[row,cols] = size(M);

s = sqrt(row*cols/bit_num);
numBlock = bit_num; 
blockCols = cols/s;
blockRow = row/s;

bitData = zeros(1,numBlock,'uint8');
Bdec = zeros(row,cols,'uint8');
h=1;
sc = 0;

pad = getMaskPad(s,Kh);

for i = 0:blockRow-1
    for j = 0:blockCols-1

        block = getBlock(M,s,i,j);
        sc = BoDongJuZhen(i+1,j+1);
        if sc <= T1
            H1 = FlipBlock1(block,pad,0);
            H2 = FlipBlock1(block,pad,1);
        elseif sc >= T2
            H1 = FlipBlock3(block,pad,0);
            H2 = FlipBlock3(block,pad,1);
        else
            H1 = FlipBlock(block,pad,0);
            H2 = FlipBlock(block,pad,1);
        end
       
        fluctH1 = calculateFluctuation(H1);
        fluctH2 = calculateFluctuation(H2);
     
        if fluctH1 < fluctH2
            bitData(h) = 0;         
            Bdec(i*s+1 : i*s+s, j*s+1 : j*s+s) = H1;%Bdec = setBlock(Bdec,H1,i,j);
        else
            bitData(h) = 1;
            Bdec(i*s+1 : i*s+s, j*s+1 : j*s+s) = H2;%Bdec = setBlock(Bdec,H2,i,j);
        end
        
        h = h + 1;
    end          
end

 

end