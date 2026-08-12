#Andy Solognier
#Bellow code will create a docker container with nginx image which is a web server and will be listening on port 2224
# terraform and docker
terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 4.0.0"
    }
  }
}

provider "docker" {}

#We must first create the image by declaring the version we want to download and keep_locally is so that the image is downloaded and kept
resource "docker_image" "nginx" {
  name         = "nginx:1.19.6"
  keep_locally = true    // keep image after "destroy"
}
#With the image downloaded we can now create a docket with that image below and set external port to 2224
resource "docker_container" "nginx" {
  image = docker_image.nginx.image_id
  network_mode = "bridge"
  name  = "tutorial"
  ports {
    internal = 80
    external = 2224
  }
}
