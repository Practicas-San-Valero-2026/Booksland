<%@page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.svalero.booksland.model.Author" %>
<%@ page import="com.svalero.booksland.model.Book" %>
<%@include file="includes/header.jsp"%>

<main class="container py-5">
  <%
    Author author = (Author) request.getAttribute("author");
    List<Book> books = (List<Book>) request.getAttribute("books");
  %>

  <% if (author != null) { %>
  <div class="row mb-5">
    <div class="col-lg-8">
      <h1 class="mb-3"><%= author.getName() + " " + author.getLastName() %></h1>
      <h2 class="mb-3"><%= author.getNationality() %></h2>
      <p class="lead text-muted"><%= author.getBiography() %></p>

      <div class="d-flex gap-2 flex-wrap">
        <a href="<%= request.getContextPath() %>/authors"
           class="btn btn-outline-secondary">
          Return to authors
        </a>
      </div>
    </div>
  </div>

  <section>
    <h2 class="h3 mb-4">Books written by this author</h2>

    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-3 g-4">
      <%
        if (books != null && !books.isEmpty()) {
          for (Book book : books) {
      %>
      <div class="col">
        <div class="card shadow-sm h-100 border-0">
          <div class="card-body d-flex flex-column">
            <h5 class="card-title"><%= book.getTitle() %></h5>
            <p class="card-text text-muted"><%= book.getGenre() %></p>

            <div class="d-grid">
              <a href="<%= request.getContextPath() %>/view-book?id=<%= book.getId() %>"
                 class="btn btn-outline-secondary btn-sm">
                See book
              </a>
            </div>
          </div>
        </div>
      </div>
      <%
        }
      } else {
      %>
      <div class="col-12">
        <div class="alert alert-info">
          There are not any books.
        </div>
      </div>
      <%
        }
      %>
    </div>
  </section>
  <% } else { %>
  <div class="alert alert-warning">
    Author not found.
  </div>
  <a href="<%= request.getContextPath() %>/authors"
     class="btn btn-outline-secondary">
    Return
  </a>
  <% } %>
</main>

<%@include file="includes/footer.jsp"%>