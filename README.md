# 🌍 NYC Air Quality Analysis – Dimensional Data Warehouse Project

What if we could track pollution trends across time, space, and health in one place?

This project is a full data pipeline that combines air pollution and health data in New York City into a centralized, dimensional data warehouse. Built during my MSc in Data Analytics at Dublin Business School, the goal was to empower stakeholders with evidence-based environmental insights.

## 🏙 Project Overview
- Merge EPA + NYC Open Data into a unified system
- Track pollutants: PM2.5, NO₂, O₃
- Monitor hospitalizations and seasonal trends
- Design interactive dashboards and spatial reports

## 📐 Schema Design
- **Star Schema** with:
  - `AirQuality_Fact`
  - `Time_Dimension`, `Location_Dimension`, `Indicator_Dimension`

## ⚙️ ETL Pipeline (SSIS)
- Extracted and transformed data from multiple sources
- Cleaned missing values, normalized text, validated types
- Loaded structured data into SQL Server

## 📊 Visualizations
- **Tableau Dashboards**:
  - Daily pollution by neighborhood
  - Yearly pollutant comparison
  - Seasonality of air quality
  - Health outcomes vs. pollution
- **SSRS Reports**: Tabular summaries for agencies

## 🔄 Tech Comparison
- Benchmarked SQL Server vs. Neo4j (Graph DB)
- Implemented 7 key queries to explore performance trade-offs

## 🛠 Tools Used
- SSIS (ETL), SQL Server, Neo4j
- Tableau & SSRS
- Python for data cleaning logic

## 🎯 Outcome
A fully functional, scalable data warehouse that supports spatial, temporal, and health-based air quality insights for public stakeholders.

