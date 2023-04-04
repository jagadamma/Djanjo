provider "kubernetes" {
 config_path = "/root/.kube/config"
}
resource "kubernetes_deployment" "djanjo" {
 metadata {
 name = "djano"
 labels = {
 name = "polls"
 }
 }
 spec {
 replicas = 2
 selector {
 match_labels = {
 name = "webapp"
 }
 }
 template {
 metadata {
 labels = {
  name = "webapp"
 }
 }
 spec {
 container {
 image = "jagadamma/python:latest"
 name = "simple-webapp"
 port {
 container_port = 8000
 }
 }
 }
 }
 }
}

resource "kubernetes_service" "webapp-service" {
 metadata {
 name = "webapp-service"
 }

 spec {
 selector = {
 name = "polls"
 }
 port {
 port = 8000
 target_port = 8000
 node_port = 30080
 }

 type = "LoadBalancer"
 }
}
