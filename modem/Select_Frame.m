% Select manually from original waterfall
 
% testbox_position = [265 1097];
% 
% testbox = wfp(testbox_position(1) : testbox_position(1) + cell_size(1), ...
%   testbox_position(2) : testbox_position(2) + cell_size(2));

% Or select one from synchronised frames

testbox = accepted_frame(:, :, 1);