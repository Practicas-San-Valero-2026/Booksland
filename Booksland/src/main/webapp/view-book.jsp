<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.svalero.booksland.model.Book" %>
<%@ page import="com.svalero.booksland.model.Author" %>
<%@include file="includes/header.jsp"%>

<main class="container py-5">
    <%
        Book book = (Book) request.getAttribute("book");
        Author author = (Author) request.getAttribute("author");
    %>

    <% if (book != null) { %>
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card shadow-sm border-0">
                <div class="card-body p-4">
                    <h1 class="mb-4"><%= book.getTitle() %></h1>

                    <div class="mb-3">
                        <h2 class="h5 text-muted mb-1">Genre</h2>
                        <p class="mb-0"><%= book.getGenre() %></p>
                    </div>

                    <div class="mb-3">
                        <h2 class="h5 text-muted mb-1">Pages</h2>
                        <p class="mb-0"><%= book.getPages() %></p>
                    </div>

                    <div class="mb-3">
                        <h2 class="h5 text-muted mb-1">Publisher</h2>
                        <p class="mb-0"><%= book.getPublisher() %></p>
                    </div>

                    <div class="mb-4">
                        <h2 class="h5 text-muted mb-1">Author</h2>
                        <p class="mb-0">
                            <%= (author != null) ? author.getName() + " " + author.getLastName() : "Unknown author" %>
                        </p>
                    </div>

                    <div class="d-flex gap-2 flex-wrap">
                        <a href="<%= request.getContextPath() %>/books"
                           class="btn btn-outline-secondary">
                            Return to books
                        </a>

                        <a href="<%= request.getContextPath() %>/edit-book?id=<%= book.getId() %>"
                           class="btn btn-outline-secondary">
                            Edit book
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <% } else { %>
    <div class="alert alert-warning">
        Book not found.
    </div>
    <a href="<%= request.getContextPath() %>/books"
       class="btn btn-outline-secondary">
        Return
    </a>
    <% } %>
</main>

<%@include file="includes/footer.jsp"%>