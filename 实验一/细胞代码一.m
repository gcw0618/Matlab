I=imread('c279977e01cd187a160b3fc554678fd.png');
figure,imshow(I);title('ԭͼ');

A=I;
A_gray=im2double(A);
A_bw=im2bw(A_gray);
figure,imshow(A_bw);title('��ֵ��');

A_reverse=~A_bw;%ȡ��

A_fill=imfill(A_reverse,'holes');
figure,imshow(A_fill);title("�׶��");

se2 = strel('disk',3);
A_imdilate=imdilate(A_fill,se2);
figure,imshow(A_imdilate);title("����");

se1 = strel('disk',4);        
A_imerode = imerode(A_imdilate,se1);
figure,imshow(A_imerode);title('��ʴ');


se2 = strel('disk',5);
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