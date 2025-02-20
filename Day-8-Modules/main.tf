module "ec2-creation" {
    source = "../modules-EC2"
    #Below 3 parameters are passed to the module. 
    #Definitions inside modules-EC2/variable.tf
    ami_id = "ami-085ad6ae776d8f09c"
    type = "t2.medium"
    key = "key-n-virginia"
}

# If wrong variable name is passed, it will throw an error.
# If varaibale is not declared in source, it can not be passed from calling module.
# We can call source module with lesser values than defined in source module.