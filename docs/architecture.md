# Architecture

- Microsoft Fabric Warehouse: `WWIAnalyticsWarehouse`
- Analytical SQL view: `dbo.vw_TripAnalytics`
- Semantic model: `NYC Taxi Analytics`
- Report: `NYC Taxi Advanced Analytics`
- Storage/query pattern: Direct Lake on SQL, with the SQL view potentially falling back to DirectQuery
- Model: star schema with Date, Time, Geography, Medallion, HackneyLicense, Weather, and Trip analytics
- Alternative relationships: inactive drop-off time and drop-off geography relationships activated in DAX
