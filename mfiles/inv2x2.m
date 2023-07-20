function [minv,mdet] = inv2x2(m11,m21,m12,m22)
%inv2x2 computes inverse of 2x2 matrices, using Cramer's rules.
% function [minv,mdet] = inv2x2(m11,m21,m12,m22)
% function [minv,mdet] = inv2x2(mat2x2)
%
% Input form 1: arrays of entries, m11,m21,m12,m22
% Input form 2: arrays of matrices, mat2x2
%   size(mat2x2,1)==4 || all(size(mat2x2,[1 2])==[2 2]))
%
% minv are the inverse matrix. all(size(ee)==[2 size(m11)])
% mdet is the determinant of original matrix.

if nargin == 1
  if size(m11,1)==4
    dt=m11(1,:).*m11(4,:)-m11(2,:).*m11(3,:);
    minv(:,:)=m11([4 2 3 1],:)./dt.*[1 -1 -1 1]';
    minv = reshape(minv,size(m11));

    if nargout > 1
      mdet=dt;
    end
  elseif all(size(m11,[1 2])==[2 2])
    os=size(m11);

    if nargout > 1
      [minv,mdet] = inv2x2(m11(1,1,:),m11(2,1,:),m11(1,2,:),m11(2,2,:));
    else
      [minv,~] = inv2x2(m11(1,1,:),m11(2,1,:),m11(1,2,:),m11(2,2,:));
    end
    minv=reshape(minv,os);
    
  else
    error('inv2x2: wrong usage.')
  end

elseif nargin == 4
  dt = m11.*m22-m12.*m21;
  s=@(x) shiftdim(x,-1);
  minv = cat(1, s(m22), -s(m21), -s(m12), s(m11))./s(dt);
  if nargout > 1
    mdet=dt;
  end
else
  error('inv2x2: wrong usage.')
end

end

