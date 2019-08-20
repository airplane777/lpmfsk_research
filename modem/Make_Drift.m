function [wfd] = Make_Drift(wf, a, w, k)
% Drift params A * sin(W * x) + K * x
  wf_size      = size(wf);
  x            = 1 : wf_size(2);
  drift_vector = round(a * sin(w * x) + k * x);
  for i = 1 : wf_size(2)
    wfd(:, i) = circshift(wf(:, i), drift_vector(i));
  end
end
