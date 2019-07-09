function [int] = Int_2D(box)
  int = sum(sum(box,1),2);
%   box_size = size(box);
%   int = 0;
%   for i = 1 : box_size(1)
%     for j = 1 : box_size(2)
%       int = int + box(i, j);
%     end
%   end
end

