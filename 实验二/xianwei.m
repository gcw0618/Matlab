%I=imread('c868115c2f25215be1143290357c808.png');
%I=imread('d926fddbff76ffe9b37ca12e79cb7e0.png');
I=imread('f778dab917425b197ab09adce551887.png');
figure,imshow(I);title('ԭʼͼ��');

A_gray=rgb2gray(I);%��ɫͼ��ҶȻ�


sigma = 2;
gausFilter = fspecial('gaussian', [50,50], sigma);
A_gaus1= imfilter(A_gray, gausFilter, 'replicate');%  ��˹�˲�
figure,imshow(A_gaus1);title('��˹�˲����ͼ��');


A_BW1=edge(A_gaus1,'Canny',0.4,2);%edge���� CannyΪ��������б���ֵΪ1.5
figure,imshow(A_BW1);title('��ֵΪ0.4, sigmaֵΪ2�� Canny���ӱ�Ե���ͼ��');%canny ���ӱ�Ե���

% Hough�任���ֱ�߳���
[H,T,R]=hough(A_BW1);  %��ͼ����� Hough�任 HΪHough�任����thetaΪ�任������rhoΪԪ�ظ���

P =houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));%Houghpeaks������������ȡHough�任�����ƽ���ϵķ�ֵ�㡣

max_len=0;      
for k=1:length(lines)
	xy=[lines(k).point1;lines(k).point2];
	plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');
	%���ֱ�߱�Ե��Ӧ�����	
	plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
	plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
	%����ֱ�߱�Ե����
	len=norm(lines(k).point1-lines(k).point2);	
	if(len>max_len)
		max_len=len;
		xy_long=xy;
	end
end
disp(max_len);
