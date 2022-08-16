select count(su.name) from (
select
    student.name as name,
    score.value as value,
    score.`score` as score
 from student
    inner join score on score.student= student.student
    inner join allocation on score.allocation=allocation.allocation
    inner join teacher on teacher.teacher= allocation.teacher
    inner join subject on teacher.subject=subject.subject) as su;

select count(1) from student;
