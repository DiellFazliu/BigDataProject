# BigDataProject

SQL Server data-engineering project for combining World Bank indicators with country-level CO₂, energy, methane, population, and temperature data. The project demonstrates CSV ingestion, staging and cleansing, type normalization, dimensional modeling, partitioning, analytical queries, stored procedures, XML export, XQuery/XPath, and a Power BI dashboard.

## What is included

- **World Bank pipeline**: imports wide indicator data, converts year columns to rows, and loads a `FactWDI` fact table.
- **CO₂ and energy pipeline**: imports the combined `MASTER.csv` file, converts text fields to numeric types, and loads `FactCO2Energy`.
- **Data warehouse**: shared `DimCountry`, `DimTime`, and `DimSeries` dimensions.
- **Performance examples**: indexes, year and country partitioning, and partition-aware queries.
- **Analytics**: reusable views, stored procedures, aggregate queries, and verification scripts.
- **XML examples**: SQL Server `FOR XML` exports plus XPath/XQuery expressions.
- **Reporting**: `Dashboard 1.pbix`, a Power BI report file.

## Technology

- Microsoft SQL Server and SQL Server Management Studio (SSMS)
- T-SQL
- Power BI Desktop for the `.pbix` report
- SQL Server XML/XQuery support for the XML examples

The scripts use `BULK INSERT`, `CREATE PARTITION FUNCTION`, `CREATE PARTITION SCHEME`, `FOR XML PATH`, and `CREATE OR ALTER VIEW`, so a SQL Server instance with permission to create databases, tables, procedures, views, and bulk-load files is required.

## Repository layout

| Area | Files |
| --- | --- |
| Database creation | [`create_database.sql`](./create_database.sql) |
| World Bank staging and normalization | [`01_Create_Staging_And_Import.sql`](./01_Create_Staging_And_Import.sql), [`02_Data_Cleaning_Staging.sql`](./02_Data_Cleaning_Staging.sql), [`03_Create_Normalized_Table.sql`](./03_Create_Normalized_Table.sql), [`04_Unpivot_Transform_Data.sql`](./04_Unpivot_Transform_Data.sql) |
| CO₂/energy staging and normalization | [`01_Create_Staging_And_Import_MASTER.sql`](./01_Create_Staging_And_Import_MASTER.sql), [`02_Data_Cleaning_Staging_MASTER.sql`](./02_Data_Cleaning_Staging_MASTER.sql), [`03_Create_Normalized_Table_MASTER.sql`](./03_Create_Normalized_Table_MASTER.sql), [`04_Convert_And_Insert_Data_IntoFinaleTable_MASTER.sql`](./04_Convert_And_Insert_Data_IntoFinaleTable_MASTER.sql), [`06_Replace_NULL_With_Zero_MASTER.sql`](./06_Replace_NULL_With_Zero_MASTER.sql) |
| Warehouse model and loading | [`05_Create_DWH_Dimensions.sql`](./05_Create_DWH_Dimensions.sql), [`06_Create_DWH_FactTables.sql`](./06_Create_DWH_FactTables.sql), [`07_Load_Dimensions_From_WorldBank.sql`](./07_Load_Dimensions_From_WorldBank.sql), [`08_Load_FactWDI.sql`](./08_Load_FactWDI.sql), [`09_Load_Dimensions_From_Master.sql`](./09_Load_Dimensions_From_Master.sql), [`10_Load_FactCO2Energy.sql`](./10_Load_FactCO2Energy.sql) |
| Indexing and partitioning | [`05_Create_Indexes_MASTER.sql`](./05_Create_Indexes_MASTER.sql), [`11_partition_year_FactCO2Energy.sql`](./11_partition_year_FactCO2Energy.sql), [`12_partition_country_FactCO2Energy.sql`](./12_partition_country_FactCO2Energy.sql), [`18_partition_year_FactWDI.sql`](./18_partition_year_FactWDI.sql), [`19_partition_country_FactWDI.sql`](./19_partition_country_FactWDI.sql) |
| Validation and analytics | [`13_verification.sql`](./13_verification.sql), [`14_partition_queries.sql`](./14_partition_queries.sql), [`15_analytic_query.sql`](./15_analytic_query.sql), [`20_verification_for_FactWDI_partition.sql`](./20_verification_for_FactWDI_partition.sql), [`21_queries_using_FactWDI_partition_tables.sql`](./21_queries_using_FactWDI_partition_tables.sql) |
| Reusable database objects | [`16_views.sql`](./16_views.sql), [`17_stored_procedures.sql`](./17_stored_procedures.sql) |
| XML and query examples | [`FactCO2_XML_Export.sql`](./FactCO2_XML_Export.sql), [`FactCO2_XML_EXPORT_.sql`](./FactCO2_XML_EXPORT_.sql), [`XPATH_QUERY_01.xq`](./XPATH_QUERY_01.xq), [`XPATH_QUERY_02.xq`](./XPATH_QUERY_02.xq), [`XQUERY_01.xq`](./XQUERY_01.xq), [`XQUERY_02.xq`](./XQUERY_02.xq) |
| Sample XML exports | [`CO2_XML_Export.xml`](./CO2_XML_Export.xml), [`CO2_XML_EXPORT_.xml`](./CO2_XML_EXPORT_.xml), [`CO2_XML_EXPORT_2.0.xml`](./CO2_XML_EXPORT_2.0.xml) |
| Dashboard | [`Dashboard 1.pbix`](./Dashboard%201.pbix) |

