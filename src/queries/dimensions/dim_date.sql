-- Creating Table
--lec-05

CREATE OR REPLACE TABLE rivadataplatform.dataproduct.dim_date
(
    date_key            INT     NOT NULL,
    date                DATE    NOT NULL,
    year                INT     NOT NULL,
    quarter             INT     NOT NULL,
    month               INT     NOT NULL,
    month_name          STRING  NOT NULL,
    week_of_year        INT     NOT NULL,
    day                 INT     NOT NULL,
    day_name            STRING  NOT NULL,
    day_of_week         INT     NOT NULL,
    is_weekend          BOOLEAN NOT NULL,

    CONSTRAINT pk_dim_date
    PRIMARY KEY (date_key)
);

-- Inserting Data
INSERT INTO rivadataplatform.dataproduct.dim_date (
date_key,
date,
year,
quarter,
month,
month_name,
week_of_year,
day,
day_name,
day_of_week,
is_weekend
)

with dates as
(
select 

explode(
    sequence(
        to_date('2020-08-01'),
        to_date('2030-07-30'),
        interval 1 day
    )
) AS date

)

select 
CAST(DATE_FORMAT(date,'yyyyMMdd') AS INT) as date_key,
date,
year(date) as year,
quarter(date) as quarter,
month(date) as month,
date_format(date,'MMMM') as month_name,
WEEKOFYEAR(date) as week_of_year,
day(date) as day,
DATE_FORMAT(date,'EEEE') as day_name,
DAYOFWEEK(date) as day_of_week,
case
    when DAYOFWEEK(date) IN (1,7)
    then True
    else False
    end as is_weekend

from dates