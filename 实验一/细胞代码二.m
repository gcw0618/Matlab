%I = imread('c7a5af608ae3df0931407a7ac3395d5.png');
%I=imread('476c18f3c41d672602b8d15e1cd49a9.png');
I=imread('c279977e01cd187a160b3fc554678fd.png');
figure,imshow(I);title('ԭͼ');

%A=I(:,:,3);
A=I;
A_gray=im2double(A);
%level=graythresh(A_gray);
%A_bw=im2bw(A_gray,level);%��ֵ��
A_bw=im2bw(A_gray);
figure,imshow(A_bw);title('��ɫͨ��');

A_reverse=~A_bw;%ȡ��

se1 = strel('disk',4);        
A_imerode = imerode(A_reverse,se1);
figure,imshow(A_imerode);title('��ʴ');


se2 = strel('disk',8);
A_imopen=imopen(A_imerode,se2);
figure,imshow(A_imopen);title("������");


D=-bwdist(~A_imopen);
mask=imextendedmin(D,2);
D2=imimposemin(D,mask);
Ld=watershed(D2);

Water_splited=A_imopen;
Water_splited(Ld==0)=0;

A_fenshui=Water_splited;
figure,imshow(A_fenshui);title('��ˮ��');

[Label,Number]=bwlabel(A_fenshui,8);
Number