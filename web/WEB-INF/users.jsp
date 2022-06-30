<%-- 
    Document   : users
    Created on : 28-Jun-2022, 7:26:16 PM
    Author     : andre
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Users</title>
        <style>
            table {
                border-collapse: collapse;
                width: 100%;
            }

            td, th {
                border: 1px solid #dddddd;
                text-align: left;
                padding: 8px;
            }

            tr:nth-child(even) {
                background-color: #dddddd;
            }
        </style>
    </head>
    <body>
        <h1>Add User</h1>
        <form action="user" method="post">
            <input type="email" name="add_email" placeholder="Email">
            <br>
            <input type="checkbox" name="add_active" value="true">Active
            <br>
            <input type="text" name="add_first_name" placeholder="First Name">
            <br>
            <input type="text" name="add_last_name" placeholder="Last Name">
            <br>
            <input type="password" name="add_password" placeholder="Password">
            <br>
            <select name="add_roles" id="roles">
                <option value="system admin">system admin</option>
                <option value="regular user">regular user</option>
                <option value="company admin">company admin</option>
            </select>
            <br>
            <input type="hidden" name="action" value="add">
            <input type="submit" value="Save">
        </form>
        
        <h1>Manage Users</h1>
        <c:if test="${not empty userList}">
            <table>
                <tr>
                    <th>Email</th>
                    <th>Active</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Role</th>
                    <th>Edit</th>
                    <th>Delete</th>
                </tr>
                <c:forEach var="userList" items="${userList}">
                    <tr>
                        <td>${userList.email}</td>
                        <td>${userList.active}</td>
                        <td>${userList.first_name}</td>
                        <td>${userList.last_name}</td>
                        <td>${userList.role}</td>
                        <td><a href="user?action=edit&amp;email=${userList.email}">Edit</a></td>
<!--                        <td><a href="user?action=delete&amp;email=${userList.email}">Delete</a></td>-->
                        <td>
                            <c:url value="/user" var="urlDelete">
                                <c:param name="action" value="delete" />
                                <c:param name="email" value="${userList.email}" />
                            </c:url>
                            <a href=${urlDelete}>Delete</a>
                        </td>
                    </tr>
                </c:forEach>    
            </table>
        </c:if>
        
        <h1>Edit User</h1>
        <form action="user" method="post">
            <input type="email" name="edit_email" placeholder="Email">
            <br>
            <input type="checkbox" name="edit_active" value="">Active
            <br>
            <input type="text" name="edit_first_name" placeholder="First Name">
            <br>
            <input type="text" name="edit_last_name" placeholder="Last Name">
            <br>
            <select name="roles" id="roles">
                <option value="system admin">system admin</option>
                <option value="regular user">regular user</option>
                <option value="company admin">company admin</option>
            </select>
            <br>
            <input type="hidden" name="action" value="edit">
            <input type="submit" value="Save">
        </form>
    </body>
</html>