## Data inputs

The repository does not include the CSV files consumed by the import scripts. Place these files on the SQL Server host, or update the `BULK INSERT` paths before running:

1. `dataset_Worldbank.csv`
2. `MASTER.csv`

The expected World Bank CSV is wide: country name/code, series name/code, followed by year columns. The current script explicitly defines the years `2000`–`2008` and `2017`–`2025`; add columns to [`01_Create_Staging_And_Import.sql`](./01_Create_Staging_And_Import.sql) and [`04_Unpivot_Transform_Data.sql`](./04_Unpivot_Transform_Data.sql) if the source contains other years.

`MASTER.csv` is expected to contain these columns, in this order: `RowNumber`, `Year`, `Country`, `ISOCode`, CO₂ component fields, energy fields, `CH4`, `Population`, and `TempChange`. The temperature field is staged but is not loaded into `MasterNormalized` or `FactCO2Energy`.

## Setup and execution

### 1. Create the database

Run [`create_database.sql`](./create_database.sql), then select the `BigDataProject` database in SSMS.

### 2. Load and normalize the source data

Run the World Bank pipeline:

1. [`01_Create_Staging_And_Import.sql`](./01_Create_Staging_And_Import.sql)
2. [`02_Data_Cleaning_Staging.sql`](./02_Data_Cleaning_Staging.sql)
3. [`03_Create_Normalized_Table.sql`](./03_Create_Normalized_Table.sql)
4. [`04_Unpivot_Transform_Data.sql`](./04_Unpivot_Transform_Data.sql)

Run the CO₂/energy pipeline:

1. [`01_Create_Staging_And_Import_MASTER.sql`](./01_Create_Staging_And_Import_MASTER.sql)
2. [`02_Data_Cleaning_Staging_MASTER.sql`](./02_Data_Cleaning_Staging_MASTER.sql)
3. [`03_Create_Normalized_Table_MASTER.sql`](./03_Create_Normalized_Table_MASTER.sql)
4. [`04_Convert_And_Insert_Data_IntoFinaleTable_MASTER.sql`](./04_Convert_And_Insert_Data_IntoFinaleTable_MASTER.sql)
5. [`05_Create_Indexes_MASTER.sql`](./05_Create_Indexes_MASTER.sql)
6. [`06_Replace_NULL_With_Zero_MASTER.sql`](./06_Replace_NULL_With_Zero_MASTER.sql)

The cleaning scripts remove invalid rows, strip quotation marks from country values, and convert empty strings to `NULL`. The conversion scripts use `TRY_CAST`, so values that cannot be converted become `NULL` rather than aborting the insert.

### 3. Build and load the warehouse

Run these scripts in order:

1. [`05_Create_DWH_Dimensions.sql`](./05_Create_DWH_Dimensions.sql)
2. [`06_Create_DWH_FactTables.sql`](./06_Create_DWH_FactTables.sql)
3. [`07_Load_Dimensions_From_WorldBank.sql`](./07_Load_Dimensions_From_WorldBank.sql)
4. [`08_Load_FactWDI.sql`](./08_Load_FactWDI.sql)
5. [`09_Load_Dimensions_From_Master.sql`](./09_Load_Dimensions_From_Master.sql)
6. [`10_Load_FactCO2Energy.sql`](./10_Load_FactCO2Energy.sql)

The resulting model is:

```text
DimCountry ─┬─ FactWDI ─ DimSeries
            └─ FactCO2Energy
DimTime ────┴─ (both fact tables)
```

