-- 
--Getting the raw data and perform the calculation
select 
    progress.progress,
    exam.exam, 
    subject.subject,
    --aS
    --1.Get the raw scores.    
    score.`value` as `paper_score(raw)`,
    --     
    --2.Caculate percent for individual papers
    score.`value` / sitting.out_of *100 as `paper_score(%)` ,
    -- 
    --3.Calculate the percent for multiple papers in a subject 
    avg(score.`value` / sitting.out_of *100) over(
        partition by  progress, 
        exam,
        subject
    )as `subject_score(%)`,
    --  
    --4.Caculate the overall score in an exam 
    sum(score.`value` / sitting.out_of *100) over(
            partition by  progress, 
            exam
        )as `overall_score(%)`
from score
    inner join sitting on score.sitting= sitting.sitting
    inner join subject on sitting.subject= subject.subject
    inner join exam on sitting.exam= exam.exam  
    inner join progress on score.progress= progress.progress
order by 
    progress asc,
    exam asc,
    subject asc;

select distinct
    subject.`name`, sitting.out_of
from sitting
    inner join subject on sitting.subject= subject.subject