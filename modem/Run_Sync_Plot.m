aligned_plot_size = 4;

figure;
for i = 1 : aligned_plot_size ^ 2
  subplot(aligned_plot_size, aligned_plot_size, i);
  imagesc(pwr2db(accepted_frame(:, :, i)));
end
