%以高四位构造灰度图像
Mgray = bitand(M,240);
%按边长分块后计算每块波动值，构造fun函数
%fun函数用来计算波动值
fun1 = @(x)sum(sum(abs(diff(x.data,1,1))));
fun2 = @(x)sum(sum(abs(diff(x.data,1,2))));
BoDongJuZhen = blockproc(Mgray,[8,8],fun1)+blockproc(Mgray,[8,8],fun2);
%将矩阵BoDongJuZhen化为数组后排序
DataBoDong = sort(BoDongJuZhen(:)');
%计算出标准T1，T2
T1 = DataBoDong(floor(length(DataBoDong)/3));
T2 = DataBoDong(floor(length(DataBoDong)/3*2));
