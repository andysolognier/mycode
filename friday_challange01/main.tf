terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 4.0.0"
    }
     random = {
      source  = "hashicorp/random"
      version = "~> 3.1.0"
    }
  }
}

provider "docker" {}

provider "random" {}

resource "docker_image" "nginx" {
  name         = "nginx:1.28"
  keep_locally = true       // keep image after "destroy"
}

# available from random.random_pet
resource "random_pet" "nginx" {
  length = 3
  separator = "_"
}

resource "docker_container" "nginx" {
  count = 2
  image = docker_image.nginx.image_id
  network_mode = "bridge"
  name  = "${random_pet.nginx.id}_${count.index}"
  ports {
    internal = 80
    external = 2224 + count.index
  }
}
