function  flippedMatrix = Data_Embedding(data,M,Kh,T1,T2,BoDongJuZhen)
%Input: Bit string, Two-dimensional matrix, Char string
%Output: Two-dimensional matrix
%Given the bits to hide, an image and a key
%computes the size of an sxs block based on the image dimensions and the data to be inserted,
%computes a pad matrix of the same size as a block containing pseudo-random bit (getMaskPad),
%for each image block z (getBlock) flips the block (FlipBlock) according to the pad and the z-th bit to insert
%rebuilds the image with the flipped blocks (setBlock)
[rows, cols] = size(M);
bit_num = size(data, 2);

if mod(rows*cols,bit_num)~= 0
    fprintf("#######################################################################################\n");
    fprintf(">>>>>>>>>>Dimension of image M is not divisible by lenght of data.<<<<<<<<<<\n");
    fprintf("#######################################################################################\n");
   return;
end

%computes the block size
s = sqrt(rows*cols/bit_num);

block_rows=rows/s;
block_cols=cols/s;

flippedMatrix = M;
z = 1;
sc = 0;

%computes a pad matrix of the same size as a block containing pseudo-random bit
pad = getMaskPad(s,Kh);


for i=0:block_rows-1
    for j=0:block_cols-1 
    block = getBlock(M,s,i,j);
%ÐÂÔö/ÐÞ¸Ä
    sc = BoDongJuZhen(i+1,j+1);
    if sc <= T1
        flipped_block=FlipBlock1(block, pad, data(z));
    elseif sc >= T2
        flipped_block=FlipBlock3(block, pad, data(z));
    else
        flipped_block=FlipBlock2(block, pad, data(z));
    end
    z = z+1;
    sc = 0;
    flippedMatrix = setBlock(flippedMatrix, flipped_block, i,j);
    if z == bit_num+1
        break;
    end
    end
end


end

