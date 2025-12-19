# Yelp Business Reviews – End-to-End Data Analytics Project

## 📌 Project Overview
This project demonstrates an end-to-end data analytics pipeline using large-scale Yelp business and review data. The objective was to ingest semi-structured JSON data, process it using cloud and data warehouse technologies, perform sentiment analysis, and extract meaningful business insights using SQL.

The project closely simulates real-world data engineering and analytics workflows involving cloud storage, data warehousing, and analytical querying.

---

## 📊 Dataset
Link to downlaod the dataset: https://business.yelp.com/data/resources/open-dataset/
- **Source:** Yelp Open Dataset
- **Reviews Data:** ~7 million records
- **Business Data:** ~100,000 records
- **Format:** JSON (semi-structured)

---

## 🏗️ Architecture & Workflow

1. **Data Collection**
   - Downloaded Yelp Reviews and Business JSON datasets.

2. **Data Preprocessing (Python)**
   - Split the 7M review records into 10 smaller JSON files for efficient cloud upload and processing.

3. **Cloud Storage (AWS S3)**
   - Uploaded all JSON files into an S3 bucket.

4. **Data Warehousing (Snowflake)**
   - Created Snowflake tables for:
     - `tbl_yelp_review`
     - `tbl_yelp_businesses`
   - Loaded JSON data from S3 into Snowflake using IAM access credentials.
   - Used Snowflake SQL and Python for data ingestion and transformation.

5. **Sentiment Analysis**
   - Applied sentiment analysis on review text using:
     - Python (`TextBlob`)
     - Snowflake SQL functions
   - Categorized reviews into:
     - Positive
     - Neutral
     - Negative

6. **Data Transformation**
   - Extracted required attributes from JSON into structured tables.
   - Normalized business categories using `LATERAL SPLIT_TO_TABLE`.

7. **Analytics & Insights**
   - Executed advanced SQL queries to answer business-focused analytical questions.

---

## 🔍 Key Analytical Queries & Insights

- Number of businesses per category
- Top users reviewing restaurant businesses
- Most popular business categories based on reviews
- Top 3 most recent reviews per business
- Month with the highest number of reviews
- Percentage of 5-star reviews per business
- Top 5 most reviewed businesses in each city
- Average rating for businesses with ≥100 reviews
- Top users by number of reviews
- Top businesses with highest positive sentiment reviews

---

## 🛠️ Tools & Technologies Used

### Programming & Analysis
- Python (Data preprocessing, Sentiment Analysis)
- SQL (Advanced analytical queries)

### Cloud & Data Engineering
- AWS S3 (Data storage)
- Snowflake (Cloud Data Warehouse)

### Libraries
- TextBlob (Sentiment Analysis)
- JSON handling libraries

---

## 📈 Key Learnings
- Handling large-scale semi-structured data
- Designing cloud-based analytics pipelines
- Snowflake JSON ingestion and querying
- NLP-based sentiment analysis
- Writing complex analytical SQL using CTEs and window functions

---

## 📎 Future Enhancements
- Build dashboards using Tableau / Power BI
- Optimize queries using clustering in Snowflake
- Automate ingestion using Airflow
- Add CI/CD for data pipeline

---

## 📷 Project Screenshots
- Snowflake tables
- Sample SQL queries
- Sentiment distribution results
- S3 bucket structure

---

## 👤 Author
**Kavitha Lodagala**  
Aspiring Data Analyst | Analytics Engineer  
