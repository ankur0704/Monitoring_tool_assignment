terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 2.25.0"
    }
  }
}
provider "docker" {}
# Create a Docker network for the monitoring stack
resource "docker_network" "monitoring_network" {
  name = "monitoring_network"
}

# Deploy Prometheus container
resource "docker_container" "prometheus" {
  name  = "prometheus_container"
  image = "prom/prometheus:latest"

  ports {
    internal = 9090
    external = 9090
  }
  networks_advanced {
    name = docker_network.monitoring_network.name
  }
  volumes {
    host_path = "C:\\Users\\VENU SONAVANE\\monitoringstack\\prometheus.yml"
    #update with absolute path
    container_path = "/etc/prometheus/prometheus.yml"
  }
}

# Deploy Grafana container
resource "docker_container" "grafana" {
  name  = "grafana_container"
  image = "grafana/grafana:latest"
  ports {

    internal = 3000
    external = 3000
  }
  networks_advanced {
    name = docker_network.monitoring_network.name
  }
}