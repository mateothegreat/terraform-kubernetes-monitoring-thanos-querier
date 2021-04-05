resource "kubernetes_ingress" "ingress" {

    count = var.ingress_enabled ? 1 : 0

    metadata {

        name      = var.name
        namespace = var.namespace

        annotations = {

            "nginx.ingress.kubernetes.io/whitelist-source-range" = var.ingress_whitelist
            "nginx.ingress.kubernetes.io/auth-type"              = "basic"
            "nginx.ingress.kubernetes.io/auth-secret"            = length(var.username) > 0 && length(var.password) > 0 ? "${ var.name }-basicauth" : null
            "nginx.ingress.kubernetes.io/auth-realm"             = "Authentication Required"
            "nginx.ingress.kubernetes.io/rewrite-target"         = "${ var.ingress_path }/$2"
            "nginx.ingress.kubernetes.io/use-regex"              = true

        }

    }

    spec {

        rule {

            http {

                path {

                    path = "${ var.ingress_path }(/|$)(.*)"

                    backend {

                        service_name = var.name
                        service_port = 10902

                    }

                }

            }

        }

    }

}
