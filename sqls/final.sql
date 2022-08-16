-- 
-- SCORE_EXT: The sql that extends the score entity with a percentage 
create or replace view score_ext as select 
    progress,
    score.sitting,    
    value / sitting.out_of *100 as percent 
from score
 inner join sitting on score.sitting= sitting.sitting;
-- 
-- 
-- TOTAL: the view that contains the subject totals for multiple 
-- sittings.
create or replace view total as select 
    score_ext.progress,
    sitting.exam,
    subject0.subject,
    -- 
    --Calculate the percent for multiple papers in a subject 
    avg(score_ext.percent) as percent
    --     
    -- 
from score_ext
    inner join sitting on score_ext.sitting= sitting.sitting
    inner join subject as subject0 on sitting.subject= subject0.subject
    inner join subject as subject1 on subject1.paper=subject0.subject
 group by
    subject,
    exam,
    progress;

-- 
-- 
-- The overall score of the subjects
select 
    progress.progress,
    exam.exam, 
    subject.subject,
    -- 
    --Calculate the percent for multiple papers in a subject 
   sum(score.`value` / sitting.out_of *100) as overall
    --     
    -- 
from score
    inner join sitting on score.sitting= sitting.sitting
    inner join subject on sitting.subject= subject.subject
    inner join exam on sitting.exam= exam.exam  
    inner join progress on score.progress= progress.progress
group by
    progress;

