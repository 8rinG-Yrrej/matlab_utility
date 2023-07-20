% function v = fftconv2(x,y,kind1,kind2)
% Compute 1D convolution with fft2. kind = 'same' or 'valid', or otherwise
% regarded as 'full'.
function v = fftconv2(x,y,kind)
% arguments
%     x (:,:)
%     y (:,:)
%     kind (1,1) string = 'full'
% end
[l1,l2] = size(x);
[m1,m2] = size(y);

v = ifft2(fft2(x,l1+m1-1,l2+m2-1).*fft2(y,l1+m1-1,l2+m2-1));

if nargin == 2 || strcmp(kind,'full')
    return
elseif strcmp(kind,'same')
    v = v(1+floor(m1/2):floor(m1/2)+l1,1+floor(m2/2):floor(m2/2)+l2);
elseif strcmp(kind,'valid')
    v = v(m1:end-m1+1,m2:end-m2+1);
end

end
