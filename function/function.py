
ALLOWED_CONTENT_TYPES = ['application/html', 'application/json']

def lambda_handler(event, context):
    
    if event['httpMethod'] != 'GET':
        return {
            'statusCode': 405,
            'body': 'Method not allowed'
        }
    
    CONTENT_TYPE = (
        event['headers']['Content-Type'] 
        if 'headers' in event and 'Content-Type' in event['headers'] 
        else 'application/html'
    )
    
    if CONTENT_TYPE not in ALLOWED_CONTENT_TYPES:
        return {
            'statusCode': 406,
            'body': 'Unsupported content type'
        }
    
    body = ''

    match CONTENT_TYPE:
        case 'application/html':
            body = 'Hello World'
        case 'application/json':
            body = { 'message': 'Hello World' }

    return {
        'statusCode': 200,
        'body': body
    }