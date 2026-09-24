CREATE OR REPLACE TABLE rivadataplatform.dataproduct.dim_batch (
    batch_key BIGINT NOT NULL,
    batch_id STRING NOT NULL,
    batch_name STRING NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE,
    status STRING NOT NULL,
    created_at TIMESTAMP NOT NULL,

    CONSTRAINT PK_DIM_BATCH
        PRIMARY KEY (batch_key)
);

INSERT INTO rivadataplatform.dataproduct.dim_batch (
    batch_key,
    batch_id,
    batch_name,
    start_date,
    end_date,
    status,
    created_at
)
SELECT
    ROW_NUMBER() OVER (
        ORDER BY CAST(batch_id AS BIGINT)
    ) AS batch_key,
    batch_id,
    batch_name,
    CAST(start_date AS DATE),
    CAST(end_date AS DATE),
    status,
    CAST(created_at AS TIMESTAMP)
FROM rivadataplatform.landing.batches;

