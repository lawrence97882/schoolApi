select 
    subject.name as name
from subject
    inner join teacher on teacher.subject=subject.subject
    inner join allocation on allocation.teacher=teacher.teacher
    inner join stage on allocation.stage= stage.stage
    inner join stream on stage.stream= stream.stream
    inner join grade on stream.grade=grade.grade
    inner join school on school.school=grade.school
where school.id='kaps'
AND stream.name='red'
AND grade.name= 'FOUR';
