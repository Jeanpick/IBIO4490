
clc
clear all;
close all;

%Author: Julio Nicolás Reyes Torres


%Imagen 1
im1 = imread('Delorian.jpg');
%figure, imshow(im1);

% im3 = fft2(im1);
% im3 = rgb2gray(im1); 
% im4 = im2uint8(im3);
% figure, imshow(im3);

%Aplicamos un filtro pasabajos a imagen 1
%H1 = fspecial('gaussian',70,40);%Filtro 2D predefinido
%fim4 = imfilter(im1,H1,'replicate');
fim1 = imgaussfilt(im1, 40);

imshow(fim1) 

%%
%Imagen 2
im2 = imread('Dominic.jpg');
im2r = imrotate(im2,3,'crop');
im2t = imtranslate(im2r,[500, 100]);
%Aplicamos un filtro pasaltos a imagen 2
H2 = fspecial('gaussian',90,100);%Filtro 2D predefinido
%fim2 = im2t - imfilter(im2t,H2,'replicate');
fim2 = imgaussfilt(im2t, 40);
fim2 = im2t - fim2;
imshow(fim2)
%%
%Imagen Híbrida

imhibrida = fim1 + fim2;

% subplot(3,1,1) 
% imshow(fim1) 
% subplot(3,1,2) 
% imshow(fim2) 
% subplot(3,1,3) 
figure, imshow(imhibrida) 