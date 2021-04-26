% A = round(100 * rand(10, 10))
% d = ones(3, 3);
% fun = @(block_struct) min(min(block_struct.data));
% dark = blockproc(A, [3, 3], fun)
% dark2 =sort(dark(:)')
% T1 = dark2(floor(length(dark2)/3))
% T2 = dark2(floor(length(dark2)/3*2))

clear;
clc;
Mgray = round(100 * rand(8, 8));
z = 1;
sc = 0;
i = 0;
j = 0;
fun1 = @(x)sum(sum(abs(diff(x.data,1,1))));
fun2 = @(x)sum(sum(abs(diff(x.data,1,2))));
BoDongJuZhen = blockproc(Mgray,[2,2],fun1)+blockproc(Mgray,[2,2],fun2);

for i=0:4-1
    for j=0:4-1 
%ÐÂÔö/ÐÞ¸Ä
    sc = BoDongJuZhen(i+1,j+1);
    disp(sc);
    end
end

    


