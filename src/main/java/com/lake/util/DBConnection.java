package com.lake.util;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import java.sql.Connection;

/**
 * Centralised DB connection utility using HikariCP connection pool.
 * Credentials are read from environment variables so that no secrets
 * are hardcoded in source:
 *
 *   DB_URL  – e.g. jdbc:postgresql://localhost/onlinecamp
 *   DB_USER – e.g. postgres
 *   DB_PWD  – your PostgreSQL password
 *
 * Set these in Tomcat's setenv.sh (or your IDE run-config) before starting.
 */
public class DBConnection {

    private static final HikariDataSource dataSource;

    static {
        // Env-var lookups with localhost dev fallbacks
        String url  = getEnv("DB_URL",  "jdbc:postgresql://localhost/onlinecamp");
        String user = getEnv("DB_USER", "postgres");
        String pwd  = getEnv("DB_PWD",  "root");

        HikariConfig cfg = new HikariConfig();
        cfg.setJdbcUrl(url);
        cfg.setUsername(user);
        cfg.setPassword(pwd);
        cfg.setDriverClassName("org.postgresql.Driver");

        // Pool tuning
        cfg.setMinimumIdle(2);
        cfg.setMaximumPoolSize(10);
        cfg.setConnectionTimeout(30_000);   // 30 s
        cfg.setIdleTimeout(600_000);        // 10 min
        cfg.setMaxLifetime(1_800_000);      // 30 min
        cfg.setPoolName("OnlinecampPool");

        dataSource = new HikariDataSource(cfg);
    }

    /** Returns a pooled Connection. Callers must close() it (try-with-resources). */
    public static Connection getConnection() throws Exception {
        return dataSource.getConnection();
    }

    private static String getEnv(String key, String defaultValue) {
        String v = System.getenv(key);
        return (v != null && !v.isBlank()) ? v : defaultValue;
    }
}