function [dout] = Slide_LPF(din, reset)
% Simple sliding(FIR) low pass filter
  FIFO_DEPTH = 5;
  % Initialise
  persistent ptr;
  if isempty(ptr)
    ptr = 1;
  end
  persistent buffer;
  if isempty(buffer)
    buffer = zeros(FIFO_DEPTH, 1);
  end
  % Move data
  if reset == false
    buffer(ptr) = din;
    ptr = ptr + 1;
    if ptr == FIFO_DEPTH + 1
      ptr = 1;
    end
  else
    buffer = zeros(FIFO_DEPTH, 1);
  end
  % Return data
  dout = sum(buffer) / FIFO_DEPTH;
end

