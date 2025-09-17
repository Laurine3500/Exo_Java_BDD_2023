<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
<title>les conditions</title>
</head>
<body bgcolor=white>
<h1>Exercices sur les conditions</h1>
<form action="#" method="post">
    <p>Saisir la valeur 1 : <input type="text" id="inputValeur" name="valeur1">
    <p>Saisir la valeur 2 : <input type="text" id="inputValeur" name="valeur2">
    <p><input type="submit" value="Afficher">
</form>
<%-- Récupération des valeurs --%>
    <% String valeur1 = request.getParameter("valeur1"); %>
    <% String valeur2 = request.getParameter("valeur2"); %>

    <%-- Vérification de la condition entre les deux valeurs --%>
    <% if (valeur1 != null && valeur2 != null) { %>
        <%-- Conversion des valeurs en entiers pour la comparaison --%>
        <% int intValeur1 = Integer.parseInt(valeur1); %>
        <% int intValeur2 = Integer.parseInt(valeur2); %>
        
        <%-- Condition if pour comparer les valeurs --%>
        <% if (intValeur1 > intValeur2) { %>
            <p>Valeur 1 est supérieure à Valeur 2.</p>
        <% } else if (intValeur1 < intValeur2) { %>
            <p>Valeur 1 est inférieure à Valeur 2.</p>
        <% } else { %>
            <p>Valeur 1 est égale à Valeur 2.</p>
        <% } %>
   
    
<h2>Exercice 1 : Comparaison 1</h2>
<p>Ecrire un programme qui demande à l'utilisateur de saisir 3 valeurs (des chiffres),</br>
A, B et C et dites nous si la valeur de C est comprise entre A et B.</br>
Exemple :</br>
A = 10</br>
B = 20</br>
C = 15</br>
Oui C est compris entre A et B</p>

 <form action="#" method="post">
    <p>Saisir la valeur A : <input type="text" name="a"></p>
    <p>Saisir la valeur B : <input type="text" name="b"></p>
    <p>Saisir la valeur C : <input type="text" name="c"></p>
    <p><input type="submit" value="Vérifier"></p>
</form>

<%
    String sa = request.getParameter("a");
    String sb = request.getParameter("b");
    String sc = request.getParameter("c");

    if (sa != null && sb != null && sc != null &&
        !sa.isEmpty() && !sb.isEmpty() && !sc.isEmpty()) {

        try {
            int a = Integer.parseInt(sa);
            int b = Integer.parseInt(sb);
            int c = Integer.parseInt(sc);

            int min = Math.min(a, b);
            int max = Math.max(a, b);
%>
    <h2>Résultat :</h2>
    <p>
    <%
            if (c >= min && c <= max) {
    %>
        Oui, C (= <%= c %>) est compris entre A (= <%= a %>) et B (= <%= b %>).
    <%
            } else {
    %>
        Non, C (= <%= c %>) n'est pas compris entre A (= <%= a %>) et B (= <%= b %>).
    <%
            }
        } catch (NumberFormatException e) {
    %>
        <p style="color:red;">Veuillez saisir uniquement des nombres valides.</p>
    <%
        }
    }
%>

<h2>Exercice 2 : Pair ou Impair ?</h2>
<p>Écrivez un programme pour vérifier si un nombre est pair ou impair en utilisant une structure if</p>

<% } %>
<p><a href="index.html">Retour au sommaire</a></p>
</body>
</html>
