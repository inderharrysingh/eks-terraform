
output "endpoint" {
  value = aws_eks_cluster.myCluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.myCluster.certificate_authority[0].data
}