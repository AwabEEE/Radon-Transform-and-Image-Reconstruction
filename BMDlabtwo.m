img = imread('brain.jpg');
img = rgb2gray(img); % Convert to grayscale if needed
img = im2double(img); % Normalize

% Display original image
figure;
imshow(img, []);
title('Original Brain Image');

% Generate Sinogram (Forward Projection)
theta1 = 0:10:170;
[R1, xp] = radon(img, theta1);

theta2 = 0:5:175;
[R2, ~] = radon(img, theta2);

theta3 = 0:2:178;
[R3, ~] = radon(img, theta3);

% Display sinogram
figure;
imagesc(theta3, xp, R3);
colormap(hot);
colorbar;
xlabel('Parallel Rotation Angle - \theta (degrees)');
ylabel('Parallel Sensor Position - x'' (pixels)');
title('Sinogram of Brain Image');

% Reconstruction (Back Projection)
output_size = max(size(img));

dtheta1 = theta1(2) - theta1(1);
I1 = iradon(R1, dtheta1, output_size);

dtheta2 = theta2(2) - theta2(1);
I2 = iradon(R2, dtheta2, output_size);

dtheta3 = theta3(2) - theta3(1);
I3 = iradon(R3, dtheta3, output_size);

% Display Reconstruction Results
figure;
montage({I1, I2, I3}, 'Size', [1, 3]);
title(['Reconstruction from Parallel Beam Projection ' ...
    'with 18, 36, and 90 Projection Angles']);
