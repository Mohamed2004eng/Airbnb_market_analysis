# Airbnb Market Analysis — Barcelona 

## 📌 Project Overview

This project explores the Airbnb rental market in Barcelona using SQL to analyze listing distribution, nightly pricing, estimated revenue, host behavior, and market concentration.

The goal is to transform raw listing data into meaningful business insights that can help hosts, property investors, and market analysts understand competitive positioning and potential pricing opportunities.

The project combines SQL querying, data cleaning, aggregation, subqueries, Common Table Expressions (CTEs), and window functions to answer practical business questions about the short-term rental market.

**Project Contributors:** Deimante Runaite and Mohamed Ahmed

**Tools:** SQL, Google BigQuery / SQL query analysis

**Data Source:** [Inside Airbnb — Get the Data](https://insideairbnb.com/get-the-data/)

**Market:** Barcelona, Spain

**Listings reported in the project:** 19,410

---

## 🎯 Business Objectives

The project investigates five main areas:

1. **Market Overview:** Understand listing distribution across neighborhoods and room types.
2. **Pricing Dynamics:** Explore nightly prices, price segments, accommodation capacity, and rating-related price differences.
3. **Revenue & Market Performance:** Compare estimated revenue across neighborhoods, room types, listings, and hosts.
4. **Host Behavior & Market Concentration:** Identify hosts managing multiple properties and examine the role of professional hosts.
5. **Competitive Opportunities:** Explore potential underpriced listings, higher-revenue properties, and market positioning.

---

## 🛠️ Tools & SQL Skills

### SQL Techniques Used

- Data exploration using `SELECT`
- Filtering records using `WHERE`
- Grouping and aggregation using `GROUP BY`
- Filtering aggregated results using `HAVING`
- Sorting results using `ORDER BY`
- Data type conversion and price cleaning using `CAST()` and `REPLACE()`
- Conditional classification using `CASE`
- Subqueries for citywide average comparisons
- Window functions using `NTILE()`, `RANK()`, `ROW_NUMBER()`, and `SUM() OVER()`
- Revenue and pricing analysis using aggregate functions
- Host-level and neighborhood-level segmentation

These techniques help transform listing-level data into useful summaries for business analysis.

---

## 📊 Analysis & Key Questions

### 1. Market Overview

This section examines the size and structure of Barcelona's Airbnb market.

Key questions:
- How many listings are marked as available?
- Which neighborhoods have the largest number of listings?
- What percentage of listings are entire homes, private rooms, or shared rooms?

**Business value:** Understand market concentration and identify areas with substantial listing supply and potential competition.

### 2. Pricing Dynamics

This section explores nightly prices and differences between listings.

Key questions:
- What is the average nightly listing price?
- Which neighborhoods have the highest average prices?
- What are the highest-priced listings?
- How does accommodation capacity relate to price?
- Which neighborhoods have prices above the citywide average?
- How can listings be categorized into Budget, Mid-range, Premium, and Luxury segments?
- Which listings fall within the top 10% of prices?
- Do higher-rated listings charge more on average?

**Business value:** Support competitive pricing analysis, identify premium market segments, and examine the relationship between guest ratings and prices.

### 3. Revenue & Market Performance

This section compares estimated revenue across properties, room types, neighborhoods, and hosts.

Key questions:
- Which neighborhoods have the highest total estimated revenue?
- Which room types contribute the most estimated revenue?
- Which listings report the highest estimated revenue over the last 365 days?
- Which properties have the highest reported revenue per listing?
- How can neighborhoods be ranked by average estimated revenue?
- What is the highest-revenue listing in each neighborhood?
- Which hosts have average listing revenue above the overall listing-level average?

**Business value:** Compare revenue patterns and identify listings or market segments worth investigating further.

**Important distinction:** The SQL uses `estimated_revenue_l365d`, which represents estimated revenue over the last 365 days in the source data. It should not automatically be interpreted as verified revenue or a forecast of future annual earnings.

### 4. Host Behavior & Market Concentration

This section examines how listings are distributed among hosts.

Key questions:
- Which hosts manage the largest number of properties?
- What share of listings belongs to hosts classified as professional?
- Which hosts manage at least five properties?

For this analysis, hosts with at least ten listings are classified as **Professional**, while those with fewer than ten are classified as **Regular**, following the project's SQL definition.

**Business value:** Understand whether the market includes large multi-property operators and how property supply is distributed among hosts.

---

## 🔍 Key Findings from the Project Presentation

The accompanying presentation reports the following findings:

- **Market concentration:** Airbnb listings are concentrated in central neighborhoods, contributing to higher competition in tourist areas.
- **Room types:** Entire homes and apartments account for approximately 61% of listings.
- **Pricing differences:** Average listing prices vary across neighborhoods and accommodation capacities.
- **Host structure:** The presentation reports 6,620 hosts managing 19,410 listings, or approximately 2.93 listings per host.
- **Superhost pricing:** Superhosts have an average listed price of €199.72, compared with €184.51 for non-Superhosts.
- **Guest ratings:** The presentation reports average ratings of 4.82 for Superhosts and 4.50 for non-Superhosts.
- **Revenue patterns:** Estimated revenue varies by neighborhood and room type; entire homes form a major market segment.
- **Pricing opportunities:** Listings with below-average prices and indicators of potentially high demand may warrant further investigation.

These findings are observations reported in the project presentation. They should be interpreted in the context of the dataset and the methodology used.

---

## 💡 Business Recommendations

Based on the questions and patterns explored in this project, the following actions are worth investigating:

1. **Benchmark prices:** Compare properties with similar room types, capacity, and neighborhood characteristics.
2. **Review premium segments:** Investigate high-priced listings to understand what differentiates their positioning.
3. **Explore capacity-based pricing:** Evaluate whether larger properties are priced appropriately for their target guests.
4. **Investigate revenue differences:** Compare neighborhood and room-type performance before drawing investment conclusions.
5. **Study host concentration:** Examine the scale of multi-property operators and their share of total listing supply.
6. **Use ratings carefully:** Explore whether higher ratings are associated with higher prices without assuming that ratings cause price differences.
7. **Validate revenue estimates:** Use booking and occupancy records, where available, before making financial decisions.

---

## ⚠️ Data & Methodology Limitations

- The analysis is based on listing data from Inside Airbnb, not a complete record of all Airbnb transactions.
- Listings marked as available are not necessarily equivalent to active, booked, or revenue-generating properties.
- Estimated revenue should not be treated as verified financial revenue.
- Price and revenue comparisons may be affected by missing values, outliers, and differences in property characteristics.
- Relationships between ratings, prices, and host status do not establish causation.
- The Professional Host classification is a project-defined threshold, not necessarily an official Airbnb classification.
- Some findings in the presentation use different query approaches from the SQL script. Results should be validated against the final dataset and executed queries before being treated as definitive.

---

## 📁 Repository Structure

```text
airbnb-market-analysis-barcelona/
│
├── README.md
├── sql/
│   └── airbnb_analysis.sql
├── documentation/
│   └── Airbnb_Market_Analysis.pdf
└── screenshots/
    └── market_analysis.png
```

*The structure above is recommended; the filenames should match the files actually uploaded to the repository.*

---

## 📚 Data Source

[Inside Airbnb — Get the Data](https://insideairbnb.com/get-the-data/)

The data is used for educational and portfolio analysis. Please refer to the source website for its data documentation and applicable terms.

---

## 🏁 Conclusion

This project demonstrates how SQL can be used to investigate a real-world business problem by analyzing market structure, pricing, estimated revenue, and host behavior.

The analysis highlights the importance of comparing listings across meaningful segments rather than relying on a single citywide average. It also demonstrates how SQL aggregations, subqueries, conditional logic, and window functions can support data-driven business questions.

The overall objective is to turn listing data into structured analysis that supports better market understanding and more informed pricing and positioning decisions.
