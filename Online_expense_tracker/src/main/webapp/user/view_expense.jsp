<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page isELIgnored="false" %>
<%@ page import="java.util.List" %>
<%@page import="com.entity.User" %>
<%@ page import="com.dao.ExpenseDao" %>
<%@ page import="com.db.HibernateUtil" %>
<%@ page import="com.entity.Expense" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Viewing expense</title>
<%@include file="../components/all_css.jsp" %>
<style type="text/css">
.card-sh{
     box-shadow: 0 0 6px 0 rgba(0,0,0.3);
}
</style>
</head>
<body>
<c:if test="${empty loginUser}">
       <c:redirect url="../login.jsp"></c:redirect>
   </c:if>
<%@include file="../components/navbar.jsp" %>
  <div class="container">
    <div class="row">
    <div class="col-md-8 offset-md-2">
     <div class="card">
     <div class="card-header text-center">
       <p class="fs-3">All Expenses</p>
       
       <c:if test="${not empty msg}">
          <p class="text-center text-success fs-4">${msg}</p>
          <c:remove var="msg"/>
       </c:if>
     </div>
     <div class="card-body">
     <table class="table">
  <thead>
    <tr>
      <th scope="col">Title</th>
      <th scope="col">Description</th>
      <th scope="col">Date</th>
      <th scope="col">Time</th>
      <th scope="col">Price</th>
      <th scope="col">Action</th>
    </tr>
  </thead>
  <tbody>
  <%
                            User user = (User) session.getAttribute("loginUser");
                            if (user != null) {
                                ExpenseDao dao = new ExpenseDao(HibernateUtil.getSessionFactory());
                                List<Expense> list = null;
                                try {
                                    list = dao.getAllExpenseByUser(user);
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                                if (list != null && !list.isEmpty()) {
                                    for (Expense ex : list) {
                            %>
                            <tr>
                                <th scope="row"><%=ex.getTitle()%></th>
                                <td><%=ex.getDescription()%></td>
                                <td><%=ex.getDate() %></td>
                                <td><%=ex.getTime() %></td>
                                <td><%=ex.getPrice() %></td>
                                <td>
                                    <a href="edit_expense.jsp?id=<%=ex.getId() %>" class="btn btn-sm btn-primary me-1">Edit</a>
                                    <a href="../deleteExpense?id=<%=ex.getId() %>" class="btn btn-sm btn-danger me-1">Delete</a>
                                </td>
                            </tr>
                            <%
                                    }
                                } else {
                            %>
                            <tr>
                                <td colspan="6" class="text-center">No expenses found.</td>
                            </tr>
                            <%
                                }
                            } else {
                            %>
                            <tr>
                                <td colspan="6" class="text-center text-danger">User not logged in.</td>
                            </tr>
                            <%
                            }
                            %>
    
  </tbody>
</table>
     </div>
     </div>
    </div>
    </div>
  </div>


 
</body>
</html>