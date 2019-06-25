function [result] = Constrain(org, low, high)
% Constrain array into range
  if org < low
    result = low;
  else if org > high
         result = high;
       else
         result = org;
       end
  end

end

