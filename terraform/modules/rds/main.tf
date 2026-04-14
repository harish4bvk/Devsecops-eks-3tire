###########################################
############## RDS Module ##################
###########################################

resource "aws_db_instance" "main" {
  identifier              = "my-rds-instance"
  allocated_storage       = 20
  engine                  = "postgres"
  instance_class          = "db.t3.micro"

  db_name                 = var.db_name
  username                = var.db_username
  password                = var.db_password

  db_subnet_group_name    = aws_db_subnet_group.main.name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]

  publicly_accessible     = false
  skip_final_snapshot     = true

  max_allocated_storage   = 100
  backup_retention_period = 7

  tags = {
    Name = "my-rds-instance"
  }
}

##############################################
######## DB Subnet Group for RDS ##############
##############################################

resource "aws_db_subnet_group" "main" {
  name       = "rds-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "rds-subnet-group"
  }
}

#############################################
######## Security Group for RDS ##############
#############################################

resource "aws_security_group" "rds_sg" {
  name   = "rds-security-group"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]  # temp
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}