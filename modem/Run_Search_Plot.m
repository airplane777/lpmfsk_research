figure;
hold on;
imagesc(wf)
for i = 1 : search_range(1)
  for j = 1 : search_range(2)
      if heatmap(i, j) <= decision_threshold
          rectangle('Position', [j, i, template_size(2), template_size(1)], 'EdgeColor', 'r')
      end
  end
end
hold off;

figure;
imagesc(1 ./ heatmap)