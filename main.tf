terraform {
  required_providers {
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 2.24.0"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

variable "app_replicas" {
  type    = number
  default = 3
}

resource "kubernetes_deployment" "redis" {
  metadata { name = "redis-deployment" }
  spec {
    replicas = 1
    selector { match_labels = { app = "redis" } }
    template {
      metadata { labels = { app = "redis" } }
      spec {
        container {
          name  = "redis"
          image = "redis:alpine"
          port { container_port = 6379 }
        }
      }
    }
  }
}

resource "kubernetes_service" "redis_service" {
  metadata { name = "redis-service" }
  spec {
    selector = { app = "redis" }
    port { port = 6379 }
  }
}

resource "kubernetes_deployment" "app" {
  metadata { name = "app-deployment" }
  spec {
    replicas = var.app_replicas
    selector { match_labels = { app = "hit-counter" } }
    template {
      metadata { labels = { app = "hit-counter" } }
      spec {
        container {
          name              = "hit-counter-app"
          image             = "hit-counter-app:latest"
          image_pull_policy = "Never"
          port { container_port = 5000 }
        }
      }
    }
  }
}

resource "kubernetes_service" "app_service" {
  metadata { name = "app-service" }
  spec {
    type     = "LoadBalancer"
    selector = { app = "hit-counter" }
    port { port = 5000 }
  }
}