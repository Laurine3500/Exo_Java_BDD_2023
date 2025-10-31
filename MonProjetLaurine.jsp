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
            font-family: "Segoe UI", "Roboto",sans-serif;
            margin: 0;
            background-color: #f8f9fb;
            padding: 0;
            color: #333;
        }
        .page-title {
            text-align: center;
            font-size: 28px;
            font-weight: bold;
            color: #6a0dad; 
            border: 3px solid #6a0dad;
            display: inline-block;
            padding: 15px 12px;
            border-radius: 12px;
            background-color: #f8f9fb;
            margin: 30px auto 20px auto;
            box-shadow: 0 2px 6px rgba(106,13,173,0.1); 
        }

        main{
            max-width: 900px;
            margin: 40px auto;
            background: #ffffff;
            padding: 30px 40px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.05);
        }

        h2 {
            color: #333;
            border-left: 5px solid #6a0dad;
            padding-left: 10px;
            margin-bottom: 20px;
        }

        form{
            margin-bottom: 25px;
        }

        form label{
            display: block;
            font-weight: 600;
            margin-top: 10px;
            color: #333;
        }

        form input[type="text"],
        form input[type="date"] {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc; 
            border-radius: 6px;
            margin-top: 5px;
            transition: all 0.2s ease-in-out;
        }

        form input[type="text"]:focus,
        form input[type="date"]:focus {
            border-color: #6a0dad;
            box-shadow: 0 0 3px rgba(106,13,173,0.3);
            outline: none;
        }

        form input[type="submit"] {
            margin-top: 15px;
            padding: 10px 18px;
            border: none;
            background-color: #6a0dad; 
            color: #fff;
            font-weight: bold;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        form input[type="submit"]:hover {
            background-color: #4b0082; 
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 10px;
        }

        th {
            background-color: #f0e6fa; 
            color: #4b0082;
            text-align: left;
            padding: 12px;
            font-weight: 600;
            border-bottom: 2px solid #ddd;
        }

        td {
            padding: 10px;
            border-bottom: 1px solid #eee;
        }

        tr:hover {
            background-color: #faf8ff; 
        }

         .terminee {
            background-color: #eafbea;
            color: #2e7d32;
        }

        .actions form {
            display: inline-block;  
            margin: 0 5px; 
        }

         .actions input[value="Supprimer"] {
            background-color: #e53935;
        }

        .actions input[value="Marquer terminé"]:hover {
            background-color: #1976d2;
        }

        .actions input[value="Supprimer"]:hover {
            background-color: #c62828;
        }

        footer {
            text-align: center;
            padding: 15px;
            margin-top: 40px;
            font-size: 14px;
            color: #4b0082;
            font-weignt: 500;
        }
    </style>
</head>
<body>

<h1>Mini Gestionnaire de Tâches</h1>

<main>
    <form method="post">
        <input type="hidden" name="action" value="ajouter">
        <label>Titre :</label>
        <input type="text" name="titre" required>

        <label>Description :</label>
        <input type="text" name="description">

        <label>Date d’échéance :</label>
        <input type="date" name="dateEcheance" required>

        <input type="submit" value="Ajouter la tâche">
    </form>

    <h2>Liste des tâches</h2>
    <%
        if (tasks.isEmpty()) {
    %>
        <p>Aucune tâche pour le moment.</p>
    <%
        } else {
    %>
        <!-- Tableau modernisé : fond clair, texte lisible -->
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
</main>

<footer>© 2025 - Mini Gestionnaire de Tâches | Laurine FILOCHE</footer>

</body>
</html>


