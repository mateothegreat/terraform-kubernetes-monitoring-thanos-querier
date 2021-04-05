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

            name     = "mlfabric-devops-logging-1"
            hostname = "af7e0d9c77bc9419f8aa338095d6d428-3051e57738548442.elb.us-east-1.amazonaws.com"
            port     = 10901

        }, {

            name     = "maa-ml-cam-ingest-prod"
            hostname = "ab485332ee2514c12a3ea4f0b07f30d8-9a41c6be8fabb246.elb.us-east-1.amazonaws.com"
            port     = 10901

        }, {

            name     = "maa-ml-cam-ingest-staging"
            hostname = "a8b7ad6268172498d8c8a698f2de741e-ce620c89268b6759.elb.us-east-1.amazonaws.com"
            port     = 10901

        }

    ]

}
