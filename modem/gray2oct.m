function [oct] = gray2oct(gray)
gray_size = size(gray);
oct = [];

for i = 1 : gray_size(1) / 3
  subgray = gray(3 * (i - 1) + 1 : 3 * (i - 1) + 3);
  if isequal(subgray, [0; 0; 0])
    suboct = 1;
  elseif isequal(subgray, [0; 0; 1])
    suboct = 2;
  elseif isequal(subgray, [0; 1; 1])
    suboct = 3;
  elseif isequal(subgray, [0; 1; 0])
    suboct = 4;
  elseif isequal(subgray, [1; 1; 0])
    suboct = 5;
  elseif isequal(subgray, [1; 1; 1])
    suboct = 6;
  elseif isequal(subgray, [1; 0; 1])
    suboct = 7;
  elseif isequal(subgray, [1; 0; 0])
    suboct = 8;
  end
  oct = [oct; suboct];
end
end

