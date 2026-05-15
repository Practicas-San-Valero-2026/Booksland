<%@page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Booksland</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>

    <%
    String contextPath = request.getContextPath();
    String currentPath = request.getRequestURI();

boolean isHome = currentPath.equals(contextPath + "/") || currentPath.equals(contextPath + "/home");
boolean isBooks = currentPath.startsWith(contextPath + "/books");
boolean isAuthors = currentPath.startsWith(contextPath + "/authors");
%>

<div class="container">
    <header class="d-flex flex-wrap align-items-center justify-content-between py-3 mb-4 border-bottom">
        <div class="col-md-3 mb-2 mb-md-0 d-flex align-items-center gap-2">
        </div>

        <ul class="nav nav-underline col-12 col-md-auto mb-2 justify-content-center mb-md-0">
            <li>
                <a href="<%= contextPath %>/"
                   class="nav-link px-2 <%= isHome ? "active fw-bold text-secondary" : "link-body-emphasis" %>">
                    Home
                </a>
            </li>
            <li>
                <a href="<%= contextPath %>/books"
                   class="nav-link px-2 <%= isBooks ? "active fw-bold text-secondary" : "link-body-emphasis" %>">
                    Books
                </a>
            </li>
            <li>
                <a href="<%= contextPath %>/authors"
                   class="nav-link px-2 <%= isAuthors ? "active fw-bold text-secondary" : "link-body-emphasis" %>">
                    Authors
                </a>
            </li>
        </ul>
    </header>