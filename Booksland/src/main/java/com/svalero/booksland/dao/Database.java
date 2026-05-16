package com.svalero.booksland.dao;

import org.jdbi.v3.core.Jdbi;
import org.jdbi.v3.sqlobject.SqlObjectPlugin;

import java.io.InputStream;
import java.util.Properties;

public class Database {

    public static Jdbi jdbi;

    private Database() {
    }

    public static void connect() {
        if (jdbi != null) {
            return;
        }

        try (InputStream input = Database.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (input == null) {
                throw new RuntimeException("There is not any db.properties file in the resources directory");
            }

            Properties properties = new Properties();
            properties.load(input);

            String url = properties.getProperty("db.url");
            String user = properties.getProperty("db.user");
            String password = properties.getProperty("db.password");

            if (url == null || user == null || password == null) {
                throw new RuntimeException("There are properties missing in the databse inside the file: db.properties");
            }

            Class.forName("org.mariadb.jdbc.Driver");

            jdbi = Jdbi.create(url, user, password);
            jdbi.installPlugin(new SqlObjectPlugin());

        } catch (Exception e) {
            throw new RuntimeException("Error trying to initialize the connection to the database", e);
        }
    }

    public static Jdbi getJdbi() {
        if (jdbi == null) {
            connect();
        }
        return jdbi;
    }

}