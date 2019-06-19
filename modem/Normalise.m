function [img] = Normalise(mat)
% Normalise a matrix into range 0, 1

limits = [min(mat(:)) max(mat(:))];
delta  = limits(2) - limits(1);

if(limits(1) ~= limits(2))
    img = (mat - limits(1)) ./ delta;
else
    img = zeros(size(mat));
end

end

