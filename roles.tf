// role for EKS cluster -----------------

resource "aws_iam_role" "myClusterRole" {
  name               = "${var.cluster-name}-role"
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}



resource "aws_iam_role_policy_attachment" "aws-provided-policy-basic" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.myClusterRole.name
}



resource "aws_iam_role_policy_attachment" "aws-provided-policy-vpc-controlller" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.myClusterRole.name
}

// -------------------------




// role for NodeGroup ----------

resource "aws_iam_role" "myNodeGroup-role" {
  name = "eks-node-group-${var.cluster-name}-role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "aws-provided-policy-vpc-controlller-workerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.myNodeGroup-role.name
}



resource "aws_iam_role_policy_attachment" "aws-provided-policy-cni-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.myNodeGroup-role.name
}



resource "aws_iam_role_policy_attachment" "aws-provided-policy-ecr-readonly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.myNodeGroup-role.name
}

// -------------------------