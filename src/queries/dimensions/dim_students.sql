--create table
CREATE OR REPLACE TABLE rivadataplatform.dataproduct.dim_students ( 
    student_key BIGINT NOT NULL,
    student_id STRING NOT NULL,
    student_name STRING NOT NULL,
    email STRING NOT NULL,
    city STRING,
    country STRING,
    phone_no STRING,
    linkedin_link STRING,
    github_link STRING,
    created_at TIMESTAMP NOT NULL,
    
    CONSTRAINT PK_DIM_STUDENT
       PRIMARY KEY (student_key)
);

--INSERTING DATA
---Inserting Data 
INSERT INTO rivadataplatform.dataproduct.dim_students (
    student_key,
    student_id,
    student_name,
    email,
    city,
    country,
    phone_no,
    linkedin_link,
    github_link,
    created_at
)
SELECT
    ROW_NUMBER() OVER (
        ORDER BY CAST(student_id AS BIGINT)
    ) AS student_key,
    student_id,
    name,
    email,
    city,
    country,
    phone_no,
    linkedin_link,
    github_link,
    CAST(created_at AS TIMESTAMP)
FROM rivadataplatform.landing.students;


select * from rivadataplatform.dataproduct.dim_students