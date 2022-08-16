--
--
--The overall subject has no parent. 
create or replace view overall as 
    select 
        --The primary key  
        overall.subject as overall,
         --       
        --For debuging purposes
        overall.name
    from subject as overall 
    where overall.child_of is null;

-- 
-- 
-- The view for the topic subject 
-- All topics are children of an overall 
create or replace view topic as 
    select 
        -- the primary key
        topic.subject as topic,
        -- 
        -- The topic name (for debuging)
        topic.name,
        --
        --The overall foreign key 
       overall.overall
    from subject as topic 
        inner join overall on overall.overall=topic.child_of;  ;
--
-- 
-- The view for the papers for which there is an exam sitting
--A paper is a subject that has no children
create or replace view paper as
    select 
        --THe primary key 
        paper.subject as paper,
        --
        --The friendly name (for debuging)
        paper.name,
        --
        --The forein  key for which this paper is a child of
        --If the parent of a paper is overall then its topic is itsself otherwise 
        --the parent is the topic.
        if(paper.child_of = overall.overall, paper.subject, paper.child_of) as topic
    from subject as paper
        --
        --Bring in the overall component 
        left join overall on paper.child_of = overall.overall
        --
        --We are left joining to an mazazi query i.e., a subject with children   
       left join (
            select 
                subject.child_of as mzazi
            from subject 
            group by subject.child_of
        )as mzazi on mzazi.mzazi= paper.subject
        --
        -- A paper is a subject that has NO children
    where mzazi.mzazi is null;
        

--
-- This view calculates the percent for each topic and keeps track of the papers 
-- that constituted thar percent
create or replace view test as 
    select 

        --Calculate percentages
        -- Get the sum of the individual score per subject.
        (sum(score.`value`)/ sum(sitting.out_of) *100)as percent,
        --
        -- 
        --Track the papers that constitute the calculated percent 
        json_objectagg(paper.name, score.value) as papers,
        --
        -- THe foreign keys that defines these 
        -- subject 
        paper.topic,
        -- 
        -- progress
        score.progress,
        -- 
        -- exam
        sitting.exam
      -- 
     from score
        inner join sitting on sitting.sitting= score.sitting
        inner join allocation on allocation.allocation = sitting.allocation
        inner join teacher on teacher.teacher = allocation.teacher 
        inner join subject on subject.subject = teacher.subject
        inner join paper on  paper.paper=subject.subject
  --
  --A test is identified bya a topic progress and exam.      
  group by paper.topic, score.progress, sitting.exam;
 
-- 
-- 
-- The performance is expressed as a sum of all the test percentages
create or replace view performance as
    select 
        --
        --Sum  all the percentages of a test
        sum(test.percent) as overall,
        --
        --Trsck the test percentages thet contribute to this overall
        json_objectagg(test.topic,json_object(
            'papers',test.papers,
            'percent',test.percent
        )) as tests,
        --         
        --The foreign key fields 
        test.exam, 
        test.progress
    from test
    group by test.exam, test.progress;
-- 
-- 


--
--The final results in the none editable mode driven by the performace view
create or replace view result as 
    select
        --
        --The indexers 
        school.id as school,
        grade.`name` as grade,
        stream.`name` as stream,
        `year`.`value` as `year`,
        term.name as term,
        exam.`name` as exam,
        student.`name` as student,
        --
        --the tests
        performance.tests,
        --
        --Overall
        performance.overall
    from performance
        --
        --TO support the building of progress indexers
        inner join progress on progress.progress= performance.progress
        inner join stage on stage.stage= progress.stage
        inner join stream on stream.stream = stage.stream
        inner join grade on grade.grade = stream.grade
        inner join school on school.school= grade.school
        inner join student on student.student= progress.student
         --
         --To support the building of exam indexers
         inner join exam on exam.exam = performance.exam
         inner join term on term.term = exam.term
         --
         --The year support both the progress and the exam indexers.
         inner join year on year.year = stage.year 
                and year.year= term.year



-- The final result in the editable mode
    -- 
    --Work out the indexers 


--The final result as blank work sheet for a new exam.
    --
    --Work out the backbone


--
--Collect the metadata for expanding the tests column 
create or replace view test_meta as 
    select 
        paper.topic as test_meta,
        -- {kiswahili:insha, kiswa}
        json_arrayagg(paper.topic,paper.`name`) as metadata,
        -- 
        --name of this topic 
        topic.`name`        
    from paper
    group by paper.topic;


    
