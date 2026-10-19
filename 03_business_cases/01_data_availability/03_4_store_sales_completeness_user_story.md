# User Story

As a business stakeholder,
I want to receive a reliable daily store sales completeness report,
so that I can identify stores with missing, incomplete, or unusually low sales data before using the information for business decisions.

## Business value

The report helps the business:
- verify that every active store submitted sales data
- identify stores with missing sales
- detect sales without matching sale items
- identify unusually low sales activity
- avoid using incomplete or potentially unreliable store data in reporting and analysis

## Definition of Done

- The business requirement is documented.
- The grain is defined.
- Source tables and fields are documented.
- Data quality rules are defined.
- Acceptance criteria are documented.
- SQL implementation is completed.
- Every active store appears in the final output.
- Data quality flags are generated correctly.
- availability_status is calculated correctly.
- Validation queries confirm that the output matches the source data and business rules.