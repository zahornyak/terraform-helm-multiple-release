module "releases" {
  source = "../../"

  charts = {
    nginx = {
      repository = "https://charts.bitnami.com/bitnami"
      version    = "18.2.0"
      namespace  = "default"
      values_file_vars = {
        tag = "latest"
      }
    }


    nginx2 = {
      repository = "https://charts.bitnami.com/bitnami"
      version    = "18.2.0"
      namespace  = "default"
      chart      = "nginx"
      sets = [
        {
          name  = "image.tag"
          value = "latest"
        },
        {
          name  = "readinessProbe.enabled"
          value = "true"
        }
      ]
      set_list = [
        {
          name  = "example.tags"
          value = ["latest", "example"]
        },
        {
          name  = "example.envs"
          value = ["prod", "staging"]
        }
      ]
      set_sensitive = [
        {
          name  = "example.password"
          value = "password"
        }
      ]
    }
  }
}








data "aws_eks_cluster" "cluster" {
  name = "${local.environment}-k8s"
}

data "aws_eks_cluster_auth" "cluster" {
  name = "${local.environment}-k8s"
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

provider "helm" {
  kubernetes {
    host = data.aws_eks_cluster.cluster.endpoint

    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}

provider "aws" {
  region = "eu-central-1"
}
