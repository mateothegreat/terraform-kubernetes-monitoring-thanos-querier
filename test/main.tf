variable "cluster_name" {}

#
# Retrieve authentication for kubernetes from aws.
#
provider "aws" {}

#
# Get kubernetes cluster info.
#
data "aws_eks_cluster" "cluster" {

    name = var.cluster_name

}

#
# Retrieve authentication for kubernetes from aws.
#
data "aws_eks_cluster_auth" "cluster" {

    name = var.cluster_name

}

provider "kubernetes" {

    host  = data.aws_eks_cluster.cluster.endpoint
    token = data.aws_eks_cluster_auth.cluster.token

    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[ 0 ].data)

}

provider "kubernetes-alpha" {

    host  = data.aws_eks_cluster.cluster.endpoint
    token = data.aws_eks_cluster_auth.cluster.token

    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[ 0 ].data)

}
module "monitoring-thanos-query" {

    source = "../"

    name              = "thanos-querier"
    namespace         = "m-1"
    path              = "/"
    username          = "admin"
    password          = "password"
    ingress_enabled   = true
    ingress_path      = "/thanos-query"
    ingress_whitelist = "0.0.0.0/0"

    store_apis = [

        {

            name     = "test-1"
            hostname = "thanos-sidecar"
            port     = 10901

        }

    ]

}
