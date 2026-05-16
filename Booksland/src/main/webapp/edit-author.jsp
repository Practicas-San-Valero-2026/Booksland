<%@ page import="com.svalero.booksland.model.Book" %>
<%@ page import="com.svalero.booksland.model.Author" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="includes/header.jsp"%>

<script>
    $(document).ready(function () {
        $("#edit-author-form").on("submit", function (event) {
            event.preventDefault();

            const form = this;

            if (!form.checkValidity()) {
                form.reportValidity();
                return;
            }

            if (!confirm("Are you sure you want to save this author?")) {
                return;
            }

            const data = new FormData(form);

            $("#save-button").prop("disabled", true);

            $.ajax({
                type: "POST",
                url: "<%= request.getContextPath() %>/edit-author",
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
    Author author = (Author) request.getAttribute("author");
%>

<main class="container py-5">
    <div class="row justify-content-center">
        <div class="col-12 col-lg-8">
            <div class="card shadow-sm border-0 rounded-4">
                <div class="card-header bg-transparent border-bottom-0 p-4">
                    <h1 class="h3 mb-0">Edit author</h1>
                </div>

                <div class="card-body p-4">
                    <% if (author != null) { %>
                    <form id="edit-author-form" action="<%= request.getContextPath() %>/edit-author" method="post">
                        <input type="hidden" name="id" value="<%= author.getId() %>">
                        <input type="hidden" name="action" value="Modificar">

                        <div class="mb-3">
                            <label for="title" class="form-label">Name</label>
                            <input type="text" class="form-control" id="name" name="name"
                                   value="<%= author.getName() %>" required>
                        </div>

                        <div class="mb-3">
                            <label for="genre" class="form-label">Last Name</label>
                            <input type="text" class="form-control" id="last_name" name="last_name"
                                   value="<%= author.getLastName() %>" required>
                        </div>

                        <div class="mb-3">
                            <label for="genre" class="form-label">Nationality</label>
                            <input type="text" class="form-control" id="nationality" name="nationality"
                                   value="<%= author.getNationality() %>">
                        </div>

                        <div class="mb-3">
                            <label for="biography" class="form-textarea">Biography</label>
                            <textarea class="form-control" id="biography" name="biography" rows="5">
                                <%= author.getBiography() != null ? author.getBiography() : "" %></textarea>
                        </div>

                        <div class="d-flex gap-2">
                            <button type="submit" id="save-button" class="btn btn-primary">Save changes</button>
                            <a href="<%= request.getContextPath() %>/view-author?id=<%= author.getId() %>"
                               class="btn btn-outline-secondary">
                                Cancel
                            </a>
                        </div>
                    </form>

                    <br/>

                    <div id="result"></div>

                    <% } else { %>
                    <div class="alert alert-warning">
                        The author has not been found.
                    </div>
                    <a href="<%= request.getContextPath() %>/authors" class="btn btn-outline-secondary">Return</a>
                    <% } %>
                </div>
            </div>
        </div>
    </div>
</main>

<%@include file="includes/footer.jsp"%>