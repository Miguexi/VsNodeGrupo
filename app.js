// Importamos el módulo 'express'
const express = require('express');

// Creamos una instancia de la aplicación Express
const app = express();

// Configuramos la dirección IP del servidor
const hostname = '0.0.0.0'; // Dirección IP para escuchar solicitudes (acepta conexiones de cualquier origen)

// Configuramos el puerto en el que se ejecutará el servidor
const port = 3000; // Puerto donde estará disponible la aplicación

// Definimos la versión de la aplicación
const version = '4'; // Identificador de versión para el servidor

// Configuramos una ruta para manejar solicitudes GET al endpoint raíz ('/')
app.get('/', (req, res) => {
    // Enviamos una respuesta HTML cuando se accede al endpoint raíz
    res.send(`<html>
                <body>
                    <h1 style="color:blue;text-align: center;margin-top: 100px;"> [Version ${version}]: Home page</h1>
                    <div style="position: fixed;top: 50%;left: 50%;transform: translate(-50%, -50%)">
                        <img src="https://picsum.photos/400/400?random=1">
                    </div>
                </body>
               </html>`);
    // Registramos en la consola que se recibió una nueva solicitud
    console.log(`[Version ${version}]: New request => http://${hostname}:${port}` + req.url);
});

// Iniciamos el servidor y lo configuramos para escuchar en el puerto especificado
app.listen(port, () => {
    // Mostramos en la consola que el servidor está corriendo
    console.log(`[Version ${version}]: Server running at http://${hostname}:${port}/`);
});
