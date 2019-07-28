ntestsyn     = 40;
sync_pattern = SYNC_PATTERN;
pers_result  = zeros(1, ntestsyn);

parfor i = 1 : ntestsyn
  pers_result(i) = SS_GA_Loss(sync_pattern);
  fprintf("Epoch %d :\t %f\n", i, pers_result(i));
end

plot(pers_result, '.');