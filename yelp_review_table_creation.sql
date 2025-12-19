create or replace table yelp_reviews (review_text variant);

COPY INTO yelp_reviews
FROM 's3://kavitha-s3-da/yelp/'
CREDENTIALS = (
    AWS_KEY_ID = 'xxx'
    AWS_SECRET_KEY = 'xxx'
)
FILE_FORMAT = (TYPE = JSON);

select * from yelp_reviews limit   100;

CREATE OR REPLACE FUNCTION analyze_sentiment(text STRING)
RETURNS STRING
LANGUAGE PYTHON
RUNTIME_VERSION = '3.9'
PACKAGES = ('textblob') 
HANDLER = 'sentiment_analyzer'
AS $$
from textblob import TextBlob
def sentiment_analyzer(text):
    analysis = TextBlob(text)
    if analysis.sentiment.polarity > 0:
        return 'Positive'
    elif analysis.sentiment.polarity == 0:
        return 'Neutral'
    else:
        return 'Negative'
$$;


Create or replace table tbl_yelp_review as
select review_text:business_id::string as business_id,
review_text:date::date as review_date,
review_text:user_id::string as user_id,
review_text:stars::number as review_stars,
review_text:text::string as review_text,
analyze_sentiment(review_text) as sentiments
from yelp_reviews;

select * from tbl_yelp_review;


