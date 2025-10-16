# 🚀 Flask Docker CI/CD

Este proyecto demuestra cómo construir una aplicación web simple con **Flask**, contenerizarla con **Docker**, automatizar su publicación mediante **GitHub Actions** y desplegarla fácilmente con **Docker Compose** en un entorno local o un *Home Lab*.

---

## 📋 Descripción del Proyecto

La aplicación consiste en un sencillo servidor web con Flask que devuelve un mensaje “Hola Mundo”.  
El objetivo principal es implementar un flujo completo de **CI/CD**:

1. Desarrollar y contenerizar la aplicación con Docker.  
2. Publicar el código en GitHub.  
3. Configurar un flujo automatizado de GitHub Actions que:
   - Construye la imagen Docker.
   - La publica en un registro de contenedores (Docker Hub o GHCR).
4. Desplegar automáticamente la última versión de la imagen en un servidor local utilizando Docker Compose.

---

## 🧩 Estructura del Proyecto

flask-docker-ci/
├── app/
│ ├── app.py
│ ├── requirements.txt
├── Dockerfile
├── docker-compose.yml
└── .github/
└── workflows/
└── ci.yml

---

## 🐍 Aplicación Flask

**Archivo:** `app/app.py`

```python
from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello():
    return "¡Hola Mundo desde Flask en Docker!"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
    
---

## 🐳 Contenerización con Docker
    
**Archivo:** `app/requirements.txt`

flask==3.0.3

`Dockerfile`

FROM python:3.11-slim
WORKDIR /app
COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY app .
EXPOSE 5000
CMD ["python", "app.py"]

**Construir y ejecutar localmente:**

docker build -t flask-hello .
docker run -p 5000:5000 flask-hello

---

🧰 Docker Compose para Desarrollo

**Archivo:** `docker-compose.yml`

version: "3.8"

services:
  web:
    image: flask-hello:latest
    build: .
    ports:
      - "5000:5000"

**Ejecutar en desarrollo:**

docker compose up --build

---

## ⚙️ Automatización con GitHub Actions

**Archivo:** `.github/workflows/ci.yml`

name: Build and Push Docker Image

on:
  push:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3

      - name: Login to Docker Hub
        uses: docker/login-action@v3
        with:
          username: ${{ secrets.DOCKERHUB_USERNAME }}
          password: ${{ secrets.DOCKERHUB_TOKEN }}

      - name: Build and push image
        uses: docker/build-push-action@v6
        with:
          push: true
          tags: ${{ secrets.DOCKERHUB_USERNAME }}/flask-hello:latest

---

## 🔐 Variables Secretas en GitHub

En GitHub → Settings → Secrets and variables → Actions → New repository secret:

DOCKERHUB_USERNAME: tu usuario de Docker Hub

DOCKERHUB_TOKEN: token generado desde tu cuenta de Docker Hub

Cuando hagas git push a main, GitHub Actions:

Construirá la imagen.

La subirá a Docker Hub.

---

## 🏠 Despliegue en Home Lab

1. crea un `docker-compose.yml:`

version: "3.8"

services:
  flask-app:
    image: tuusuario/flask-hello:latest
    container_name: flask-app
    ports:
      - "5000:5000"
    restart: unless-stopped

2. Ejecuta:

docker compose pull
docker compose up -d

👉 Tu aplicación quedará corriendo en http://<IP_DEL_HOME_LAB>:5000

---

## ✅ Resultado final

 - La app Flask se ejecuta correctamente en contenedor.

 - GitHub Actions automatiza la construcción y publicación.

 - Docker Compose permite desplegar fácilmente la última versión.
 
 ---
 
 👨‍💻 Autor

Reginaldo Pérez
Proyecto educativo y demostrativo de CI/CD con Flask y Docker.
💡 “Automatizar el despliegue es el primer paso hacia la verdadera eficiencia DevOps.”

---

📝 Licencia

Este proyecto se distribuye bajo la licencia MIT.
Consulta el archivo LICENSE
 para más detalles.
 





    

