function [conv_out] = Conv(conv_in)
  % Parameters
  constraint	= 3;
  r		= 2;

  parity_coeffs = [1 1 1;
		   0 1 1]; % Coefficients of parity functions(rows)

  conv_in_size = size(conv_in);
  assert(conv_in_size(1) == 1, 'Message is not a row vector.');

  % Malloc
  conv_out = zeros(r, conv_in_size(2) - constraint + 1);

  for j = 1 : conv_in_size(2) - constraint + 1 % For each window
    for i = 1 : r % For each output bit
      conv_out(i, j) = mod(sum(sum( ...
				 bitand(parity_coeffs(i, :), conv_in(j : j + constraint - 1)) ...
				  )), 2);
    end
  end
  
end
