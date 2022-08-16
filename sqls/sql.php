<?php
include_once '../code/school.php';
// 
//
$sch = new school("kaps");
$sql = "select subject.subject as name, name  from subject";
//$meta= $sch->get_column_metadata($sql);
//var_dump($meta);
// 
//fetchAll(\PDO::FETCH_ASSOC)
$data= $sch->get_sql_data($sql);
// 
//
$stmt =$sch->pdo->query($sql);
$new= $stmt->fetchAll(\PDO::FETCH_INTO);
echo json_encode($new);
