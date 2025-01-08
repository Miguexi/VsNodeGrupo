# Usamos Amazon Linux 2 como base
FROM amazonlinux:2
# Este comando establece la imagen base para el contenedor. En este caso, se utiliza Amazon Linux 2, una distribución basada en Red Hat.

# Actualizamos el sistema e instalamos dependencias necesarias
RUN yum update -y && \
    yum install -y git htop wget curl ruby tar && \
    yum clean all
# Se actualizan los paquetes del sistema con `yum update`.
# Luego se instalan herramientas comunes como `git` , `htop`, `wget` y `curl` (para descargas y solicitudes HTTP), `ruby` (interprete de Ruby), y `tar` (utilidad de archivos).
# Finalmente, se limpia la caché de `yum` para reducir el tamaño de la imagen.

# Configuramos el directorio de NVM
ENV NVM_DIR=/root/.nvm
# Define una variable de entorno que especifica la ubicación donde se instalará NVM (Node Version Manager).
ENV PATH=$NVM_DIR/versions/node/v16.20.0/bin:$PATH
# Añade la ubicación del ejecutable de Node.js al `PATH` del sistema para que esté disponible globalmente.

# Instalamos NVM, Node.js (versión 16 LTS) y PM2
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash && \
    . $NVM_DIR/nvm.sh && \
    nvm install 16.20.0 && \
    nvm use 16.20.0 && \
    nvm alias default 16.20.0 && \
    npm install -g pm2
# Descarga e instala NVM desde su repositorio oficial.
# Se utiliza NVM para instalar Node.js versión 16.20.0 (versión LTS).
# Se configura esta versión como la predeterminada (`nvm alias default`).
# Luego, se instala globalmente `pm2`, un administrador de procesos para Node.js.

# Clonamos el repositorio
RUN git clone https://github.com/JaviRabago/VsNodeGrupo.git /app
# Se clona el repositorio del proyecto desde GitHub en el directorio `/app`.

WORKDIR /app
# Cambia el directorio de trabajo del contenedor a `/app`, donde está el código de la aplicación.

# Instalamos las dependencias de la aplicación
RUN . $NVM_DIR/nvm.sh && npm install
# Se cargan las configuraciones de NVM y se instalan las dependencias definidas en el archivo `package.json` de la aplicación.

# Exponemos el puerto de la aplicación
EXPOSE 3000
# Declara que la aplicación utiliza el puerto 3000, permitiendo que el contenedor acepte conexiones en ese puerto.

# Ejecutamos la aplicación con PM2
CMD ["pm2-runtime", "start", "app.js", "--name=nodejs-express-app"]
# Define el comando que se ejecutará cuando el contenedor inicie.
# `pm2-runtime` gestiona el proceso en producción, ejecutando el archivo `app.js` y asignándole el nombre `nodejs-express-app`.
