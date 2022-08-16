select 
    group_concat(score.value separator "/" )as scores
from score 
  group by score.exam, score.student