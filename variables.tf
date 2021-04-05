variable "name" {

    type        = string
    description = "prometheus operated name"

}

variable "namespace" {

    type        = string
    description = "prometheus operated namespace"

}

variable "external_labels" {

    type        = map(string)
    description = "labels to add to metrics when queried externally"
    default     = null

}

variable "image" {

    type        = string
    description = "thanos query image"
    default     = "quay.io/thanos/thanos:v0.19.0"

}

variable "store_apis" {

    description = "list of remote store api's to query from"

    type = list(object({

        name     = string
        hostname = string
        port     = number

    }))

}

variable "path" {

    type = string
    description = "http path"
    default = "/"

}


variable "s3_aws_access_key_id" {

    type    = string
    default = ""

}

variable "s3_aws_secret_access_key" {

    type    = string
    default = ""

}

variable "s3_bucket" {

    type    = string
    default = ""

}

variable "s3_endpoint" {

    type    = string
    default = "s3.us-east-1.amazonaws.com"

}


variable "prometheus_request_cpu" {

    type        = string
    description = "requested cpu"
    default     = "200m"

}

variable "prometheus_request_memory" {

    type        = string
    description = "requested memory"
    default     = "200Mi"

}

variable "prometheus_limit_cpu" {

    type        = string
    description = "cpu limit"
    default     = "250m"

}

variable "prometheus_limit_memory" {

    type        = string
    description = "memory limit"
    default     = "250Mi"

}

variable "prometheus_retention" {

    type        = string
    description = "retention period (i.e.: 6h)"
    default     = "24h"

}

variable "prometheus_version" {

    type        = string
    description = "https://github.com/prometheus/prometheus/releases"
    default     = "v2.25.2"

}

variable "prometheus_storage" {

    type        = string
    description = "storage amount for prometheus"
    default     = "40Gi"

}

variable "prometheus_scrape_interval" {

    type        = string
    description = "how often to scrape endpoints"
    default     = "30s"

}

variable "prometheus_node_selector" {

    type        = map(string)
    description = "labels to determine which node we run on"
    default     = {}

}

variable "prometheus_loadbalancer_enabled" {

    type        = bool
    description = "if enabled creates a LoadBalancer service to access the prometheus ui/api"
    default     = false

}

variable "prometheus_loadbalancer_internal" {

    type        = bool
    description = "if enabled creates a LoadBalancer service to access the prometheus ui/api"
    default     = false

}

variable "thanos_loadbalancer_enabled" {

    type        = bool
    description = "if enabled creates a LoadBalancer service to access the (thanos) prometheus ui/api"
    default     = false

}

variable "thanos_loadbalancer_internal" {

    type        = bool
    description = "if enabled creates a LoadBalancer service to access the (thanos) prometheus ui/api"
    default     = false

}


variable "node_selector" {

    type        = map(string)
    description = "labels to determine which node we run on"
    default     = {}

}

variable "loadbalancer_enabled" {

    type        = bool
    description = "if enabled creates a LoadBalancer service to access the prometheus ui/api"
    default     = false

}

variable "loadbalancer_internal" {

    type        = bool
    description = "if enabled creates a LoadBalancer service to access the prometheus ui/api"
    default     = false

}

variable "ingress_enabled" {

    type        = bool
    description = "if enabled creates an ingress mapping at /promtetheus (requires an ingress-controller)"
    default     = false

}

variable "ingress_whitelist" {

    type        = string
    description = "comma-delimited cidr block(s) to lock the ingress down to"
    default     = "0.0.0.0/0"

}

variable "ingress_path" {

    type        = string
    description = "http path to the ingress"
    default     = "/thanos"

}

variable "username" {

    type        = string
    description = "username to login with (basic auth)"

}

variable "password" {

    type        = string
    description = "username to login with (basic auth)"

}
