# Usamos una imagen de base como node
FROM node:latest AS build

# Ponemos el directorio de trabajo en /app
WORKDIR /app

# Copiamos los json para instalar las dependencias
COPY package*.json ./

# Instalamos las dependencias
RUN npm install

# Copiamos los archivos de la app al docker
COPY . .

# Construimos la app del docker gracias a npm
RUN npm run build

# Ahora utilizamos una imagen de apache
FROM httpd:latest

# Copiamos el build de antes en el htdocs de apache
COPY --from=build /app/build/ /usr/local/apache2/htdocs/

EXPOSE 80