resource "kubernetes_service" "querier" {

    metadata {

        name      = var.name
        namespace = var.namespace

        labels = {

            app = var.name

        }

    }

    spec {

        selector = {

            app = var.name

        }

        port {

            name        = "gprc"
            port        = 10901
            target_port = 10901

        }

        port {

            name        = "http"
            port        = 10902
            target_port = 10902

        }

    }

}
