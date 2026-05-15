<%@ page import="com.svalero.booksland.model.Book" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="includes/header.jsp"%>

<script>
  $(document).ready(function () {
    $("#edit-book-form").on("submit", function (event) {
      event.preventDefault();

      const form = this;

      if (!form.checkValidity()) {
        form.reportValidity();
        return;
      }

      if (!confirm("Are you sure you want to save this book?")) {
        return;
      }

      const data = new FormData(form);

      $("#save-button").prop("disabled", true);

      $.ajax({
        type: "POST",
        url: "<%= request.getContextPath() %>/edit-book",
        data: data,
        processData: false,
        contentType: false,
        cache: false,
        timeout: 600000,
        success: function (data) {
          $("#result").html(data);
          $("#save-button").prop("disabled", false);
        },
        error: function (error) {
          $("#result").html(error.responseText);
          $("#save-button").prop("disabled", false);
        }
      });
    });
  });
</script>

<%
  Book book = (Book) request.getAttribute("book");
%>

<main class="container py-5">
  <div class="row justify-content-center">
    <div class="col-12 col-lg-8">
      <div class="card shadow-sm border-0 rounded-4">
        <div class="card-header bg-transparent border-bottom-0 p-4">
          <h1 class="h3 mb-0">Edit book</h1>
        </div>

        <div class="card-body p-4">
          <% if (book != null) { %>
          <form id="edit-book-form" action="<%= request.getContextPath() %>/edit-book" method="post">
            <input type="hidden" name="id" value="<%= book.getId() %>">
            <input type="hidden" name="action" value="Modificar">

            <div class="mb-3">
              <label for="title" class="form-label">Title</label>
              <input type="text" class="form-control" id="title" name="title"
                     value="<%= book.getTitle() %>" required>
            </div>

            <div class="mb-3">
              <label for="genre" class="form-label">Genre</label>
              <input type="text" class="form-control" id="genre" name="genre"
                     value="<%= book.getGenre() %>" required>
            </div>

            <div class="mb-3">
              <label for="pages" class="form-label">Pages</label>
              <input type="number" min="1" class="form-control" id="pages" name="pages"
                     value="<%= book.getPages() %>" required>
            </div>

            <div class="mb-3">
              <label for="publisher" class="form-label">Publisher</label>
              <input type="text" class="form-control" id="publisher" name="publisher"
                     value="<%= book.getPublisher() %>" required>
            </div>

            <div class="mb-4">
              <label for="idAuthor" class="form-label">Author id</label>
              <input type="number" min="1" class="form-control" id="idAuthor" name="idAuthor"
                     value="<%= book.getIdAuthor() %>" required>
            </div>

            <div class="d-flex gap-2">
              <button type="submit" id="save-button" class="btn btn-primary">Save changes</button>
              <a href="<%= request.getContextPath() %>/view-book?id=<%= book.getId() %>"
                 class="btn btn-outline-secondary">
                Cancel
              </a>
            </div>
          </form>

          <br/>

          <div id="result"></div>

          <% } else { %>
          <div class="alert alert-warning">
            The book has not been found.
          </div>
          <a href="<%= request.getContextPath() %>/books" class="btn btn-outline-secondary">Return</a>
          <% } %>
        </div>
      </div>
    </div>
  </div>
</main>

<%@include file="includes/footer.jsp"%>