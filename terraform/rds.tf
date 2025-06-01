resource "aws_db_instance" "medusa" {
  identifier               = "medusa-db"
  engine                   = "postgres"
  engine_version           = "15.13" 
  instance_class           = "db.t3.micro"
  allocated_storage        = 20
  username                 = var.db_username
  password                 = var.db_password
  db_name                  = "medusa"
  db_subnet_group_name     = aws_db_subnet_group.medusa.name
  vpc_security_group_ids   = [aws_security_group.rds.id]  
  publicly_accessible      = false
  skip_final_snapshot      = true

  tags = {
    Name = "medusa-db"
  }
}
