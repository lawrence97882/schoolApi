select 
    student.name as name,
     score.value as score
from score
    inner join allocation on score.allocation=allocation.allocation
    inner join teacher on teacher.teacher= allocation.teacher
    inner join subject on teacher.subject=subject.subject
    inner join student on score.student= student.student
    inner join progress on progress.student= student.student
    inner join stage on progress.stage= stage.stage
    inner join stream on stage.stream= stream.stream
    inner join grade on stream.grade=grade.grade
    inner join school on school.school=grade.school
    inner join term on score.term= term.term
where subject.name='Mathematics'
AND school.id='kaps'
AND term.name= "TARGETER SERIES"
AND stream.name="red"
AND grade.name= "FOUR";

select student.name 
    from student 
    inner join progress on progress.student= student.student
    inner join stage on progress.stage= stage.stage
    inner join stream on stage.stream= stream.stream
    inner join grade on stream.grade=grade.grade
    inner join school on school.school=grade.school
    inner join `year` on stage.`year` = `year`.`year`
where `year`.`name` ='1'
AND school.id='kaps'
AND stream.name='red'
AND grade.name= 'FOUR';

select student.name 
    from student 
    inner join progress on progress.student= student.student
    inner join stage on progress.stage= stage.stage
    inner join stream on stage.stream= stream.stream
    inner join grade on stream.grade=grade.grade
    inner join school on school.school=grade.school
    inner join `year` on stage.`year` = `year`.`year`
where `year`.`name` ='1'
AND school.id='kaps'
AND stream.name='red'
AND grade.name= 'FOUR'
        


