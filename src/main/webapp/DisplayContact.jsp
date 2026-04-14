<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.lake.entities.Contact" %>
<%
    /* ── Admin session guard ─────────────────────────────────────────────── */
    String _role = (session != null) ? (String) session.getAttribute("role") : null;
    if (!"admin".equals(_role)) {
        response.sendRedirect(request.getContextPath() + "/Login.jsp");
        return;
    }
%>
<%@ include file="AdminHeader.jsp" %>

<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Display Contacts — Admin</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f0f2f5; }
        .container { margin-top: 100px; }
        h2 { text-align: center; margin-bottom: 1.5rem; color: #1a56db; }
        table { width: 100%; border-collapse: collapse; background: white;
                border-radius: 12px; overflow: hidden;
                box-shadow: 0 2px 10px rgba(0,0,0,0.08); }
        thead tr { background: #e8f0fe; }
        th, td { padding: 12px 16px; text-align: center; border-bottom: 1px solid #eee; font-size: 14px; }
        th { color: #1a56db; font-size: 12px; text-transform: uppercase; letter-spacing: 0.5px; }
        tbody tr:hover { background: #fafcff; }
        .no-data { color: #e74c3c; }
    </style>
  </head>
<body>

<div class="container">
    <h2>📬 Contact Enquiries</h2>

    <table>
        <thead>
            <tr>
                <th scope="col">Name</th>
                <th scope="col">Email</th>
                <th scope="col">Message</th>
            </tr>
        </thead>

        <tbody>
        <%
            List<Contact> contacts = (List<Contact>) request.getAttribute("Contact");
            if (contacts == null || contacts.isEmpty()) {
        %>
            <tr>
                <td colspan="3" class="no-data">No Data Found!</td>
            </tr>
        <%
            } else {
                for (Contact C : contacts) {
                    String name  = C.getName();
                    String email = C.getEmail();
                    String mess  = C.getMessage();
        %>
            <tr>
                <td><%= name  %></td>
                <td><%= email %></td>
                <td><%= mess  %></td>
            </tr>
        <%
                }
            }
        %>
        </tbody>
    </table>
</div>

</body>
</html>