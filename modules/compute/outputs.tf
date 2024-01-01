output "web_server_ids" {
  value = [aws_instance.web-server-1.id, aws_instance.web-server-2.id]
}