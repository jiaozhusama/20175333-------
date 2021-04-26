Img = imread('TEST/lena512.bmp');
if size(Img,3)==3
    Img = rgb2gray(Img);
end

figure;
imshow(Img);title('im original');

M = uint8(Img);
[m,n] = size(M);
%以高四位构造灰度图像
Mgray = bitand(M,240);

data = uint8('designed by caoyakun bjdzkjxy   ');
data = de2bi(data,8);
data = reshape(data,[1, size(data,1)*8]);
%space = mod(m*n,size(data,2));   

%计算出分块标准
[T1,T2,BoDongJuZhen] = StandardCalculation(Mgray,data);


%M_enc = ImageDecryption(M,"clemente");
M_enc = ImageDecryption(M,"kali");
 

%kh = "hiding";
kh = "hide";

M_hide = DataEmbedding(data, M_enc, kh, T1, T2, BoDongJuZhen);

figure;

imshow(M_hide);title('im hide');


imwrite(M_hide,"lena_hide.bmp");

%%%FINE CIFRATURA E HIDING
Img2 = imread('lena_hide.bmp');
if size(Img2,3)==3
    Img2 = rgb2gray(Img2);
end

%M_dec = ImageDecryption(Img2, "clemente");
M_dec = ImageDecryption(Img2, "kali");

figure;

imshow(M_dec);title('im dec');

[M_src, secret] = DataExtraction(M_dec,kh,256,T1, T2, BoDongJuZhen);
secret1 = reshape(secret,[32 8]);
secret2 = bi2de(secret1);
secret3 = char(secret2)';
disp(secret3);
figure;

imshow(M_src);title('im src');

