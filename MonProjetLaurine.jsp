<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<%
    class Task {
        private String titre;
        private String description;
        private boolean terminee;
        private String dateEcheance;

        public Task(String titre, String description, String dateEcheance) {
            this.titre = titre;
            this.description = description;
            this.terminee = false;
            this.dateEcheance = dateEcheance;
        }

        public String getTitre() { return titre; }
        public String getDescription() { return description; }
        public boolean isTerminee() { return terminee; }
        public void setTerminee(boolean terminee) { this.terminee = terminee; }
        public String getDateEcheance() { return dateEcheance; }
    }

    ArrayList<Task> tasks = (ArrayList<Task>) session.getAttribute("tasks");
    if (tasks == null) {
        tasks = new ArrayList<Task>();
        session.setAttribute("tasks", tasks);
    }

    String action = request.getParameter("action");
    String titre = request.getParameter("titre");
    String description = request.getParameter("description");
    String dateEcheance = request.getParameter("dateEcheance");
    String indexParam = request.getParameter("index");

    if ("ajouter".equals(action) && titre != null && !titre.trim().equals("")) {
        tasks.add(new Task(titre, description, dateEcheance));
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
            backgroun: linear-gradient(135deg, #6a0dad, #9b30ff);
            padding: 20px;
            border-radius: 12px;
            text-align: center;
            box-shadow: 0 4px 8px rgba(0,0,0,0.3);
            font-size: 28px;
            font-weight: blod;
        }

        form {
            background-color: #8a2be2;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.2);
            color: #fff;
            margin-bottom: 30px;
        }

        form input[type="text"],
        form input[type="date"] {
            width: 95%;
            padding: 10px;
            margin-top: 5px;
            margin-bottom: 15px;
            border-radius: 6px;
            border: 1px solid #ccc;
            font-size: 15px;
        }

        form input[type="submit"] {
            padding: 10px 20px;
            border: none;
            background-color: #4b0082;
            color: #fff;
            font-weight: bold;
            border-radius: 6px;
            cursor: pointer;
            transitio: background 0.3s;
        }

        form input[type="submit"]:hover {
            background-color: #3a0066;
        }

        h2 {
            color: #333;
        }

        table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            border-radus: 12px;
            background-color: #fff;
            overflow: hidden;
            box-shadow:  0 2px 6px rgba(0,0,0,0.2);
        }

        th, td {
            padding: 12px;
            text-align: left;
        }

        th {
           background: linear-gradient(135deg, #6a0dad, #9b30ff); /* dégradé violet */
           color: #fff;
           font-size: 16px;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        ..actions input[type="submit"] {
            padding: 6px 12px;
            font-size: 13px;
            background-color: #2196F3;
            color: #fff;
            border-radius: 5px;
            transition: background 0.3s;
        }

        .actions input[type="submit"]:hover {
            background-color: #1976D2;
        }

        .terminee {
            background-color: #d9ffd9;
            color: green;
            font-weight: bold;
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
    <label>Date d’échéance :</label>
    <input type="date" name="dateEcheance" required>
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
            <th>Date d’échéance</th>
            <th>Actions</th>
        </tr>
<%
        for (int i = 0; i < tasks.size(); i++) {
            Task t = tasks.get(i);
%>
        <tr class="<%= t.isTerminee() ? "terminee" : "" %>">
            <td><%= t.getTitre() %></td>
            <td><%= t.getDescription() %></td>
            <td><%= t.getDateEcheance() %></td>
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



