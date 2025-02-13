import os
import dlt
import duckdb

from dotenv import load_dotenv
from dlt.sources.helpers.rest_client import RESTClient
from dlt.sources.helpers.rest_client.paginators import PageNumberPaginator


@dlt.resource(name="rides", write_disposition="replace")
def ny_taxi(base_api_url):
    client = RESTClient(
        base_url=base_api_url,
        paginator=PageNumberPaginator(
            base_page=1,
            total_path=None
        )
    )

    for page in client.paginate():
        yield page


if __name__ == "__main__":
    
    print(f'WORKSHOP WITH dlt: {dlt.__version__}')
    
    load_dotenv()
    API_DLT_WORKSHOP = os.environ["API_DLT_WORKSHOP"]

    print(f'API_DLT_WORKSHOP: {API_DLT_WORKSHOP}')

    print("Performing dlt ETL...")

    pipeline = dlt.pipeline(
        pipeline_name="ny_taxi_pipeline",
        destination="duckdb",
        dataset_name="ny_taxi_data"
    )

    load_info = pipeline.run(ny_taxi(base_api_url=API_DLT_WORKSHOP))
    print(load_info)

    # Connect to the DuckDB database
    conn = duckdb.connect(f"{pipeline.pipeline_name}.duckdb")

    # Set search path to the dataset
    conn.sql(f"SET search_path = '{pipeline.dataset_name}'")

    # Describe the dataset
    print(conn.sql("DESCRIBE").df())

    df = pipeline.dataset(dataset_type="default").rides.df()
    print(df.info())
    print(df.describe())

    with pipeline.sql_client() as client:
        res = client.execute_sql(
                """
                SELECT
                AVG(date_diff('minute', trip_pickup_date_time, trip_dropoff_date_time))
                FROM rides;
                """
            )
        # Prints column values of the first row
        print(res)
