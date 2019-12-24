%I = imread('c7a5af608ae3df0931407a7ac3395d5.png');
%I=imread('476c18f3c41d672602b8d15e1cd49a9.png');
I=imread('c279977e01cd187a160b3fc554678fd.png');
figure,imshow(I);title('原图');

%A=I(:,:,3);
A=I;
A_gray=im2double(A);
%level=graythresh(A_gray);
%A_bw=im2bw(A_gray,level);%二值化
A_bw=im2bw(A_gray);
figure,imshow(A_bw);title('绿色通道');

A_reverse=~A_bw;%取反

se1 = strel('disk',4);        
A_imerode = imerode(A_reverse,se1);
figure,imshow(A_imerode);title('腐蚀');


se2 = strel('disk',8);
A_imopen=imopen(A_imerode,se2);
figure,imshow(A_imopen);title("开运算");


D=-bwdist(~A_imopen);
mask=imextendedmin(D,2);
D2=imimposemin(D,mask);
Ld=watershed(D2);

Water_splited=A_imopen;
Water_splited(Ld==0)=0;

A_fenshui=Water_splited;
figure,imshow(A_fenshui);title('分水岭');

[Label,Number]=bwlabel(A_fenshui,8);
Number