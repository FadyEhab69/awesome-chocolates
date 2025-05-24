# Data Analysis Report: Optimizing Sales and Operations for Awesome Chocolates (May 2025)
# Overview
As a data analyst, I conducted a comprehensive analysis of the awesome_chocolates database to support the owner of Awesome Chocolates in enhancing sales strategies and operational efficiency. Leveraging SQL queries on the sales, products, geo, and people tables, I addressed key business questions to uncover trends, identify top performers, and provide data-driven recommendations. This report highlights my analytical process, key findings, and actionable insights .

# Data Analysis Process
# Dataset Description
Tables Analyzed:
geo: Contains GeoID, Geo, and Region (e.g., Americas, APAC, Europe).
people: Includes Salesperson, SPID, Team, and Location.
products: Features PID, Product, Category, Size, and Cost_per_box.
sales: Tracks SPID, GeoID, PID, SaleDate, Amount, Customers, and Boxes.
Objective: Optimize sales performance, inventory management, and team efficiency based on historical sales data from 2021 to 2022.

# Analytical Questions and Insights
 1/ Sales Performance by Region:
Queried SELECT g.Region, g.Geo, SUM(s.Amount) AS total_revenue, COUNT(s.SaleDate) AS total_transactions FROM sales s JOIN geo g ON s.GeoID = g.GeoID GROUP BY g.Region, g.Geo ORDER BY total_revenue DESC to identify top-revenue regions.
Analyzed monthly trends with SELECT g.Region, g.Geo, DATE_FORMAT(s.SaleDate, '%Y-%m') AS sale_month, SUM(s.Amount) AS monthly_revenue ... GROUP BY g.Region, g.Geo, sale_month ORDER BY sale_month, monthly_revenue DESC, revealing seasonal patterns (e.g., January 2021 peaks).
Insight: Americas (USA, Canada) led revenue, with potential for resource allocation to high performers and targeted marketing in underperforming regions.
 2/ Product Popularity and Profitability:
Calculated top-selling products by boxes with SELECT g.Region, p.Product, SUM(s.Boxes) AS total_boxes_sold FROM sales s JOIN products p ON s.PID = p.PID JOIN geo g ON s.GeoID = g.GeoID GROUP BY g.Region, p.Product ORDER BY total_boxes_sold DESC.
Insight: Products like Orange Choco and Organic Choco Syrup dominated sales, suggesting inventory focus on high-demand items.
 3/ Salesperson and Team Performance:
Assessed top performers with SELECT p.Salesperson, p.Team, p.Location, SUM(s.Amount) AS total_revenue, SUM(s.Customers) AS total_customers, SUM(s.Boxes) AS total_boxes FROM sales s JOIN people p ON s.SPID = p.SPID GROUP BY p.Salesperson, p.Team, p.Location ORDER BY total_revenue DESC LIMIT 5.
Identified top teams (SELECT * FROM people WHERE Team IN ('delish', 'yummies')) based on revenue.
Insight: Teams Delish and Yummies excelled, warranting rewards, while underperformers need support.
 4/ Cost vs. Revenue Analysis:
Evaluated profitability with SELECT p.Product, p.Cost_per_box, SUM(s.Amount) AS total_revenue, SUM(s.Boxes) AS total_boxes, (SUM(s.Amount) / (SUM(s.Boxes) * p.Cost_per_box)) AS revenue_to_cost_ratio FROM sales s JOIN products p ON s.PID = p.PID GROUP BY p.Product, p.Cost_per_box ORDER BY revenue_to_cost_ratio DESC.
Insight: Low-cost items (e.g., White Choc at $0.16/box) showed high revenue-to-cost ratios, while high-cost, low-margin products need review.
 5/ Total Revenue Across Regions:
Computed overall revenue with SELECT SUM(s.Boxes * p.Cost_per_box) AS total_revenue FROM sales s JOIN products p ON s.PID = p.PID.
Insight: Provided a baseline for current sales performance (exact figure pending final query execution).
 6/ Top 5 Products by Region:
Identified regional best-sellers with SELECT g.Region, p.Product, SUM(s.Boxes) AS total_boxes FROM sales s JOIN products p ON s.PID = p.PID JOIN geo g ON s.GeoID = g.GeoID GROUP BY g.Region, p.Product ORDER BY g.Region, total_boxes DESC LIMIT 5.
Insight: USA led with products like Organic Choco Syrup and Orange Choco, guiding regional marketing.
 7/ High-Value Transactions:
Filtered transactions over $10,000 in 2022 with SELECT SaleDate, Amount FROM sales WHERE Amount > 10000 AND SaleDate >= '2022-01-01' ORDER BY Amount DESC.
Insight: Highlighted significant sales for strategic follow-up.
 8/ Weekly Performance:
Analyzed Thursday sales (weekday 4) with SELECT PID, GeoID, SaleDate, Amount, Boxes, WEEKDAY(SaleDate) AS 'day of week' FROM sales WHERE WEEKDAY(SaleDate) = 4.
Insight: Identified mid-week demand for inventory planning.

# Key Findings
Regional Trends: Americas outperformed other regions, with January 2021 showing peak sales, possibly due to seasonal demand.
Product Demand: Orange Choco and Organic Choco Syrup were top sellers, indicating strong market preference.
Team Efficiency: Delish and Yummies teams led revenue, while some salespeople lacked team assignments, suggesting organizational gaps.
Profitability: Low-cost products yielded high margins, while high-cost items underperformed.
High-Value Orders: 2022 saw significant transactions, with mid-week activity peaking on Thursdays.
# Recommendations
Resource Allocation: Expand production and marketing in Americas; target underperforming regions (e.g., APAC) with tailored campaigns.
Inventory Management: Prioritize stock for high-demand products like Orange Choco; phase out low-margin items.
Team Incentives: Reward Delish and Yummies teams; provide training or reassign underperforming salespeople.
Operational Efficiency: Standardize team assignments and validate cost-per-box data for accurate reporting.
Seasonal Strategy: Leverage January peaks with promotions; monitor Thursday sales for mid-week boosts.
# Analytical Skills Demonstrated
Data Exploration: Effectively queried and joined multiple tables to extract comprehensive insights.
Trend Analysis: Identified seasonal and regional patterns to inform strategic planning.
Query Optimization: Used aggregations and filters (e.g., GROUP BY, LIMIT) to focus on actionable data.
Insight Generation: Translated raw sales data into business recommendations, enhancing decision-making.
Problem-Solving: Addressed data inconsistencies (e.g., team assignment gaps) with practical suggestions.
# Conclusion
This analysis transformed the awesome_chocolates dataset into a strategic tool, providing insights into sales performance, product profitability, and team efficiency. The process underscores my proficiency in SQL, data interpretation, and business application. Future work could include predictive modeling to forecast demand and optimize pricing strategies.
