function [errors] = Count_Errors(source, target)
source_size = size(source);
target_size = size(target);
errors = zeros(1, target_size(2));

for j = 1 : target_size(2)
  for i = 1 : source_size(1)
    if source(i) ~= target(i, j)
      errors(j) = errors(j) + 1;
    end
  end
end

end

