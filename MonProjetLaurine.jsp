<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.Date, java.text.SimpleDateFormat" %>
<%
    class Task {
        private String titre;
        private String description;
        private boolean terminee;
        private String dateHeure;

        public Task(String titre, String description) {
            this.titre = titre;
            this.description = description;
            this.terminee = false;
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
            this.dateHeure = sdf.format(new Date());
        }

        public String getTitre() { return titre; }
        public String getDescription() { return description; }
        public boolean isTerminee() { return terminee; }
        public void setTerminee(boolean terminee) { this.terminee = terminee; }
        public String getDateHeure() { return dateHeure; }
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
        body {
            font-family: Arial, sans-serif;
            margin: 30px;
            background-color: #f5f5f5;
        }
        h1 {
            color: #fff;
            background-color: #6a0dad;
            padding: 15px;
            border-radius: 8px;
            text-align: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }

        form {
            background-color: #6a0dad;
            padding: 15px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            color: #fff;
            margin-bottom: 20px;
        }

        form input[type="text"] {
            width: 95%;
            padding: 8px;
            margin-top: 5px;
            margin-bottom: 10px;
            border-radius: 5px;
            border: 1px solid #ddd;
            font-size: 14px;
        }

        form input[type="submit"] {
            padding: 8px 15px;
            border: none;
            background-color: #4b0082;
            color: #fff;
            font-weight: bold;
            border-radius: 5px;
            cursor: pointer;
        }

        form input[type="submit"]:hover {
            background-color: #3a0066;
        }

        h2 {
            color: #333;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 1px 1px 5px rgba(0,0,0,0.1);
        }

        th, td {
            border: 1px solid #ccc;
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #6a0dad;
            color: #fff;
        }

        .actions form {
            display: inline;
        }

        .actions input[type="submit"] {
            padding: 5px 10px;
            font-size: 12px;
            background-color: #2196F3;
            color: #fff;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }

        .actions input[type="submit"]:hover {
            background-color: #1976D2;
        }
    </style>
</head>
<body>

<h1>Mini Gestionnaire de Tâches</h1>

<form method="post">
    <input type="hidden" name="action" value="ajouter">
    <label>Titre :</label>
    <input type="text" name="titre" required>
    <label>Description :</label>
    <input type="text" name="description">
    <input type="submit" value="Ajouter">
</form>

<h2>Liste des tâches</h2>
<%
    if (tasks.isEmpty()) {
%>
    <p>Aucune tâche pour le moment.</p>
<%
    } else {
%>
    <table>
        <tr>
            <th>Titre</th>
            <th>Description</th>
            <th>Date et Heure</th>
            <th>Actions</th>
        </tr>
<%
        for (int i = 0; i < tasks.size(); i++) {
            Task t = tasks.get(i);
%>
        <tr>
            <td><%= t.getTitre() %></td>
            <td><%= t.getDescription() %></td>
            <td><%= t.getDateHeure() %></td>
            <td class="actions">
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
            </td>
        </tr>
<%
        }
%>
    </table>
<%
    }
%>

</body>
</html>


