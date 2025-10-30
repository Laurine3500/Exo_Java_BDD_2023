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
    <div>
        <strong><%= t.getTitre() %></strong>
        <% if (t.isTerminee()) { %> <span>(Terminée)</span> <% } %>
        <p><%= t.getDescription() %></p>

        <% if (!t.isTerminee()) { %>
            <form method="post" style="display:inline;">
                <input type="hidden" name="action" value="terminer">
                <input type="hidden" name="index" value="<%= i %>">
                <input type="submit" value="Marquer terminé">
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
    }
%>

</body>
</html>

