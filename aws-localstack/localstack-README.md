## Getting Started:

1. Install [aws-cli](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) to configure a user profile ("localstack" or something) using this command:
     `aws configure --profile <profile_name>`
    Provide some dummy credentials:
     ```
      AWS Access Key ID [None]: test
      AWS Secret Access Key [None]: test
      Default region name [None]: us-east-1
      Default output format [None]: json
     ```
    You will now use this profile to create a s3 bucket in localstack for testing.  
2. Run `docker-compose up` to start localstack docker. Now you will use the following command to provision a bucket (named `demo-bucket` for test) in s3.
   `aws --endpoint-url http://localhost:4566 s3api create-bucket --bucket demo-bucket --acl public-read --profile <profile_name>`  
   Now you will have a s3 bucket ready in your localstack to test your lambda code.  
3. Install [aws-sam-cli](https://docs.aws.amazon.com/serverless-application-model/latest/developerguide/serverless-sam-cli-install.html) to test your lambda code locally.  
4. Start the server: `sam local start-api --docker-network host`  
5. Test your lambda functions: `curl -X <METHOD> -H 'key:value' http://localhost:3000/<function_path> -d '{"key":"value"}'`

Enjoy!