`FactWDI` stores one row per country, year, and indicator series. `FactCO2Energy` stores country/year measures for total, coal, oil, and gas CO₂ plus population. The load scripts join facts to surrogate keys in the dimensions.

### 4. Add optional database objects

Run [`16_views.sql`](./16_views.sql) and [`17_stored_procedures.sql`](./17_stored_procedures.sql). They create:

- `vw_CO2PerCapita`
- `vw_CompareGermanyFrance`
- `vw_Top10Countries`
- `vw_YearlyGlobalStats`
- `vw_CountryYearUnique`
- `sp_TotalCO2ByCountry`
- `sp_ComparePerCapita`
- `sp_TopNCountriesByYear`

Example:

```sql
EXEC dbo.sp_TotalCO2ByCountry @CountryName = N'Germany';
EXEC dbo.sp_ComparePerCapita @Country1 = N'Germany', @Country2 = N'France';
EXEC dbo.sp_TopNCountriesByYear @Year = 2020, @TopN = 5;
```

### 5. Run partitioning and validation examples

Partition scripts create additional demonstration tables; they do not repartition the original fact tables:

- CO₂/energy: [`11_partition_year_FactCO2Energy.sql`](./11_partition_year_FactCO2Energy.sql), [`12_partition_country_FactCO2Energy.sql`](./12_partition_country_FactCO2Energy.sql)
- World Bank: [`18_partition_year_FactWDI.sql`](./18_partition_year_FactWDI.sql), [`19_partition_country_FactWDI.sql`](./19_partition_country_FactWDI.sql)

Use [`13_verification.sql`](./13_verification.sql) and [`20_verification_for_FactWDI_partition.sql`](./20_verification_for_FactWDI_partition.sql) to inspect row distribution, then use [`14_partition_queries.sql`](./14_partition_queries.sql) and [`21_queries_using_FactWDI_partition_tables.sql`](./21_queries_using_FactWDI_partition_tables.sql) for filtered and aggregate queries.

The country partition examples use SQL Server range-left partition functions with selected boundary values; they are illustrative list-like groupings, not true hash/list partitions.

## XML and XPath/XQuery

The SQL export scripts generate XML from `FactCO2Energy`:

- [`FactCO2_XML_Export.sql`](./FactCO2_XML_Export.sql) produces a simple `CO2Data` element structure.
- [`FactCO2_XML_EXPORT_.sql`](./FactCO2_XML_EXPORT_.sql) produces country records with attributes, component CO₂ values, population, and a `UniqueID`.

The checked-in XML files are example exports. The accompanying expressions query `CountryRecord` elements:

- [`XPATH_QUERY_01.xq`](./XPATH_QUERY_01.xq): list country attributes.
- [`XPATH_QUERY_02.xq`](./XPATH_QUERY_02.xq): filter countries by total CO₂.
- [`XQUERY_01.xq`](./XQUERY_01.xq): format country totals.
- [`XQUERY_02.xq`](./XQUERY_02.xq): return the top three countries for 2020.

Run the expressions in an XML/XQuery-capable tool against [`CO2_XML_EXPORT_2.0.xml`](./CO2_XML_EXPORT_2.0.xml), whose records include the `UniqueID` attribute.

## Dashboard

Open [`Dashboard 1.pbix`](./Dashboard%201.pbix) with Power BI Desktop. Because the report may reference a local SQL Server/database or an earlier data source, use **Transform data** or **Data source settings** to update the connection to the `BigDataProject` database and refresh the model.

## Important operational notes

- `BULK INSERT` reads files from the SQL Server machine and service account context, not necessarily from the client computer running SSMS.
- Import paths are currently hard-coded under `C:\Users\DELL\Downloads\`; change both scripts or place the files at those exact paths.
- Several scripts use `DROP TABLE` or create objects without existence guards. Run them in the documented order on a fresh database, or adapt them before rerunning in an existing database.
- The partition scripts create tables with simplified columns for demonstrations and are not replacements for the main fact tables.
- `06_Replace_NULL_With_Zero_MASTER.sql` changes missing numeric values to zero. Apply this only if zero is an acceptable analytical interpretation of missing data.
- The scripts are T-SQL and are not intended for PostgreSQL, MySQL, SQLite, or other database engines.

## Status

This repository is a collection of SQL Server coursework/project scripts and supporting artifacts. No automated test suite or dependency manifest is included. Validation is performed through the supplied SQL verification and analytical queries after loading the source data.
