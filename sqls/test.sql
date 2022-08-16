SELECT 
    concat('[', `general_school`.`score`.`score` , ',', '"', concat(IFNULL(`general_school`.`student`.`admno` , '.'), '/', IFNULL(`general_school`.`student`.`name` , '.')), '"', ']') as `score`,
    `general_school`.`score`.`value` as `value`,
    `general_school`.`score`.`date` as `date`,
    concat('[', `general_school`.`score`.`term` , ',', '"', concat(`general_school`.`term`.`name` , `general_school`.`term`.`start_date` ), '"', ']') as `term`,
    concat('[', `general_school`.`score`.`allocation` , ',', '"', concat(`general_school`.`school`.`id` , `general_school`.`subject`.`id` ), '"', ']') as `allocation`,
    concat('[', `general_school`.`score`.`student` , ',', '"', concat(`general_school`.`student`.`admno` , `general_school`.`student`.`name` ), '"', ']') as `student` 
FROM 
    `general_school`.`score` 
    inner join `general_school`.`term` ON `general_school`.`score`.`term` = `general_school`.`term`.`term` 
    inner join `general_school`.`year` ON `general_school`.`term`.`year` = `general_school`.`year`.`year` 
        AND `general_school`.`stage`.`year` = `general_school`.`year`.`year`
    inner join `general_school`.`allocation` ON `general_school`.`score`.`allocation` = `general_school`.`allocation`.`allocation` 
    inner join `general_school`.`teacher` ON `general_school`.`allocation`.`teacher` = `general_school`.`teacher`.`teacher` 
    inner join `general_school`.`subject` ON `general_school`.`teacher`.`subject` = `general_school`.`subject`.`subject` 
    inner join `general_school`.`staff` ON `general_school`.`teacher`.`staff` = `general_school`.`staff`.`staff` 
    inner join `mutall_users`.`user` ON `general_school`.`staff`.`user` = `mutall_users`.`user`.`user`
    inner join `general_school`.`stage` ON `general_school`.`allocation`.`stage` = `general_school`.`stage`.`stage` 
    inner join `general_school`.`stream` ON `general_school`.`stage`.`stream` = `general_school`.`stream`.`stream` 
    inner join `general_school`.`grade` ON `general_school`.`stream`.`grade` = `general_school`.`grade`.`grade` 
    inner join `general_school`.`school` ON `general_school`.`grade`.`school` = `general_school`.`school`.`school` 
    inner join `general_school`.`student` ON `general_school`.`score`.`student` = `general_school`.`student`.`student`;






SELECT 
    `general_school`.`score`.`value` as `value`
  FROM `general_school`.`score` 
    inner join `general_school`.`term` 
        ON `general_school`.`score`.`term` = `general_school`.`term`.`term` 
    inner join `general_school`.`year` 
        ON `general_school`.`term`.`year` = `general_school`.`year`.`year` 
    inner join `general_school`.`allocation` 
        ON `general_school`.`score`.`allocation` = `general_school`.`allocation`.`allocation` 
        AND `general_school`.`allocation`.`teacher` = `general_school`.`teacher`.`teacher` 
        AND `general_school`.`allocation`.`stage` = `general_school`.`stage`.`stage` 
    inner join `general_school`.`teacher` 
        ON `general_school`.`allocation`.`teacher` = `general_school`.`teacher`.`teacher` 
    inner join `general_school`.`subject`
         ON `general_school`.`teacher`.`subject` = `general_school`.`subject`.`subject` 
    inner join `general_school`.`staff` 
        ON `general_school`.`teacher`.`staff` = `general_school`.`staff`.`staff` 
    inner join `general_school`.`stage` 
        ON `general_school`.`allocation`.`stage` = `general_school`.`stage`.`stage` 
        AND `general_school`.`stage`.`year` = `general_school`.`year`.`year` 
    inner join `general_school`.`stream` 
        ON `general_school`.`stage`.`stream` = `general_school`.`stream`.`stream` inner join `general_school`.`grade` ON `general_school`.`stream`.`grade` = `general_school`.`grade`.`grade` inner join `general_school`.`school` ON `general_school`.`grade`.`school` = `general_school`.`school`.`school` inner join `general_school`.`student` ON `general_school`.`score`.`student` = `general_school`.`student`.`student`