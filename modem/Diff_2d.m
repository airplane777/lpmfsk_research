function [diff] = Diff_2d(pattern, template)

  % Calculate diff range
  assert(isequal(size(pattern), size(template)), 'Pattern and template have different size.');
  diff_range = size(template);

  diff = 0;

  for i = 1 : diff_range(1)
    for j = 1 : diff_range(2)
      % Attempt 1
      diff = diff + (pattern(i, j) - template(i, j))^2;
      % Attempt 2
      % diff = diff + pattern(i, j) * template(i, j);
    end
  end

end

