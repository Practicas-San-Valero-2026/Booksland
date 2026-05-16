<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.svalero.booksland.model.Author" %>
<%@ include file="includes/header.jsp"%>

<main>
    <%
        List<Author> authors = (List<Author>) request.getAttribute("authors");
        String search = (String) request.getAttribute("search");
        String error = request.getParameter("error");

        if (search == null) search = "";
    %>

    <% if ("author-has-books".equals(error)) { %>
    <div class="container mt-4">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            <strong>Author could not be deleted.</strong>
            This author has registered books. Delete those books first before removing the author.
        </div>
    </div>
    <% } %>

    <section class="py-4 text-center container">
        <div class="row py-lg-3">
            <div class="col-lg-8 col-md-10 mx-auto">
                <h1 class="fw-light">Authors</h1>
                <p class="lead text-body-secondary mb-3">
                    Have a look at available authors.
                </p>

                <div class="row justify-content-center mt-4 mb-3">
                    <div class="col-12 col-lg-10">
                        <form action="authors" method="get" class="row g-2">
                            <div class="col-md-5">
                                <input type="text" name="search" class="form-control"
                                       placeholder="Search by name..." value="<%= search %>">
                            </div>

                            <div class="col-md-2 d-grid">
                                <button type="submit" class="btn btn-primary">Search</button>
                            </div>

                            <div class="col-md-2 d-grid">
                                <a href="<%= contextPath %>/edit-author" class="btn btn-primary">
                                    Add author
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
                    if (authors != null && !authors.isEmpty()) {
                        for (Author author : authors) {
                %>
                <div class="col">
                    <div class="card shadow-sm h-100 border-0">
                        <div class="card-body d-flex flex-column">
                            <div class="d-flex justify-content-between align-items-start mb-3">
                                <h5 class="card-title mb-0"><%= author.getName() + " " + author.getLastName() %></h5>
                            </div>

                            <p class="card-text text-muted">
                                <%= author.getNationality() %>
                            </p>

                            <div class="mt-auto">
                                <div class="row g-2">
                                    <div class="col-4 d-grid">
                                        <a href="view-author?id=<%= author.getId() %>" class="btn btn-outline-primary">
                                            Details
                                        </a>
                                    </div>

                                    <div class="col-4 d-grid">
                                        <a href="edit-author?id=<%= author.getId() %>" class="btn btn-outline-warning">
                                            Edit
                                        </a>
                                    </div>

                                    <div class="col-4 d-grid">
                                        <a href="remove-author?id=<%= author.getId() %>"
                                           class="btn btn-outline-danger"
                                           onclick="return confirm('Are you sure you want to delete this author?');">
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
                        That author does not exist.
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