# Booksland

Aplicación web desarrollada para las Prácticas Presenciales de la 2ª Evaluación de 1º DAW/DAM.

## Descripción

Este proyecto consiste en una aplicación web para la gestión de una tienda online de libros, permitiendo almacenar, consultar, modificar y eliminar información en una base de datos relacional en MariaDB.

La aplicación sigue el patrón **DAO (Data Access Object)** para separar la lógica de acceso a datos de la lógica de negocio.

## Objetivos del proyecto

El objetivo principal es desarrollar una aplicación web que permita interactuar con una base de datos relacional cumpliendo los requisitos propuestos en la actividad:

- Base de datos: Diseño del modelo relacional y creación mediante script SQL.
- Visualización: Interfaz en HTML/CSS con listado y vista detalle de tablas.
- Gestión: Formularios web para realizar el registro y borrado de información.
- Idioma: Traducción completa de todos los textos de la interfaz al inglés.
- Código: Uso de Git Flow en GitHub con README y Release 1.0.

## Tecnologías utilizadas

### Backend / servidor
- Java
- Jakarta Servlet API
- Apache Tomcat
- Maven

### Frontend
- HTML
- CSS
- Bootstrap
- JavaScript
- AJAX
- JSP

### Base de datos
- MariaDB
- MariaDB Java Client (JDBC Driver)

### Acceso a datos
- JDBI 3
- Patrón DAO

### Otras librerías
- Lombok

La base de datos está compuesta por 2 tablas relacionales:

- **book**
- **author**

Cada tabla incluye al menos los siguientes tipos de datos:
- Cadena de texto
- Número entero
- Número decimal
- Fecha
- Booleano

### Requisitos obligatorios
- Modelo Entidad-Relación.
- Listado de elementos y vista detalle.
- Registrar y eliminar información a través de un formulario.
- Traducir todos los textos de la aplicación web al inglés.
- Repositorio GitHub con Git Flow.

### Funcionalidades adicionales

- Modificar 
- Paginación en listados información de cualquier elemento desde su vista detalle.
- Búsqueda o filtrado sobre los listados de datos.
- Utilizar bootstrap para realizar la maquetación de la web.
- Realiza una maquetación responsive de la web.
- Permitir establecer relaciones entre datos de diferentes tablas.

## Puesta en marcha

### Requisitos previos
- JDK instalado
- Maven instalado
- Apache Tomcat configurado
- MariaDB en funcionamiento

### Pasos para ejecutar el proyecto
1. Iniciar Tomcat (startup.bat en Windows o startup.sh en Linux/macOS)
2. Desplegar con Maven
La primera vez con:
```
mvn tomcat7:deploy
```
Si estaba desplegado previamente y se ha realizado algún cambio:
```
mvn tomcat7:redeploy
```
3. Abrir el navegador y acceder a:
   ```text
   http://localhost:8080/Booksland
   ```

## Estructura del proyecto

La aplicación sigue una estructura basada en separación de responsabilidades:

* `src/main/java/com/svalero/booksland`
   * `dao`
     * `AuthorDAO.java`
     * `BookDAO.java`
     * `Database.java`
   * `mapper`
     * `AuthorMapper.java`
     * `BookMapper.java`
   * `model`
     * `Author.java`
     * `Book.java`
   * `servlet`
     * `DeleteAuthor.java`
     * `DeleteBook.java`
     * `EditAuthor.java`
     * `EditBook.java`
     * `ListAuthor.java`
     * `ListBook.java`
     * `ViewAuthor.java`
     * `ViewBooks.java`

Las páginas JSP se encuentran en:

* `src/main/webapp`
  * `includes`
    * `footer.jsp`
    * `header.jsp`
  * `WEB-INF`
    * `authors.jsp`
    * `books.jsp`
    * `edit-author.jsp`
    * `edit-book.jsp`
    * `index.jsp`
    * `view-author.jsp`
    * `view-book.jsp`

### Pasos de instalación
1. Clonar el repositorio:

```bash
git clone https://github.com/Practicas-San-Valero-2026/Booksland.git
```

2. Importar la base de datos en MariaDB usando el archivo SQL `dump-booksland.sql` ejecutando las peticiones en orden.

3. Configurar los datos de conexión a la base de datos en el archivo correspondiente:
- host
- puerto
- nombre de la base de datos
- usuario
- contraseña

4. Ejecutar el proyecto desde el entorno correspondiente.

5. Abrir la aplicación en el navegador.

## Autor

- Leo Mora Granado, Alejandro Reoyo Giménez y Daniel Azcárate Santafé
- Prácticas Presenciales 2ª Evaluación 1º DAM-DAW
- Curso 2025-2026
