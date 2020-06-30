provider "aws" {          
  #access_key = ""        
  #secret_key = ""        
  region = "us-east-1"
}

resource "aws_instance" "east-frontend" {   
  count = 2
  availability_zone = "${var.us-east-zones[count.index]}"
  depends_on = ["aws_instance.east-backend"]     
  ami = "ami-039a49e70ea773ffc" 
  instance_type = "t2.micro"              
}                                                 
                                                  
resource "aws_instance" "east-backend" {               
  count = 2
  availability_zone = "${var.us-east-zones[count.index]}"                       
  ami = "ami-039a49e70ea773ffc" 
  instance_type = "t2.micro"              
}        

variable "us-east-zones" {                      
  default = ["us-east-1a", "us-east-1b"]
}

output "frontend_ip" {                                                                             
  value = "${list ("${aws_instance.east-frontend.*.public_ip}" ,"${aws_instance.east-frontend.*.public_dns}")}"                                                     
}                                                                                                  
                                                                                                   
output "backend_ips" {                                                                             
  value = "${list ("${aws_instance.east-backend.*.public_ip}" ,"${aws_instance.east-backend.*.public_dns}")}"
}                                                                                                  




