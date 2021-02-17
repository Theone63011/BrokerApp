import boto3
import json
import os
import time

database_name = 'db1'
db_cluster_arn = 'arn:aws:rds:us-east-2:206325173947:cluster:database-2'
db_credentials_secrets_store_arn = 'arn:aws:secretsmanager:us-east-2:206325173947:secret:rds-db-credentials/cluster-CCSF2CA2VFUQTUFKUVPI6VIM4E/admin-S5kJVn'
rds_client = boto3.client('rds-data', region_name='us-east-2')

# Timing function executions
def timeit(f):
    def timed(*args, **kw):
        ts = time.time()
        result = f(*args, **kw)
        te = time.time()
        print(f'Function: {f.__name__}')
        print(f'*  execution time: {(te-ts)*1000:8.2f} ms')
        return result
    return timed


@timeit
def execute_statement(sql, sql_parameters=[]):
    response = rds_client.execute_statement(
        includeResultMetadata=True,
        secretArn=db_credentials_secrets_store_arn,
        database=database_name,
        resourceArn=db_cluster_arn,
        sql=sql,
        parameters=sql_parameters
    )
    return response


#TODO- continue here
