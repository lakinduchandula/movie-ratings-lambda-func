import pandas as pd
import logging
import json

# initialize logger
logger = logging.getLogger()
logger.setLevel(logging.INFO)

def lambda_handler(event, context):
    
    try:
        # Load JSON data from event
        data = json.loads(event['body'])
    
        # Create pandas DataFrame
        df = pd.DataFrame(data['movies'])
    
    except Exception as e:
        # Handle the exception and return an error response

        # Log the error to cloudwatch
        logger.error('## Error: When creating pandas DataFrame; %s', str(e))

        return {
            'statusCode': 500,
            'body': 'Error: When creating pandas DataFrame: {}'.format(str(e))
        }
    
    try:
        # Calculate average rating
        avg_rating = average_rating(df)
    
    except Exception as e:
        # Handle the exception and return an error response

        # Log the error to cloudwatch
        logger.error('## Error: When calculating the average rating; %s', str(e))

        return {
            'statusCode': 500,
            'body': 'Error: When calculating the average rating: {}'.format(str(e))
        }

    try:
        # Director with most movies
        most_frequent_director = director_for_most_movies(df)

    except Exception as e:
        # Handle the exception and return an error response

        # Log the error to cloudwatch
        logger.error('## Error: When generating director who direct most movies; %s', str(e))

        return {
            'statusCode': 500,
            'body': 'Error: When generating director who direct most movies: {}'.format(str(e))
        }

    try:
        # Filter movies with above-average rating
        movies_above_average_rating = movies_are_above_avg_rating(df, avg_rating)
    
    except Exception as e:
        # Handle the exception and return an error response

        # Log the error to cloudwatch
        logger.error('## Error: When calculate movies above average rating; %s', str(e))

        return {
            'statusCode': 500,
            'body': 'Error: When calculate movies above average rating: {}'.format(str(e))
        }
    
    try:
        # Create the output dictionary
        output_dict = {
            "average_rating": float(avg_rating),
            "director_with_most_movies": most_frequent_director,
            "movies_above_average_rating": movies_above_average_rating
        }
        
        # Convert output_dict to JSON
        output_json = json.dumps(output_dict)

        # Log the output
        logger.info('## Response returned: %s', output_json)

        return {
            'statusCode': 200,
            'body': output_json
        }
        
    except Exception as e:
        # Handle the exception and return an error response

        # Log the error
        logger.error('## Error: When making the response after all processing; %s', str(e))

        return {
            'statusCode': 500,
            'body': 'Error: Error: When making the response after all processing: {}'.format(str(e))
        }

def average_rating(df):
    return df["rating"].mean()
    
def director_for_most_movies(df):
    """ 
    input dataFrame as df
    take unique count for every director
    return the director who has the most count
    
    special scenario -01 : if there are more than one director return list of directors
    special scenario -02 : if there there is no director more than direct one movie return all the directors

    """
    director_counts = df['director'].value_counts()
   
    max_director_count = director_counts.max()
    directors_with_most_movies = director_counts[director_counts == max_director_count].index.tolist()
    
    return directors_with_most_movies
    
def movies_are_above_avg_rating(df, avg_rating):
    return df[df["rating"] > avg_rating][["title", "director", "year", "rating", "genre"]].to_dict(orient="records")
    