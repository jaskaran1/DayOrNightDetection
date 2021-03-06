folder1='./day';
folder2='./night';
names=getImageSet(folder1);
%Loop for displaying the images with their histograms and classifying them
%as day/night
%Marking the threshhold as 50
%ie if more than 75% of pixels are under 50 in all r,g and b
%Then its night else its day.
%days=ones(1,23);
%nights=zeros(1,23);
%actual=[days nights]';
labels1=[];
labels2=[];
labels3=[];
actual=ones(size(names))';%labelled day images
%Method1-Threshholding of intensity values in the histogram
for i=1:length(names)
im=imread(names{i});
% names{i}
% size(im)
red=im(:,:,1);
green=im(:,:,2);
blue=im(:,:,3);
% figure;
% subplot(4,1,1);
% imshow(im);
% title(names{i});
% subplot(4,1,2);
% imhist(red);%To plot the histogram
% title('RedHist');
% subplot(4,1,3);
% imhist(green);
% title('GreenHist');
% subplot(4,1,4);
% imhist(blue);
% title('BlueHist');
[countred,Xred]=imhist(red);
[countgreen,Xgreen]=imhist(green);
[countblue,Xblue]=imhist(blue);
%Select threshhold for classification
threshhold=50;
redpercent=(sum(countred(1:threshhold))/sum(countred))*100;
greenpercent=(sum(countgreen(1:threshhold))/sum(countgreen))*100;
bluepercent=(sum(countblue(1:threshhold))/sum(countblue))*100;
if redpercent<42 && greenpercent<42 && bluepercent<42
    labels1=[labels1;1];%day
else
    labels1=[labels1;0];%night
end
end
for i=1:length(names)
if labels1(i)==0
    names(i)
    fprintf('is night\n');
else
    names(i)
    fprintf('is day\n');
end
end
fprintf('Classification accuracy for day images by Method-1: %f\n',mean(double(labels1==actual))*100);
%Method2-Mean method gives an accuracy of 50%
%Probably due to the fact that the mean is oblivious to the distribution of
%the intensities
for i=1:length(names)
im=imread(names{i});
red=im(:,:,1);
green=im(:,:,2);
blue=im(:,:,3);
% figure;
% subplot(4,1,1);
% imshow(im);
% title(names{i});
% subplot(4,1,2);
% imhist(red);%To plot the histogram
% title('RedHist');
% subplot(4,1,3);
% imhist(green);
% title('GreenHist');
% subplot(4,1,4);
% imhist(blue);
% title('BlueHist');
%[countred,Xred]=imhist(red);
%[countgreen,Xgreen]=imhist(green);
%[countblue,Xblue]=imhist(blue);
average=(red+green+blue)/3;
average=average(:);
meanval=mean(average);
%Calculate the mean of red
%Calculate the mean of green
%Calculate the mean of blue
threshhold=50;%threshhold for the mean
if meanval>=threshhold
    labels2=[labels2;1];%day
else
    labels2=[labels2;0];%night
end
end
for i=1:length(names)
if labels2(i)==0
    names(i)
    fprintf('is night\n');
else
    names(i)
    fprintf('is day\n');
end
end
fprintf('Classification accuracy of day images by Method-2: %f\n',mean(double(labels2==actual))*100);
%Method3-Take Mean and variance.
%labels=[];
for i=1:length(names)
im=imread(names{i});
red=im(:,:,1);
green=im(:,:,2);
blue=im(:,:,3);
% figure;
% subplot(4,1,1);
% imshow(im);
% title(names{i});
% subplot(4,1,2);
% imhist(red);%To plot the histogram
% title('RedHist');
% subplot(4,1,3);
% imhist(green);
% title('GreenHist');
% subplot(4,1,4);
% imhist(blue);
% title('BlueHist');
[countred,Xred]=imhist(red);
[countgreen,Xgreen]=imhist(green);
[countblue,Xblue]=imhist(blue);
%Select threshhold for classification
threshhold=100;
%names{i};
redmean=sum(countred.*Xred)/sum(countred);
greenmean=sum(countgreen.*Xgreen)/sum(countgreen);
bluemean=sum(countblue.*Xblue)/sum(countblue);
redsd=sqrt(sum(countred.*(Xred-redmean).^2)/sum(countred));
greensd=sqrt(sum(countgreen.*(Xgreen-greenmean).^2)/sum(countgreen));
bluesd=sqrt(sum(countblue.*(Xblue-bluemean).^2)/sum(countblue));
%if redmean>threshhold && greenmean>threshhold && bluemean>threshhold
%if redmean+greenmean+bluemean>200% 75% accuracy
if (redmean+greenmean+bluemean)/3>100
labels3=[labels3;1];%day
else
    labels3=[labels3;0];%night
end
end
for i=1:length(names)
if labels3(i)==0
    names(i)
    fprintf('is night\n');
else
    names(i)
    fprintf('is day\n');
end
end
fprintf('Classification accuracy on day images by Method-3: %f\n',mean(double(labels3==actual))*100);
%Classification of Day images
%finish--------------------------------------------
labels4=[];
for i=1:length(names)
if labels1(i)+labels2(i)+labels3(i)>=2
    names(i)
    fprintf('is day\n');
    labels4(i)=1;
else
    names(i)
    labels4(i)=0;
    fprintf('is night\n');
