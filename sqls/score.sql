select 
    student.name as name,
     0 as value ,
     year.`value`
from student  
    inner join progress on progress.student= student.student  
    inner join stage on progress.stage= stage.stage  
    inner join stream on stage.stream= stream.stream 
    inner join grade on stream.grade=grade.grade
    inner join school on school.school=grade.school  
    inner join `year` on stage.`year` = `year`.`year`  
 where school.id='kaps' 
 AND stream.name='red' 
 AND grade.name= 'four'