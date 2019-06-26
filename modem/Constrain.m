function [result] = Constrain(val, low, high)
% Constrain array into range
  if val < low
    result = low;
  else
    if val > high
      result = high;
    else
      result = val;
    end
  end

end

