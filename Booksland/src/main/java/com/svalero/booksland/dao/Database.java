package com.svalero.booksland.dao;

import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.sqlobject.SqlObjectPlugin;

import java.io.InputStream;
import java.util.Properties;

public class Database {

    private static Jdbi jdbi;

    private Database() {
    }

    public static void connect() {
        if (jdbi != null) {
            return;
        }

        try (InputStream input = Database.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (input == null) {
                throw new RuntimeException("No se encontró el archivo db.properties en resources");
            }

            Properties properties = new Properties();
            properties.load(input);

            String url = properties.getProperty("db.url");
            String user = properties.getProperty("db.user");
            String password = properties.getProperty("db.password");

            if (url == null || user == null || password == null) {
                throw new RuntimeException("Faltan propiedades de la base de datos en db.properties");
            }

            Class.forName("org.mariadb.jdbc.Driver");

            jdbi = Jdbi.create(url, user, password);
            jdbi.installPlugin(new SqlObjectPlugin());

        } catch (Exception e) {
            throw new RuntimeException("Error al inicializar la conexión con la base de datos", e);
        }
    }

    public static Jdbi getJdbi() {
        if (jdbi == null) {
            connect();
        }
        return jdbi;
    }

}