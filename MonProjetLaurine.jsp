<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%

class Task {
  private String titre;
  private String description;
  private boolean terminee;

  public Task(String titre, String desciption){
    this.titre = titre;
    this.description = description;
    this.terminee = false;
  }
  public String getTitre() { return titre;}
  public String getDescription() {return description;}
  public boolean isTerminee() {return termine;}
  public void setTerminee(boolean terminee) { this.terminee = terminee; } 
}
java.util.List<Task> task = (java.util.List<Task>) session.getAttribute("tasks");
if (tasks == null){
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
