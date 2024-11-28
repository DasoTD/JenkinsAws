output "jenkins_public_ip" {
  description = "Public IP of Jenkins server"
  value       = aws_instance.capstonewithjenkins.public_ip
}

output "jenkins_url" {
  description = "URL to access Jenkins"
  value       = "http://${aws_instance.capstonewithjenkins.public_ip}:8080"
}

output "ssh_command" {
  description = "SSH command to connect to Jenkins server"
  value       = "ssh -i ../keys/jenkins-key.pem ubuntu@${aws_instance.capstonewithjenkins.public_ip}"
}