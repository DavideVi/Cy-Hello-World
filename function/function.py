
def lambda_handler(event, context):
    
    if event['httpMethod'] != 'GET':
        return {
            'statusCode': 405,
            'body': 'Method not allowed'
        }
    
    if 'headers' in event and 'Content-Type' in event['headers']:
        if event['headers']['Content-Type'] != 'application/html':
            return {
                'statusCode': 406,
                'body': 'Only HTML is supported'
            }

    response = {
        'statusCode': 200,
        'body': 'Hello World'
    }

    return response