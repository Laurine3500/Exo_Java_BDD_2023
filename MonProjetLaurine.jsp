<%@ page contentType="text/html" pageEncoding="UTF-8" import="java.text.SimpleDateFormat,java.util.Date,java.util.ArrayList,java.util.List" %>
<%
    class Task {
        private String titre;
        private String description;
        private boolean terminee;
        private String dateCreation;

        public Task(String titre, String description) {
            this.titre = titre;
            this.description = description;
            this.terminee = false;
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
            this.dateCreation = sdf.format(new Date());
        }

        public String getTitre() { return titre; }
        public String getDescription() { return description; }
        public boolean isTerminee() { return terminee; }
        public void setTerminee(boolean terminee) { this.terminee = terminee; }
        public String getDateCreation() { return dateCreation; }
    }

    List<Task> tasks = (List<Task>) session.getAttribute("tasks");
    if (tasks == null) {
        tasks = new ArrayList<Task>();
        session.setAttribute("tasks", tasks);
    }

    String action = request.getParameter("action");
    String titre = request.getParameter("titre");
    String description = request.getParameter("description");
    String indexParam = request.getParameter("index");

    if ("ajouter".equals(action) && titre != null && !titre.trim().equals("")) {
        tasks.add(new Task(titre, description));
    } else if ("terminer".equals(action) && indexParam != null) {
        int index = Integer.parseInt(indexParam);
        if (index >= 0 && index < tasks.size()) {
            tasks.get(index).setTerminee(true);
        }
    } else if ("supprimer".equals(action) && indexParam != null) {
        int index = Integer.parseInt(indexParam);
        if (index >= 0 && index < tasks.size()) {
            tasks.remove(index);
        }
    }
%>

<html>
<head>
    <title>Mini Gestionnaire de Tâches</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 30px; background-color: #fafafa; }
        h1 { color: #333; }
        form { margin-bottom: 20px; }
        .form-container { background-color: violet; padding: 15px; border-radius: 8px; width: 400px; }
        .task { border: 1px solid #ccc; background-color: #fff; padding: 10px; margin-bottom: 8px; border-radius: 4px; }
        .terminee { color: green; font-weight: bold; }
        input[type="submit"] { margin-left: 5px; }
    </style>
</head>
<body>
<h1>Mini Gestionnaire de Tâches</h1>

<div class="form-container">
<form method="post">
    <input type="hidden" name="action" value="ajouter">
    <p>Titre : <input type="text" name="titre" required></p>
    <p>Description : <input type="text" name="description"></p>
    <p><input type="submit" value="Ajouter"></p>
</form>
</div>

<%
    if (tasks.isEmpty()) {
%>
    <p>Aucune tâche pour le moment.</p>
<%
    } else {
%>
<%
        for (int i = 0; i < tasks.size(); i++) {
            Task t = tasks.get(i);
%>
    <div class="task" <% if (t.isTerminee()) { %> style="color: green;" <% } %> >
        <strong><%= t.getTitre() %></strong> - <%= t.getDescription() %> (<%= t.getDateCreation() %>)
        <% if (!t.isTerminee()) { %>
            <form method="post" style="display:inline;">
                <input type="hidden" name="action" value="terminer">
                <input type="hidden" name="index" value="<%= i %>">
                <input type="submit" value="Terminer">
            </form>
        <% } %>
        <form method="post" style="display:inline;">
            <input type="hidden" name="action" value="supprimer">
            <input type="hidden" name="index" value="<%= i %>">
            <input type="submit" value="Supprimer">
        </form>
    </div>
<%
        }
%>
<%
    }
%>
</body>
</html>