end
end
fprintf('Classification accuracy of the day images by a Majority vote method %f\n',mean(double(labels4'==actual))*100);
%Classification of Night images start
names=getImageSet(folder2);
%Loop for displaying the images with their histograms and classifying them
%as day/night
%Marking the threshhold as 50
%ie if more than 75% of pixels are under 50 in all r,g and b
%Then its night else its day.
actual=zeros(size(names))';%labelled night images
labels1=[];
labels2=[];
labels3=[];
%Method1-Simple Threshholding
for i=1:length(names)
im=imread(names{i});
% names{i}
% size(im)
red=im(:,:,1);
green=im(:,:,2);
blue=im(:,:,3);
% figure;
% subplot(4,1,1);
% imshow(im);
% title(names{i});
% subplot(4,1,2);
% imhist(red);%To plot the histogram
% title('RedHist');
% subplot(4,1,3);
% imhist(green);
% title('GreenHist');
% subplot(4,1,4);
% imhist(blue);
% title('BlueHist');
[countred,Xred]=imhist(red);
[countgreen,Xgreen]=imhist(green);
[countblue,Xblue]=imhist(blue);
%Select threshhold for classification
threshhold=50;
redpercent=(sum(countred(1:threshhold))/sum(countred))*100;
greenpercent=(sum(countgreen(1:threshhold))/sum(countgreen))*100;
bluepercent=(sum(countblue(1:threshhold))/sum(countblue))*100;
if redpercent<42 && greenpercent<42 && bluepercent<42
    labels1=[labels1;1];%day
else
    labels1=[labels1;0];%night
end
end
for i=1:length(names)
if labels1(i)==0
    names(i)
    fprintf('is night\n');
else
    names(i)
    fprintf('is day\n');
end
end
fprintf('Classification accuracy for night images by Method-1: %f\n',mean(double(labels1==actual))*100);
%Method2-Mean method gives an accuracy of 50%
%Probably due to the fact that the mean is oblivious to the distribution of
%the intensities
labels=[];
for i=1:length(names)
im=imread(names{i});
red=im(:,:,1);
green=im(:,:,2);
blue=im(:,:,3);
% figure;
% subplot(4,1,1);
% imshow(im);
% title(names{i});
% subplot(4,1,2);
% imhist(red);%To plot the histogram
% title('RedHist');
% subplot(4,1,3);
% imhist(green);
% title('GreenHist');
% subplot(4,1,4);
% imhist(blue);
% title('BlueHist');
%[countred,Xred]=imhist(red);
%[countgreen,Xgreen]=imhist(green);
%[countblue,Xblue]=imhist(blue);
average=(red+green+blue)/3;
average=average(:);
meanval=mean(average);
%Calculate the mean of red
%Calculate the mean of green
%Calculate the mean of blue
threshhold=50;%threshhold for the mean
if meanval>=threshhold
    labels2=[labels2;1];%day
else
    labels2=[labels2;0];%night
end
end
for i=1:length(names)
if labels2(i)==0
    names(i)
    fprintf('is night\n');
else
    names(i)
    fprintf('is day\n');
end
end
fprintf('Classification accuracy of night images by Method-2: %f\n',mean(double(labels2==actual))*100);
%Method3-Take Mean and variance of each color in the image
%seperately and use threshholding there.
%As the variance increases decisions are less accurate.
for i=1:length(names)
im=imread(names{i});
red=im(:,:,1);
green=im(:,:,2);
blue=im(:,:,3);
% figure;
% subplot(4,1,1);
% imshow(im);
% title(names{i});
% subplot(4,1,2);
% imhist(red);%To plot the histogram
% title('RedHist');
% subplot(4,1,3);
% imhist(green);
% title('GreenHist');
% subplot(4,1,4);
% imhist(blue);
% title('BlueHist');
[countred,Xred]=imhist(red);
[countgreen,Xgreen]=imhist(green);
[countblue,Xblue]=imhist(blue);
%Select threshhold for classification
threshhold=100;
%names{i}
redmean=sum(countred.*Xred)/sum(countred);
greenmean=sum(countgreen.*Xgreen)/sum(countgreen);
bluemean=sum(countblue.*Xblue)/sum(countblue);
redsd=sqrt(sum(countred.*(Xred-redmean).^2)/sum(countred));
greensd=sqrt(sum(countgreen.*(Xgreen-greenmean).^2)/sum(countgreen));
bluesd=sqrt(sum(countblue.*(Xblue-bluemean).^2)/sum(countblue));
%if redmean>threshhold && greenmean>threshhold && bluemean>threshhold
%if redmean+greenmean+bluemean>200% 75% accuracy
if (redmean+greenmean+bluemean)/3>100
labels3=[labels3;1];%day
else
    labels3=[labels3;0];%night
end
end
for i=1:length(names)
if labels3(i)==0
    names(i)
    fprintf('is night\n');
else
    names(i)
    fprintf('is day\n');
end
end
fprintf('Classification accuracy on night images by Method-3: %f\n',mean(double(labels3==actual))*100);
%finish--------------------------------------------
labels4=[];
for i=1:length(names)
if labels1(i)+labels2(i)+labels3(i)>=2
    names(i)
    fprintf('is day\n');
    labels4(i)=1;
else
    names(i)
    labels4(i)=0;
    fprintf('is night\n');
end
end
fprintf('Classification accuracy of the night images by a Majority vote method %f\n',mean(double(labels4'==actual))*100);

