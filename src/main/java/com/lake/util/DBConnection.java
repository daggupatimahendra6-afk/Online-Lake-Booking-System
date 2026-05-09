package com.lake.util;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 * Simple JDBC connection utility.
 * Uses DriverManager directly (no HikariCP dependency) so it compiles
 * cleanly in any Eclipse/Tomcat setup without extra build-path config.
 *
 * DB credentials are read from environment variables with fallbacks:
 * DB_URL – e.g. jdbc:postgresql://localhost/onlinecamp
 * DB_USER – postgres
 * DB_PWD – root
 */
public class DBConnection {

    private static final String URL;
    private static final String USER;
    private static final String PWD;

    static {
        URL = getEnv("DB_URL", "jdbc:postgresql://ep-fragrant-sound-aq8ch43r-pooler.c-8.us-east-1.aws.neon.tech/neondb?sslmode=require");
        USER = getEnv("DB_USER", "neondb_owner");
        PWD = getEnv("DB_PWD", "npg_eo2Ckivh0jaL");

        // Load the PostgreSQL JDBC driver (required for older Tomcat versions)
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new ExceptionInInitializerError(
                    "PostgreSQL JDBC driver not found in WEB-INF/lib: " + e.getMessage());
        }
    }

    /**
     * Returns a new JDBC Connection.
     * Callers MUST close it (try-with-resources pattern).
     */
    public static Connection getConnection() throws Exception {
        return DriverManager.getConnection(URL, USER, PWD);
    }

    private static String getEnv(String key, String defaultValue) {
        String v = System.getenv(key);
        return (v != null && !v.isBlank()) ? v : defaultValue;
    }
}