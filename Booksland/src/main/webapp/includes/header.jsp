<%@page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <!-- Responsive -->
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>Booksland</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-sRIl4kxILFvY47J16cr9ZwB07vP4J8+LH7qKQnuqkuIAvNWLzeN8tE5YBujZqJLB" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

    <style>
        /* Responsive */
        @media (max-width: 768px) {
            body {
                font-size: 0.95rem;
            }

            .container {
                padding-left: 1rem;
                padding-right: 1rem;
            }

            header {
                text-align: center;
            }

            .nav {
                width: 100%;
            }

            .nav-link {
                padding-left: 0.75rem;
                padding-right: 0.75rem;
            }
        }

        .hero-title-header {
            font-size: clamp(3rem, 7vw, 5.8rem);
            font-weight: 900;
            line-height: 0.95;
            letter-spacing: -0.04em;
            margin: 0;
            background: linear-gradient(90deg, #fa7402 0%, #e18b3a 50%, #facda0 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            text-shadow: 0 6px 18px rgba(107, 87, 70, 0.10);
        }
    </style>
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
        <header class="d-flex flex-column flex-md-row align-items-center justify-content-between py-3 mb-4 border-bottom gap-3">

            <div class="d-flex align-items-center gap-2">
                <a href="<%= contextPath %>/" class="text-decoration-none text-body-emphasis fw-bold hero-title-header fs-4">
                    Booksland
                </a>
            </div>

            <ul class="nav nav-underline justify-content-center flex-wrap">
                <li class="nav-item">
                    <a href="<%= contextPath %>/"
                       class="nav-link px-2 <%= isHome ? "active fw-bold text-secondary" : "link-body-emphasis" %>">
                        Home
                    </a>
                </li>

                <li class="nav-item">
                    <a href="<%= contextPath %>/books"
                       class="nav-link px-2 <%= isBooks ? "active fw-bold text-secondary" : "link-body-emphasis" %>">
                        Books
                    </a>
                </li>

                <li class="nav-item">
                    <a href="<%= contextPath %>/authors"
                       class="nav-link px-2 <%= isAuthors ? "active fw-bold text-secondary" : "link-body-emphasis" %>">
                        Authors
                    </a>
                </li>
            </ul>

        </header>
    </div>