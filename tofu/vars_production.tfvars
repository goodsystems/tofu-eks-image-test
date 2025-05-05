environment_name        = "production"
environment_slug        = "prd"
name                    = "Production"
cidr_block              = "172.31.0.0/16"
azs                     = ["us-east-1a", "us-east-1b", "us-east-1d"]
public_cidrs            = ["172.31.224.0/24", "172.31.225.0/24", "172.31.226.0/24"]
map_public_ip_on_launch = true
private_cidrs           = ["172.31.96.0/19", "172.31.128.0/19", "172.31.160.0/19"]