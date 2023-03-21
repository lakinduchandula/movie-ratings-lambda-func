
# Movie Rating Lambda Function

Project was focused on Terraform and Python. The tasks involved creating an AWS infrastructure using Terraform and implementing a Python function to perform operations on a JSON input.

This project required creating an AWS infrastructure consisting of an API Gateway, a Lambda function, and an IAM role with appropriate permissions. The API Gateway was configured to trigger the Lambda function upon receiving a POST request and the Lambda function was responsible for processing the JSON input and performing various operations.

## Install python packages
01. Virtual python enviroment was created using [pipenv](https://pipenv.pypa.io/en/latest/).
Once it's done can generate requirements.txt file:
```bash
pipenv requirements > requirements.txt
```

02. Install the requests library to a new package directory:
```bash
pip install --target ./infrastructure/package/python -r requirements.txt
```

## Configure AWS CLI
03. If you didn't configure AWS CLI then [install aws cli](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) and follow steps:
```bash
aws configure
```
```console
AWS Access Key ID [****************FUVH]: <Paste Access Key ID>
AWS Secret Access Key [****************ysCp]: <Paste Secret Access Key>
```

- You can get the appropriate aws credentials through AWS IAM

## Initialize Terraform
04. Change the directory to initialize terraform:
```bash
cd ./terraform
```

## Plan Terraform
05. Now run a plan to see what Terraform will attempt to provision:
```bash
terraform plan
```

## Apply Terraform
06. Once you’re happy with the proposed changes, apply Terraform:
```bash
terraform apply
```

## Go to the URL output of Terraform
07. After Terraform has completed running, you’ll get an output with the URL for the API gateway endpoint:

It will look something like this:![terraform_output_endpoint](https://user-images.githubusercontent.com/71013438/226530456-fb3872e7-c89b-4c07-afdb-47b289254530.jpg)

## Test the solution
Since this is a POST request, the URL cannot be accessed through a web browser. Instead, tools like [Postman](https://www.postman.com/downloads/) can be used to send a POST request and receive a response in the expected JSON format.

## Steps to use Postman
    1. Open Postman and click on the "New" button to create a new request.
    2. Select "POST" from the dropdown list of HTTP methods.
    3. Enter the URL of the endpoint that you copied from the terminal.
    4. Click on the "Body" tab below the URL field.
    5. Select "raw" and "JSON" from the radio buttons and paste your JSON content into the text box.
    6. Click on the "Send" button to send the POST request.
    7. Once the request is sent, you will see the response in the "Response" tab below the request information.
    8. You can use the response to verify that the request was successful and to parse any data that was returned from the server.

## Final output will be similar to this screenshot
![postman_final_out](https://user-images.githubusercontent.com/71013438/226533680-764548c5-72da-479d-8ba9-8627933434a3.jpg)

## NOTE : Python package download

Please note that when using `pip` to install Python packages, there may be instances where the package may not be downloaded correctly to the Linux environment. In such cases, manual downloading of the package may be necessary.

![python_pkg_download](https://user-images.githubusercontent.com/71013438/226535201-85d77538-5eac-4e23-859d-895b06f384ec.jpg)

- Yellow colour manylinux package is the ideal package for aws lambda environment.

- But when I download packages in Windows OS, `pip` download the Green colour package, which caused errors.

- `I had to manually download the required pandas and related packages and zipped it.`

