# ECS_Terraform

This is for demostration purpose only. For production usage, many other aspection must be considered like secret management, secure state storage, etc, while most of them already has mature solutions which will not be described at here. 

Steps:
- Login with your root aws user, go to services - IAM, add a new user:
    - At least assign AccessType = "Programmatic access"
    - Assign Policies, for simplicity reason, just assign AmazonECS_FullAccess, CloudWatchFullAccess, AmazonEC2FullAccess, AmazonRDSFullAccess, IAMFullAccess
    - Save your Access Key ID and Secret Access Key, before you close your user creation page
- Download Terraform from https://www.terraform.io/downloads.html for your OS, unzip it and move it to a directory included in your system's PATH
- Execute:
    - Ensure network connection to AWS is ready
    - There are many ways to set Access Key ID and Secret Access Key to make terraform work properly. We just use the simplest way: set it into environment variables like what it is done in env.bat for Windows.
    - `terraform init`, which will initialize everything necessary for you including download cloud provider's CLI. The step is requred to be executed once if you have not executed it, while it has no bad impact to execute it many times since it is idempotent. 
    - `terraform apply -auto-approve`, which will create everything specified in the scripts in region `ca-central-1`. Endpoint of deployed API is printed in the same console after execution is done.
        - Notice: there is a bug in AWS CLI. So if you encounter this error describing "this is bug of provider" or something, just run `terraform apply -auto-approve` again and you will be fine.
        - Notice: for the first time deployment, AWS may need some time to create resources, so you need refresh the endpoint serveral times to get response.
    - `terraform destroy -auto-approve`, which deletes all objects created and described in scripts.
    
TODO:
- Automatically create DB instances, we need PG12 which is now only in AWS preview environment though.
- Change loadbalancer from CLB to ALB which has much more functionalities, e.g. canary deployment support.
- ...
