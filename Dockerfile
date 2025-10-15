# Imagen base
FROM python:3.11-slim

# Directorio de trabajo
WORKDIR /app

# Copiar dependencias y código
COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app .

# Puerto expuesto
EXPOSE 5000

# Comando de inicio
CMD ["python", "app.py"]
