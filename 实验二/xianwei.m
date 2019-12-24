%I=imread('c868115c2f25215be1143290357c808.png');
%I=imread('d926fddbff76ffe9b37ca12e79cb7e0.png');
I=imread('f778dab917425b197ab09adce551887.png');
figure,imshow(I);title('原始图像');

A_gray=rgb2gray(I);%彩色图像灰度化


sigma = 2;
gausFilter = fspecial('gaussian', [50,50], sigma);
A_gaus1= imfilter(A_gray, gausFilter, 'replicate');%  高斯滤波
figure,imshow(A_gaus1);title('高斯滤波后的图像');


A_BW1=edge(A_gaus1,'Canny',0.4,2);%edge调用 Canny为检测算子判别阈值为1.5
figure,imshow(A_BW1);title('阈值为0.4, sigma值为2的 Canny算子边缘检测图像');%canny 算子边缘检测

% Hough变换检测直线程序
[H,T,R]=hough(A_BW1);  %对图像进行 Hough变换 H为Hough变换矩阵，theta为变换轴间隔，rho为元素个数

P =houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));%Houghpeaks函数是用来提取Hough变换后参数平面上的峰值点。

max_len=0;      
for k=1:length(lines)
	xy=[lines(k).point1;lines(k).point2];
	plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
	%标记直线边缘对应的起点	
	plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
	plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
	%计算直线边缘长度
	len=norm(lines(k).point1-lines(k).point2);	
	if(len>max_len)
		max_len=len;
		xy_long=xy;
	end
end
disp(max_len);
