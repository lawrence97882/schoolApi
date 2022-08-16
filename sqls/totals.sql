-- select the distinct subjects
select subject.`name` from subject;
-- 
-- 
-- 
-- Get the papers done in english 
select paper.`name` from paper
 inner join subject on subject.subject= paper.subject
 where subject.`name`='English';
-- 
-- 
-- Get the values of all the papers in english
select score.`value`, paper.`name` from paper 
 inner join sitting on sitting.paper=paper.paper
 inner join score on sitting.sitting= score.sitting
 inner join subject on subject.subject= paper.subject
 where subject.`name` = 'english';

select * from score
