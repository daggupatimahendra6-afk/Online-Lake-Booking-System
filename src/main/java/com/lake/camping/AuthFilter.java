package com.lake.camping;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * AuthFilter — intercepts all admin URLs and enforces admin-only access.
 * Any request to /Display* or /Dashboard* that does not carry an active
 * session with role="admin" is redirected to Login.jsp.
 */
@WebFilter(urlPatterns = {"/Display*", "/Dashboard*"})
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // no-op
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {

        HttpServletRequest  req  = (HttpServletRequest)  request;
        HttpServletResponse resp = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);
        String role = (session != null) ? (String) session.getAttribute("role") : null;

        if ("admin".equals(role)) {
            // Authorised — continue
            chain.doFilter(request, response);
        } else {
            // Not authenticated as admin — redirect to login
            String contextPath = req.getContextPath();
            resp.sendRedirect(contextPath + "/Login.jsp");
        }
    }

    @Override
    public void destroy() {
        // no-op
    }
}
