% Informe 4
%% Hybrid Images

pepe = imresize(imread('Pepe.jpeg'),[1200,960]);
hombre = imresize(imread('Hombre.jpeg'),[1200,960]);

pepe_gauss = imgaussfilt(pepe,20);

hombre_gauss = imgaussfilt(hombre,50);

hombre_high = imsubtract(hombre,hombre_gauss);

hybrid = hombre_high+pepe_gauss;

imshow(hybrid)
imwrite(hybrid,'PEPE.jpg')

%% Blending

g = 4; %number of levels
pepe_h = pepe(:,1:480,:);
hombre_h = hombre(:,481:960,:);
blend0 = uint8(zeros(1200,960,3)); %Creates a template for the original blended image
blend0(:,1:480,:) = pepe_h;
blend0(:,481:960,:)= hombre_h;

%Creates cells to save laplacian ang gaussian levels.
laplace_pepe = cell(1,g+1)
laplace_pepe{1} = pepe_h;
laplace_hombre = cell(1,g+1);
laplace_hombre{1} = hombre_h;
gauss_pepe = cell(1,g+1);
gauss_pepe{1} = pepe_h;
gauss_hombre = cell(1,g+1);
gauss_hombre{1} = hombre_h;
figure
%Iteration were the downstream laplacian pyramid is being made.
for i =1:g
    [m,n,l] = size(pepe_h);
    pepe_ha = pepe_h;
    pepe_h = imresize(pepe_h,[m/2,n/2]);
    pepe_g = imgaussfilt(pepe_h,60);
    [s,p,t] = size(hombre_h);
    hombre_ha = hombre_h;
    hombre_h = imresize(hombre_h,[s/2,p/2]);
    hombre_g = imgaussfilt(hombre_h,60);
    
    gauss_pepe{i+1} = pepe_g;
    gauss_hombre{i+1} = hombre_g;
   
    
    pepe_gl = imresize(pepe_g,[m,n]);
    hombre_gl = imresize(hombre_g,[m,n]);
    
    pepe_lap = pepe_ha-pepe_gl;
    hombre_lap = hombre_ha-hombre_gl;
    

    
    laplace_pepe{i+1} = pepe_lap;
    laplace_hombre{i+1} = hombre_lap;
    a = cell(1,5);
    b = cell(1,5);
    a{i} = subplot(2,4,i);
    imshow(pepe_g)
    b{i} = subplot(2,4,i+4);
    imshow(pepe_lap)
    
    
end    
linkaxes([a{1},a{2},a{3},a{4},b{1},b{2},b{3},b{4}])
%Saves the first blended image (original)
blend_uplap = cell(1,g+1);
blend_og = [gauss_pepe{end},gauss_hombre{end}];
blend_uplap{1} = blend_og;

%Loop to return the specific features taken from the laplacian levels.
for j = 1:g
    pepe_uplap = laplace_pepe{end-j+1};
    pepe_upgauss = gauss_pepe{end-j+1};
    [m,n,l] = size(pepe_upgauss);
    
    pepe_upgauss = imresize(pepe_upgauss,[2*m,2*n]);
    hombre_uplap = laplace_hombre{end-j+1};
    hombre_upgauss = gauss_hombre{end-j+1};
    [s,p,t] = size(hombre_upgauss);
    hombre_upgauss = imresize(hombre_upgauss,[2*s,2*p]);
    
    blend = [pepe_upgauss,hombre_upgauss];
    blend_lap = [pepe_uplap,hombre_uplap];
    
    blended = blend+blend_lap;
    blend_uplap{j+1} = blended;
    
end


figure
imshow(blend_uplap{5})
imwrite(blend_uplap{5},'PEPE2.jpg')