function [gray] = oct2gray(oct)
oct_size = size(oct);
gray = [];

for i = 1 : oct_size(1)
  suboct = oct(i);
  switch suboct
    case 1
      subgray = [0; 0; 0];
    case 2
      subgray = [0; 0; 1];
    case 3
      subgray = [0; 1; 1];
    case 4
      subgray = [0; 1; 0];
    case 5
      subgray = [1; 1; 0];
    case 6
      subgray = [1; 1; 1];
    case 7
      subgray = [1; 0; 1];
    case 8
      subgray = [1; 0; 0];
  end
  gray = [gray; subgray];
end
end

