%�Ը���λ����Ҷ�ͼ��
Mgray = bitand(M,240);
%���߳��ֿ�����ÿ�鲨��ֵ������fun����
%fun�����������㲨��ֵ
fun1 = @(x)sum(sum(abs(diff(x.data,1,1))));
fun2 = @(x)sum(sum(abs(diff(x.data,1,2))));
BoDongJuZhen = blockproc(Mgray,[8,8],fun1)+blockproc(Mgray,[8,8],fun2);
%������BoDongJuZhen��Ϊ���������
DataBoDong = sort(BoDongJuZhen(:)');
%�������׼T1��T2
T1 = DataBoDong(floor(length(DataBoDong)/3));
T2 = DataBoDong(floor(length(DataBoDong)/3*2));
