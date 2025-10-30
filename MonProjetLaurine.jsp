<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%
    class Task {
        private String titre;
        private String description;
        private boolean terminee;

        public Task(String titre, String description) {
            this.titre = titre;
            this.description = description;
            this.terminee = false;
        }

        public String getTitre() { return titre; }
        public String getDescription() { return description; }
        public boolean isTerminee() { return terminee; }
        public void setTerminee(boolean terminee) { this.terminee = terminee; }
    }

    java.util.ArrayList<Task> tasks = (java.util.ArrayList<Task>) session.getAttribute("tasks");
    if (tasks == null) {
        tasks = new java.util.ArrayList<Task>();
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
    <meta charset="UTF-8">
    <title>Mini Gestionnaire de Tâches</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 30px; background-color: #f9f9f9; }
        h1 { color: #333; }
        form { margin-bottom: 20px; }
        input[type="text"] { padding: 5px; width: 250px; }
        input[type="submit"] { padding: 5px 10px; margin-left: 5px; }
        .task { border: 1px solid #ccc; background-color: #fff; padding: 10px; margin-bottom: 10px; border-radius: 5px; box-shadow: 1px 1px 5px rgba(0,0,0,0.1); }
        .task.done { background-color: #e0ffe0; text-decoration: line-through; }
        .actions { margin-top: 5px; }
        .actions form { display: inline; }
    </style>
</head>
<body>
<h1>Mini Gestionnaire de Tâches</h1>

<form method="post">
    <input type="hidden" name="action" value="ajouter">
    <p>Titre : <input type="text" name="titre" required></p>
    <p>Description : <input type="text" name="description"></p>
    <p><input type="submit" value="Ajouter"></p>
</form>

<h2>Liste des tâches</h2>
<%
    if (tasks.isEmpty()) {
%>
    <p>Aucune tâche pour le moment.</p>
<%
    } else {
        for (int i = 0; i < tasks.size(); i++) {
            Task t = tasks.get(i);
%>
    <div class="task <%= t.isTerminee() ? "done" : "" %>">
        <strong><%= t.getTitre() %></strong>
        <p><%= t.getDescription() %></p>
        <div class="actions">
            <% if (!t.isTerminee()) { %>
                <form method="post">
                    <input type="hidden" name="action" value="terminer">
                    <input type="hidden" name="index" value="<%= i %>">
                    <input type="submit" value="Marquer terminé">
                </form>
            <% } %>
            <form method="post">
                <input type="hidden" name="action" value="supprimer">
                <input type="hidden" name="index" value="<%= i %>">
                <input type="submit" value="Supprimer">
            </form>
        </div>
    </div>
<%
        }
    }
%>

</body>
</html>

