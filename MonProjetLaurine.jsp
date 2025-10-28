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
  
