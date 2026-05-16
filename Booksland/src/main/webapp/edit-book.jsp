<%@ page import="com.svalero.booksland.model.Book" %>
<%@ page import="com.svalero.booksland.model.Author" %>
<%@ page import="java.util.List" %>
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
  List<Author> authors = (List<Author>) request.getAttribute("authors");

  boolean editMode = book != null;
%>

<main class="container py-5">
  <div class="row justify-content-center">
    <div class="col-12 col-lg-8">
      <div class="card shadow-sm border-0 rounded-4">
        <div class="card-header bg-transparent border-bottom-0 p-4">
          <h1 class="h3 mb-0">
            <!-- Changing title -->
            <%= editMode ? "Edit book" : "Add book" %>
          </h1>
        </div>

        <div class="card-body p-4">
          <form id="edit-book-form" action="<%= request.getContextPath() %>/edit-book" method="post">

            <% if (editMode) { %>
            <input type="hidden" name="id" value="<%= book.getId() %>">
            <% } %>

            <div class="mb-3">
              <label for="title" class="form-label">Title</label>
              <input type="text" class="form-control" id="title" name="title"
                     value="<%= editMode ? book.getTitle() : "" %>" required>
            </div>

            <div class="mb-3">
              <label for="genre" class="form-label">Genre</label>
              <input type="text" class="form-control" id="genre" name="genre"
                     value="<%= editMode ? book.getGenre() : "" %>" required>
            </div>

            <div class="mb-3">
              <label for="pages" class="form-label">Pages</label>
              <input type="number" min="1" class="form-control" id="pages" name="pages"
                     value="<%= editMode ? book.getPages() : "" %>" required>
            </div>

            <div class="mb-3">
              <label for="publisher" class="form-label">Publisher</label>
              <input type="text" class="form-control" id="publisher" name="publisher"
                     value="<%= editMode ? book.getPublisher() : "" %>" required>
            </div>

            <div class="mb-4">
              <label for="idAuthor" class="form-label">Author</label>

              <select class="form-select" id="idAuthor" name="idAuthor" required>
                <option value="">Select an author</option>

                <% if (authors != null) { %>
                <% for (Author author : authors) { %>
                <option value="<%= author.getId() %>"
                        <%= editMode && book.getIdAuthor() == author.getId() ? "selected" : "" %>>
                  <%= author.getName() %> <%= author.getLastName() %>
                </option>
                <% } %>
                <% } %>
              </select>
            </div>

            <div class="d-flex gap-2">
              <button type="submit" id="save-button" class="btn btn-secondary">
                <%= editMode ? "Save changes" : "Add book" %>
              </button>

              <a href="<%= request.getContextPath() %>/books" class="btn btn-outline-secondary">
                Cancel
              </a>
            </div>

          </form>

          <br/>

          <div id="result"></div>

        </div>
      </div>
    </div>
  </div>
</main>

<%@include file="includes/footer.jsp"%>