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

    <style>
        .hero-title {
            font-size: clamp(3rem, 7vw, 5.8rem);
            font-weight: 900;
            line-height: 0.95;
            letter-spacing: -0.04em;
            margin: 0;
            background: linear-gradient(90deg, #6b5746 0%, #8b7765 50%, #b29d88 100%);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            text-shadow: 0 6px 18px rgba(107, 87, 70, 0.10);
        }

        .btn-search {
            background-color: #a86b3c;
            border-color: #ef750e;
            color: #fff;
        }

        .btn-search:hover,
        .btn-search:focus,
        .btn-search:active {
            background-color: #af5100;
            border-color: #5c4b3d;
            color: #fff;
        }

        .btn-add-author {
            background-color: #8b7765;
            border-color: #8b7765;
            color: #fff;
        }

        .btn-add-author:hover,
        .btn-add-author:focus,
        .btn-add-author:active {
            background-color: #786555;
            border-color: #786555;
            color: #fff;
        }

        .btn-details {
            background-color: transparent;
            border-color: #a1866f;
            color: #a1866f;
        }

        .btn-details:hover,
        .btn-details:focus,
        .btn-details:active {
            background-color: #a1866f;
            border-color: #a1866f;
            color: #fff;
        }

        .btn-edit {
            background-color: transparent;
            border-color: #5b4a3b;
            color: #5b4a3b;
        }

        .btn-edit:hover,
        .btn-edit:focus,
        .btn-edit:active {
            background-color: #5b4a3b;
            border-color: #5b4a3b;
            color: #fff;
        }
    </style>

    <section class="py-4 text-center container">
        <div class="row py-lg-3">
            <div class="col-lg-8 col-md-10 mx-auto">
                <h1 class="hero-title">Authors</h1>
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
                                <button type="submit" class="btn btn-search">Search</button>
                            </div>

                            <div class="col-md-2 d-grid">
                                <a href="<%= contextPath %>/edit-author" class="btn btn-add-author">
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
                                        <a href="view-author?id=<%= author.getId() %>" class="btn btn-details">
                                            Details
                                        </a>
                                    </div>

                                    <div class="col-4 d-grid">
                                        <a href="edit-author?id=<%= author.getId() %>" class="btn btn-edit">
                                            Edit
                                        </a>
                                    </div>

                                    <div class="col-4 d-grid">
                                        <button href="remove-author?id=<%= author.getId() %>"
                                           class="btn btn-outline-danger"
                                           onclick="deleteAuthor(<%= author.getId() %>, this)">
                                            Delete
                                        </button>
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

<script>
    function deleteAuthor(id, button) {
        if (!confirm("Are you sure you want to delete this author?")) {
            return;
        }

        fetch("remove-author?id=" + id, {
            method: "GET"
        })
            .then(response => {
                if (response.ok) {
                    const card = button.closest(".col");
                    card.remove();
                } else if (response.status === 409) {
                    alert("This author cannot be deleted because they have registered books.");
                } else {
                    alert("Error deleting author");
                }
            })
            .catch(error => {
                console.error(error);
                alert("Connection error");
            });
    }
</script>

<%@include file="includes/footer.jsp"%>