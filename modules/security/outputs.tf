output "security_group_id" {
  description = "ID of the k3s security group"
  value       = aws_security_group.k3s.id
}

output "instance_profile_name" {
  description = "Name of the instance profile to attach to the EC2 instance"
  value       = aws_iam_instance_profile.node.name
}