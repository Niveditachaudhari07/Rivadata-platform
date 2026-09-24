--lec-05
--creating
CREATE TABLE IF NOT EXISTS rivadataplatform.dataproduct.fact_attendance (

    attendance_id STRING NOT NULL,
    student_key BIGINT NOT NULL,
    class_key BIGINT NOT NULL,
    batch_key BIGINT NOT NULL,
    date_key INT NOT NULL,
    attendance_status STRING NOT NULL,
    joined_at TIMESTAMP,
    remarks STRING,
    attendance_count INT NOT NULL,
    present_flag INT NOT NULL,
    absent_flag INT NOT NULL,
    late_flag INT NOT NULL,

CONSTRAINT pk_fact_attendance PRIMARY KEY (attendance_id)
);

--Inserting
INSERT INTO rivadataplatform.dataproduct.fact_attendance (
attendance_id , 
student_key, 
class_key, 
batch_key, 
date_key ,
attendance_status, 
joined_at,
remarks, 
attendance_count,
present_flag,
absent_flag, 
late_flag 

)


--selecting

select 
a.attendance_id,
ds.student_key,
dc.class_key,
db.batch_key,
dd.date_key,
a.attendance_status,
try_cast (a.joined_at as timestamp) as joined_at,
a.remarks,
case 
   when a.attendance_status = 'Present' then 1
   else 0 
   end as attendance_count,

case 
   when a.attendance_status = 'Present' then 1
   else 0 
   end as present_flag,

case 
   when a.attendance_status = 'Absent' then 1
   else 0 
   end as absent_flag,

case 
   when a.attendance_status = 'Late' then 1
   else 0 
   end as late_flag
   
from rivadataplatform.landing.attendance a
left join rivadataplatform.dataproduct.dim_students ds
on a.student_id = ds.student_id

left join rivadataplatform.dataproduct.dim_class dc
on a.class_id = dc.class_id

left join rivadataplatform.dataproduct.dim_batch db
on dc.batch_id = db.batch_id

left join rivadataplatform.dataproduct.dim_date dd
on dc.class_date = dd.date;

--join is done in forgein key
--here student id is forgein key

select* from rivadataplatform.landing.attendance