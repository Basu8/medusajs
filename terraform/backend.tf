terraform {
  backend "s3" {
    bucket         = "medusa-terraform-states"  
    key            = "medusa-ecs/terraform.tfstate" 
    region         = "ap-south-1"               
    encrypt        = true                      
    dynamodb_table = "terraform-lock"          
  }
}