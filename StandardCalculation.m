function [T1,T2,BoDongJuZhen] = StandardCalculation(Mgray,data)

x = 0;
y = 0;
T1 = 0;
T2 = 0;
[m,n] = size(Mgray);
bit_num = size(data, 2);
if mod(m*n,bit_num)~= 0
    fprintf("#######################################################################################\n");
    fprintf(">>>>>>>>>>Dimension of image M is not divisible by lenght of data.<<<<<<<<<<\n");
    fprintf("#######################################################################################\n");
   return;
end
s = sqrt(m*n/bit_num);
x = s * 2;
y = s * 8;
%按边长分块后计算每块波动值，构造fun函数
%fun函数用来计算波动值
fun1 = @(x)sum(sum(abs(diff(x.data,1,1))));
fun2 = @(x)sum(sum(abs(diff(x.data,1,2))));
BoDongJuZhen = blockproc(Mgray,[s,s],fun1)+blockproc(Mgray,[s,s],fun2);
%将矩阵BoDongJuZhen化为数组后排序
DataBoDong = sort(BoDongJuZhen(:)');
%计算出标准T1，T2
T1 = DataBoDong(floor(length(DataBoDong)/x));
T2 = DataBoDong(floor(length(DataBoDong)/y*( y - 1 )));



end
