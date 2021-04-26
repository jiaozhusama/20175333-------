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
%���߳��ֿ�����ÿ�鲨��ֵ������fun����
%fun�����������㲨��ֵ
fun1 = @(x)sum(sum(abs(diff(x.data,1,1))));
fun2 = @(x)sum(sum(abs(diff(x.data,1,2))));
BoDongJuZhen = blockproc(Mgray,[s,s],fun1)+blockproc(Mgray,[s,s],fun2);
%������BoDongJuZhen��Ϊ���������
DataBoDong = sort(BoDongJuZhen(:)');
%�������׼T1��T2
T1 = DataBoDong(floor(length(DataBoDong)/x));
T2 = DataBoDong(floor(length(DataBoDong)/y*( y - 1 )));



end
