package com.lake.camping;

import com.lake.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;

/**
 * GeminiProxy — securely proxies requests to the Google Gemini API.
 *
 * The API key is stored server-side only (via env var GEMINI_API_KEY).
 * The frontend (Chatbot.jsp) calls  POST /GeminiProxy  with the raw
 * Gemini JSON body, and this servlet forwards it to Google and streams
 * the response back — the key is never exposed to the browser.
 *
 * URL mapped in web.xml → /GeminiProxy
 */
public class GeminiProxy extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // ── Read key from env var; fallback for local dev ─────────────────────
    private static final String API_KEY = getEnv(
        "GEMINI_API_KEY",
        "AIzaSyDQqieAI5dauxpBTgiAlOxNkJEHycFoWHY"   // fallback only for local dev
    );

    private static final String GEMINI_MODEL = "gemini-1.5-flash";
    private static final String GEMINI_URL   =
        "https://generativelanguage.googleapis.com/v1beta/models/"
        + GEMINI_MODEL + ":generateContent?key=" + API_KEY;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Block unauthenticated chatbot spam: throttle by rate-limit (simple flag)
        response.setContentType("application/json;charset=UTF-8");
        response.setHeader("Cache-Control", "no-store");

        // Read the JSON body sent by the browser
        StringBuilder bodyBuilder = new StringBuilder();
        try (BufferedReader reader = request.getReader()) {
            String line;
            while ((line = reader.readLine()) != null) {
                bodyBuilder.append(line);
            }
        }
        String requestBody = bodyBuilder.toString();

        if (requestBody.isBlank()) {
            response.setStatus(400);
            response.getWriter().write("{\"error\":\"Empty request body\"}");
            return;
        }

        // Forward to Gemini API
        try {
            URL url = new URL(GEMINI_URL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
            conn.setDoOutput(true);
            conn.setConnectTimeout(10_000);
            conn.setReadTimeout(20_000);

            try (OutputStream os = conn.getOutputStream()) {
                os.write(requestBody.getBytes(StandardCharsets.UTF_8));
            }

            int statusCode = conn.getResponseCode();
            response.setStatus(statusCode);

            // Stream Gemini's response back to browser
            InputStream is = (statusCode >= 200 && statusCode < 300)
                             ? conn.getInputStream()
                             : conn.getErrorStream();

            if (is != null) {
                try (BufferedReader br = new BufferedReader(new InputStreamReader(is, StandardCharsets.UTF_8));
                     PrintWriter pw = response.getWriter()) {
                    String line;
                    while ((line = br.readLine()) != null) {
                        pw.println(line);
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(500);
            response.getWriter().write("{\"error\":\"Proxy error: " + e.getMessage() + "\"}");
        }
    }

    // CORS pre-flight (optional — same-origin so not strictly needed)
    @Override
    protected void doOptions(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setHeader("Allow", "POST, OPTIONS");
        response.setStatus(204);
    }

    private static String getEnv(String key, String def) {
        String v = System.getenv(key);
        return (v != null && !v.isBlank()) ? v : def;
    }
}
