function [vr,ee,validity] = eig2x2(m11,m21,m12,m22)
%eig2x2 computes eigenbasis decomposition of 2x2 matrices, hermitian or
%not. Cannot deal with generalized eigenvalue problems.
% function [vr,ee,validity] = eig2x2(m11,m21,m12,m22)
% function [vr,ee,validity] = eig2x2(mat2x2)
%
% Input form 1: arrays of entries, m11,m21,m12,m22
% Input form 2: arrays of matrices, mat2x2
%   size(mat2x2,1)==4 || all(size(mat2x2,[1 2])==[2 2]))
%
% ee are the two eigenvalues. all(size(ee)==[2 size(m11)])
% vr are the ratios of the eigenvector entries, for each eigenvalue,
% v2/v1 for v=[v1;v2]. all(size(vr)==[2 size(m11)])
% validity tests if there are generalized eigenvalues. True means normal
% problem.

if nargin == 1
  if size(m11,1)==4
    a0 = (m11(1,:)+m11(4,:))/2;
    a1 = (m11(2,:)+m11(3,:))/2;
    a2 = (m11(2,:)-m11(3,:))/2;
    a3 = (m11(1,:)-m11(4,:))/2;

    os = size(m11);
    os = os(2:end);
  elseif all(size(m11,[1 2])==[2 2])
    a0 = (m11(1,1,:)+m11(2,2,:))/2;
    a1 = (m11(2,1,:)+m11(1,2,:))/2;
    a2 = (m11(2,1,:)-m11(1,2,:))/2;
    a3 = (m11(1,1,:)-m11(2,2,:))/2;

    os = size(m11);
    os = os(3:end);
  else
    error('eig2x2: wrong usage.')
  end
  if length(os)>1
    doreshape=true;
  else
    doreshape=false;
  end
elseif nargin == 4
  a0 = (m11+m22)/2;
  a1 = (m12+m21)/2;
  a2 = (m21-m12)/2;
  a3 = (m11-m22)/2;
  doreshape=false;
else
  error('eig2x2: wrong usage.')
end


de = sqrt(a1.^2+a3.^2-a2.^2); % half difference between eigenvalues
ee1 = a0-de; ee2 = a0+de;
ee = cat(1,shiftdim(ee1,-1),shiftdim(ee2,-1));

% generalized eigenvalues will have same eigenvalues (de==0)
% but M-a0*1 ~= [0 0; 0 0]
zeroq=@(x) abs(x)<1e-6;
validity = ~(zeroq(de)) | (zeroq(a1) & zeroq(a2) & zeroq(a3));

% vr is v2/v1;
vr1 = if_then_else(a1==a2,if_then_else(a1==-a2,0,(a1+a2)./(a3-de)),(a3+de)./(a2-a1));
vr2 = if_then_else(a1==a2,if_then_else(a1==-a2,inf,(a1+a2)./(a3+de)),(a3-de)./(a2-a1));

vr = cat(1,shiftdim(vr1,-1),shiftdim(vr2,-1));

if doreshape
  vr=reshape(vr,[2 os]);
  ee=reshape(ee,[2 os]);
  validity=reshape(validity,os);
end

end


function test_eig2x2

for ii = 1:100
  m=rand(2,2)+1i*rand(2,2); m=m+m';
  [vr,ee,validity] = eig2x2(m);
  [v,d]=eig(m,'vector');
  [d,id]=sort(d);
  v=v(:,id);
  disp(vr-(v(2,:)./v(1,:)).')
  disp(ee-d)
end

end
