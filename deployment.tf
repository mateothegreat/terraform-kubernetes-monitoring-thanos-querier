resource "kubernetes_deployment" "querier" {

    metadata {

        name      = var.name
        namespace = var.namespace

        labels = {

            app = var.name

        }

    }

    spec {

        replicas = 1

        selector {

            match_labels = {

                app = var.name

            }

        }

        template {

            metadata {

                labels = {

                    app = var.name

                }

            }

            spec {

                node_selector = var.node_selector

                affinity {

                    pod_anti_affinity {

                        preferred_during_scheduling_ignored_during_execution {

                            weight = 100

                            pod_affinity_term {

                                label_selector {

                                    match_expressions {

                                        key      = "app.kubernetes.io/name"
                                        operator = "In"
                                        values   = [ var.name ]

                                    }

                                }

                                namespaces = [ var.namespace ]

                                topology_key = "kubernetes.io/hostname"

                            }

                        }

                    }

                }

                container {

                    name  = var.name
                    image = var.image

                    security_context {

                        run_as_user  = 65534
                        run_as_group = 65534

                    }

                    args = concat([

                        "query",
                        "--query.replica-label=prometheus_replica",
                        "--query.replica-label=thanos_ruler_replica",
                        "--web.external-prefix=${ var.ingress_path }"

                    ], [ for t in var.store_apis : "--store=${ t.hostname }:${ t.port }" ])

                    port {

                        name           = "grpc"
                        container_port = 10901

                    }

                    port {

                        name           = "http1"
                        container_port = 10902

                    }

                    port {

                        name           = "http2"
                        container_port = 9090

                    }

                    liveness_probe {

                        failure_threshold = 4

                        http_get {

                            path   = "/-/healthy"
                            port   = 10902
                            scheme = "HTTP"

                        }

                        period_seconds = 30

                    }

                    readiness_probe {

                        failure_threshold = 20

                        http_get {

                            path   = "/-/healthy"
                            port   = 10902
                            scheme = "HTTP"

                        }

                        period_seconds = 5

                    }

                    resources {

                        requests = {

                            cpu    = var.prometheus_request_cpu
                            memory = var.prometheus_request_memory

                        }

                        limits = {

                            cpu    = var.prometheus_limit_cpu
                            memory = var.prometheus_limit_memory

                        }

                    }

                }

            }

        }

    }


}
