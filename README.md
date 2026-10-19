# RetailCore SQL Analytics

A portfolio project for practicing advanced SQL, business analytics, data modeling, data quality validation, and query optimization using PostgreSQL.

## Goals

- Build a realistic retail company database
- Practice intermediate and advanced SQL
- Solve business-oriented analytical problems
- Apply data quality and validation techniques
- Learn query optimization and performance tuning
- Build a professional SQL portfolio

## Technologies

- PostgreSQL
- DBeaver
- VS Code
- Git
- GitHub

## Main SQL Concepts

- JOINs and join cardinality
- CTEs and subqueries
- Aggregations and GROUP BY
- Window functions
- LAG, ROW_NUMBER, RANK, DENSE_RANK, NTILE
- Running totals and moving averages
- EXISTS, NOT EXISTS and IN
- Date-based analysis
- Customer segmentation and RFM analysis
- Data quality checks
- Source-to-output reconciliation
- Grain and KPI validation

## Retail Data Availability Business Cases

This project includes business-oriented data availability and data quality scenarios based on a fictional retail environment.

### 1. Daily Sales Availability

Validates whether all stores submitted reliable daily sales data.

Key concepts:

- store-level daily aggregation
- missing data detection
- duplicate detection
- sales without sale items
- data availability status
- source-to-target mapping
- acceptance criteria
- user story documentation

### 2. Product Master Availability

Validates whether sold products have complete and reliable master data.

Key concepts:

- product master validation
- category and supplier integrity
- invalid price detection
- data quality flags
- controlled negative tests
- output grain validation
- source-to-output reconciliation

### 3. Store Sales Completeness

Validates store-level daily sales completeness and identifies unusually low sales activity.

Key concepts:

- daily store-level sales aggregation
- historical sales baseline
- missing sale item detection
- missing store sales detection
- anomaly flagging
- KPI reconciliation
- data quality status

## Business Case Methodology

Each business case follows a structured analytical workflow:

1. Define the business requirement
2. Define the output grain
3. Identify source tables and required fields
4. Define business and data quality rules
5. Define the expected output
6. Build SQL transformation layers
7. Generate data quality flags and final business status
8. Validate the final output against source data
9. Define acceptance criteria
10. Document the user story and business value

## Validation Approach

Before aggregating or calculating KPIs, the following checks are considered:

- What does one row represent?
- Which fields are unique?
- What is the JOIN cardinality?
- Can the JOIN multiply rows?
- Are there duplicate records?
- Are there orphan records?
- Are expected master data records missing?
- Are source and output KPI values consistent?

A recurring validation principle used throughout the project is:

> Grain → Keys → Join Cardinality → Validation → KPI

## Database Model

The RetailCore database represents a simplified retail environment with the following main entities:
- stores
- employees
- customers
- categories
- suppliers
- products
- sales
- sale_items

The sales table represents transaction headers, while sale_items contains the individual products belonging to each sale.

This one-to-many relationship is intentionally used throughout the project to practice JOIN cardinality and KPI validation.

## Example Business Metrics

The project includes analysis of:
- store revenue
- product revenue
- monthly revenue growth
- returning customer rate
- customer spending
- top products by store and category
- running revenue
- moving averages
- customer purchase frequency
- recency
- RFM metrics and segmentation

## Data Quality Examples

The project also includes checks for:
- duplicate sales
- orphan sale items
- missing customer references
- missing product master records
- missing category or supplier records
- invalid pricing
- stores with missing daily sales
- sales without matching sale items
- unusually low sales activity

## Current Focus

The current focus of the project is retail data availability and data quality analysis, with particular attention to reliable reporting, business requirements, SQL validation, and Business Analyst-style documentation.

## Future Development

Planned future development includes:
- additional business cases
- more complex validation scenarios
- query performance analysis
- indexing and optimization
- Python-based data engineering exercises
- ETL workflows
- cloud and data platform integration

## Project Structure

```text
retailcore-sql-analytics/
├── README.md
│
├── 01_database/
│   ├── schema/
│   │   └── 01_create_tables.sql
│   └── seed/
│       ├── 01_seed_data.sql
│       ├── 02_sales_seed.sql
│       └── 03_additional_sales_seed.sql
│
├── 02_exercises/
│   ├── 01_intermediate/
│   ├── 02_advanced/
│   └── 03_data_quality/
│
├── 03_business_cases/
│   └── 01_data_availability/
│       ├── 01_daily_sales_availability.md
│       ├── 01_daily_sales_availability.sql
│       ├── 01_1_daily_sales_source_mapping.md
│       ├── 01_2_daily_sales_acceptance_criteria.md
│       ├── 01_3_daily_sales_user_story.md
│       │
│       ├── 02_product_master_availability.md
│       ├── 02_product_master_availability.sql
│       ├── 02_1_product_master_source_mapping.md
│       ├── 02_2_product_master_acceptance_criteria.md
│       ├── 02_3_product_master_user_story.md
│       ├── 02_4_product_master_validation.md
│       ├── 02_5_product_master_validation.sql
│       │
│       ├── 03_store_sales_completeness.md
│       ├── 03_store_sales_completeness.sql
│       ├── 03_1_store_sales_completeness_acceptance_criteria.md
│       ├── 03_2_store_sales_completeness_user_story.md
│       ├── 03_3_store_sales_completeness_validation.md
│       └── 03_4_store_sales_completeness_validation.sql
│
├── analysis/
└── docs/