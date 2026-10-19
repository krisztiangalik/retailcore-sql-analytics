# User Story

As a business stakeholder,
I want to receive a daily report about sold products and their master data quality,
so that I can identify missing or invalid product, category, supplier, or price data before using the report for business decisions.

## Business value

The report helps the business:
- verify that every sold product has valid master data
- identify missing product, category, or supplier information
- detect invalid pricing data
- avoid using incomplete or unreliable product data in reporting and analysis

## Definition of Done

- The business requirement is documented.
- Source-to-target mapping is completed.
- Acceptance criteria are defined.
- SQL implementation is completed.
- Every sold product for the reporting date is included in the output.
- Data quality flags are generated.
- availability_status is calculated correctly.
- Query results are validated against the source data.