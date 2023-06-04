import unittest

from function import lambda_handler

class TestLambdaFunction(unittest.TestCase):

    def test_success_for_http_get(self):
        resp = lambda_handler(
            event={
                'httpMethod': 'GET',
                'path': '/',
                'headers': {
                    'Content-Type': 'application/html',
                    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3',
                },
                'body': None,
            }, 
            context=None
        )

        self.assertEqual(resp['statusCode'], 200)
        self.assertEqual(resp['body'], 'Hello World') 

    def test_error_for_non_http(self):
        resp = lambda_handler(
            event={
                'httpMethod': 'GET',
                'path': '/',
                'headers': {
                    'Content-Type': 'application/json',
                    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3',
                },
                'body': None,
            }, 
            context=None
        )

        self.assertEqual(resp['statusCode'], 406)
        self.assertEqual(resp['body'], 'Only HTML is supported') 

    def test_error_for_non_get(self):
        resp = lambda_handler(
            event={
                'httpMethod': 'POST',
                'path': '/',
                'headers': {
                    'Content-Type': 'application/html',
                    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3',
                },
                'body': None,
            }, 
            context=None
        )

        self.assertEqual(resp['statusCode'], 405)
        self.assertEqual(resp['body'], 'Method not allowed') 


if __name__ == '__main__':
    unittest.main()
