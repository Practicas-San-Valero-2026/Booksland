<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.svalero.booksland.model.Book" %>
<%@ include file="includes/header.jsp"%>

<main>
    <%
        List<Book> books = (List<Book>) request.getAttribute("books");
        String search = (String) request.getAttribute("search");

        if (search == null) search = "";
    %>

    <section class="py-4 text-center container">
        <div class="row py-lg-3">
            <div class="col-lg-8 col-md-10 mx-auto">
                <h1 class="fw-light">Books</h1>
                <p class="lead text-body-secondary mb-3">
                    Find out your favourite books.
                </p>

                <div class="row justify-content-center mt-4 mb-3">
                    <div class="col-12 col-lg-10">
                        <form action="books" method="get" class="row g-2">
                            <div class="col-md-5">
                                <input type="text" name="search" class="form-control"
                                       placeholder="Search by name..." value="<%= search %>">
                            </div>

                            <div class="col-md-2 d-grid">
                                <button type="submit" class="btn btn-primary">Search</button>
                            </div>

                            <div class="col-md-2 d-grid">
                                <a href="<%= contextPath %>/edit-book.jsp" class="btn btn-primary">
                                    Add book
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <div class="album pt-2 pb-5 bg-body-tertiary">
        <div class="container">
            <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
                <%
                    if (books != null && !books.isEmpty()) {
                        for (Book book : books) {
                %>
                <div class="col">
                    <div class="card shadow-sm h-100 border-0">
                        <div class="card-body d-flex flex-column">
                            <div class="d-flex justify-content-between align-items-start mb-3">
                                <h5 class="card-title mb-0"><%= book.getTitle() %></h5>
                            </div>

                            <p class="card-text text-muted">
                                <%= book.getGenre() %>
                            </p>

                            <div class="mt-auto">
                                <div class="row g-2">
                                    <div class="col-4 d-grid">
                                        <a href="view-book?id=<%= book.getId() %>" class="btn btn-outline-primary">
                                            Details
                                        </a>
                                    </div>

                                    <div class="col-4 d-grid">
                                        <a href="edit-book.jsp?id=<%= book.getId() %>" class="btn btn-outline-warning">
                                            Edit
                                        </a>
                                    </div>

                                    <div class="col-4 d-grid">
                                        <a href="remove-book?id=<%= book.getId() %>"
                                           class="btn btn-outline-danger"
                                           onclick="return confirm('Are you sure you want to delete this book?');">
                                            Delete
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                    }
                } else {
                %>
                <div class="col-12">
                    <div class="alert alert-info text-center">
                        There are no books available.
                    </div>
                </div>
                <%
                    }
                %>
            </div>
        </div>
    </div>
</main>

<%@include file="includes/footer.jsp"%>