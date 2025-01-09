# AWS CodeDeploy

**Trabajo realizado por:**
- Miguel Álvarez Garcés  
- Javier Rábago Montero  
- Manuel García Raya  

---

## Introducción a la herramienta

Para más detalles sobre la introducción a la herramienta, consulta el siguiente archivo:  
[Introducción a mi herramienta](introduccion.md)

---

## Cómo lanzar el pipeline

A continuación, se exponen los pasos para lanzar el pipeline utilizando AWS CodeDeploy:

1. **Crear un ECR mutable**  
   - Asigna un nombre al repositorio.  

2. **Configurar una máquina virtual de Linux**  
   - Abre una máquina virtual de Linux.  
   - Crea un fork del repositorio en el directorio de trabajo actual.  
   - Descarga e instala las herramientas necesarias:  
     - `awscli V2`  
     - `Docker`  
   - Configura AWS en la terminal utilizando el comando:  
     ```bash
     aws configure
     ```
     Introduce las credenciales y claves de acceso correspondientes.
![Imagen de WhatsApp 2025-01-07 a las 18 34 26_2dc2bf50](https://github.com/user-attachments/assets/b1232093-0f84-44e4-870b-92ce1f769707)

    - En aws pulsamos "ver push comands", los vamos copiando y pegando en la terminal Linux uno a uno, y posteriormente, se sube la imágen Dockerfile.

3. **Creamos un clúster**
   - Le ponemos el nombre

  4. **Crear una nueva definición de tareas**

   - Creamos un rol (EcsTaskExecutionRole) asociando las siguientes políticas:
     ![Imagen de WhatsApp 2025-01-07 a las 18 58 23_897e20e9](https://github.com/user-attachments/assets/493201b6-ffbe-44a1-b28f-9f58db6f12d8)
- Creamos una política llamada EcsTaskExecutionPolicy 

     ![Imagen de WhatsApp 2025-01-07 a las 19 02 56_ed966a09](https://github.com/user-attachments/assets/48da9977-00bf-4cd1-8c13-3daa7d1e07ba)

   - Y editamos la política de confianza:
     
      ![Imagen de WhatsApp 2025-01-07 a las 19 06 58_87abe5f4](https://github.com/user-attachments/assets/742c3e84-1e10-43d0-a3ba-bb7a45eb1505)

- Creamos una tarea(NodeJsTask):
![Imagen de WhatsApp 2025-01-07 a las 19 09 34_d06b44f7](https://github.com/user-attachments/assets/a6a5882a-827e-448c-a8d5-cd596006ca86)

![Imagen de WhatsApp 2025-01-07 a las 19 09 49_fdca2162](https://github.com/user-attachments/assets/662b6792-99e3-44a3-8f30-238780f01352)

5. **Crear servicio**
   - Lo primero que haremos será la configuración de subred para la tabla de enrutamiento, para asignarlas al servicio: 

  ![Imagen de WhatsApp 2025-01-07 a las 19 14 51_932ef543](https://github.com/user-attachments/assets/709af1c2-3ff0-4d41-997e-13e555b9a7db)


- Procedemos a crear el servicio:

  ![Imagen de WhatsApp 2025-01-07 a las 19 18 55_1b365610](https://github.com/user-attachments/assets/659a2f94-81e0-4559-8c2b-72da494fd44c)


  ![Imagen de WhatsApp 2025-01-07 a las 19 19 07_53a45bcb](https://github.com/user-attachments/assets/cbaf3f97-42ad-4b98-a886-1b818fdf297b)

![Imagen de WhatsApp 2025-01-07 a las 19 19 22_865232fb](https://github.com/user-attachments/assets/317dd578-0700-48c1-a4d8-cd34e1339d22)

![Imagen de WhatsApp 2025-01-07 a las 19 19 34_b96de310](https://github.com/user-attachments/assets/68451071-2be0-4734-953d-55c58433400c)

![Imagen de WhatsApp 2025-01-07 a las 19 20 05_617ab0af](https://github.com/user-attachments/assets/643ea6cf-eee4-4446-8ce9-9c1ee400012d)

- El resto de opciones se dejan default.
- Política de permisos CodeDeploy utilizada en el servicio: 

![Imagen de WhatsApp 2025-01-07 a las 19 23 47_83ee45df](https://github.com/user-attachments/assets/220acd9b-95fc-4b6a-99b0-1bdbc66dc8a0)

- Añadimos http como regla de entrada: 
![Imagen de WhatsApp 2025-01-07 a las 19 54 29_5ea168b7](https://github.com/user-attachments/assets/e048540e-694d-41e6-8ac4-760fd90c5989)

6. **Crear Pipeline**
   -Elegir custom y asignar roles ya creados (Copiar ARN del rol):
![Imagen de WhatsApp 2025-01-08 a las 16 14 33_e5556343](https://github.com/user-attachments/assets/88d649b0-59db-4ec3-a668-74c2e49ee4e5)

   ![Imagen de WhatsApp 2025-01-08 a las 16 04 23_cddc161d](https://github.com/user-attachments/assets/78a15678-02b7-4afd-a3a5-6133ccffe652)

   - Ponemos los comandos del mismo registro en la etapa de compilación:
  ![Imagen de WhatsApp 2025-01-08 a las 16 07 07_f167c37f](https://github.com/user-attachments/assets/1365ede4-b7d8-407a-b792-2deb0c569cf8)

![Imagen de WhatsApp 2025-01-08 a las 16 14 33_e5556343](https://github.com/user-attachments/assets/b1a7aceb-afd3-43a7-bb66-5283a3bfcbee)


7. **Editar y ejecutar el pipeline**

   - Editamos Deploy:
  ![Imagen de WhatsApp 2025-01-08 a las 16 22 54_89d80734](https://github.com/user-attachments/assets/91211f87-451e-4088-9526-07995bf51560)
- Editamos Build:

  
  - Añadimos las siguientes políticas de permisos al permiso del pipeline:
 
    ![Imagen de WhatsApp 2025-01-08 a las 16 27 00_f41b5d97](https://github.com/user-attachments/assets/33f4ebca-b0be-4936-89d2-36b0b3625a43)

- Por último, nos dirigiremos a la configuración de implementación, y seleccionamos que no tarde tiempo: 0s, 0 min, 0 h (De fábrica, pone que tarde una hora en realizarse)

     ![Imagen de WhatsApp 2025-01-08 a las 16 42 34_451dcfa1](https://github.com/user-attachments/assets/ddb91710-163a-41f6-b99e-363b36de99f6)

  - Una vez que hemos realizado estos pasos, si se realiza algún cambio en github, se lanza el pipeline.Al finalizar la fase de Deploy (última) en verde, comprobar que se ha actualizado la página web.

