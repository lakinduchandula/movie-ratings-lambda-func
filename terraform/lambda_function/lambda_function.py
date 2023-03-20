import pandas as pd
import json

def lambda_handler(event, context):
    
    try:
        # Extract JSON data from request body
        json_data = json.loads(json.dumps(event['movies']))
    
        # Create Pandas DataFrame from JSON data
        df = pd.DataFrame(json_data)
    
        # Calculate average rating
        avg_rating = average_rating(df)
    
        # Director with most movies
        most_frequent_director = director_for_most_movies(df)
    
        # Filter movies with above-average rating
        movies_above_average_rating = movies_are_above_avg_rating(df, avg_rating)
    
        # Create the output dictionary
        output_dict = {
            "average_rating": float(avg_rating),
            "director_with_most_movies": most_frequent_director,
            "movies_above_average_rating": movies_above_average_rating
        }
    
        return output_dict
        
    except Exception as e:
        # Handle the exception and return an error response
        return {
            'statusCode': 500,
            'body': 'Error: {}'.format(str(e))
        }

def average_rating(df):
    return df["rating"].mean()
    
def director_for_most_movies(df):
    """ 
    input dataFrame as df
    take unique count for every director
    return the director who has the most count
    
    special scenario: if there are more than one director return list of directors
    
    """
    director_counts = df['director'].value_counts()
   
    max_director_count = director_counts.max()
    directors_with_most_movies = director_counts[director_counts == max_director_count].index.tolist()
    
    return directors_with_most_movies
    
def movies_are_above_avg_rating(df, avg_rating):
    return df[df["rating"] > avg_rating][["title", "director", "year", "rating", "genre"]].to_dict(orient="records")
    