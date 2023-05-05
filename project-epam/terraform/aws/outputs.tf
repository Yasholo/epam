output "compute_ip" {
    value = "${join(",", aws_instance.web.*.public_ip)}"
}
