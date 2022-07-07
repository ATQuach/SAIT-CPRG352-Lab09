<%-- 
    Document   : users
    Created on : 28-Jun-2022, 7:26:16 PM
    Author     : Andrew
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Users</title>
        <style>
            .addUser {
                float: left;
            }
            
            .manageUsers {
                float: left;
            }
            
            .editUser {
                float: left;
            }
                                
            table {
                border-collapse: collapse;
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
        <div class="addUser">
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
                <option value="1">system admin</option>
                <option value="2">regular user</option>
                <option value="3">company admin</option>
            </select>
            <br>
            <input type="hidden" name="action" value="add">
            <input type="submit" value="Add">
        </form>
        </div>
        <div class="manageUsers">
        <h1><center>Manage Users</center></h1>
        <c:if test="${not empty userList}">
            <table>
                <tr>
                    <th>Email</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Role</th>
                    <th>Active</th>
                    <th>Edit</th>
                    <th>Delete</th>
                </tr>
                <c:forEach var="userList" items="${userList}">
                    <tr>
                        <td>${userList.email}</td>
                        <td>${userList.firstName}</td>
                        <td>${userList.lastName}</td>
                        <td>${userList.role.roleName}</td>
                        <td>
                            <c:choose>
                                <c:when test="${userList.active}">
                                    <c:set var="Yes" value="true" />Yes
                                </c:when>
                                <c:otherwise>
                                    <c:set var="No" value="false" />No  
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <c:url value="/user" var="urlEdit">
                                <c:param name="action" value="edit" />
                                <c:param name="email" value="${userList.email}" />
                            </c:url>
                            <a href=${urlEdit}>Edit</a>
                        </td>
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
        </div>
        <div class="editUser">
        <h1>Edit User</h1>
        <form action="user" method="post">
            <input type="hidden" name="edit_email" placeholder="Email" value="${editUser.email}">
            <c:choose>
                <c:when test="${editUser.active == true}">
                    <input type="checkbox" name="edit_active" checked="checked" value="true" />
                </c:when>
                <c:otherwise>
                    <input type="checkbox" name="edit_active" value="true" />
                </c:otherwise>
            </c:choose>    
            Active
            <br>
            <input type="text" name="edit_first_name" placeholder="First Name" value="${editUser.firstName}">
            <br>
            <input type="text" name="edit_last_name" placeholder="Last Name" value="${editUser.lastName}">
            <br>
            <input type="hidden" name="edit_password" placeholder="Password" value="${editUser.password}">
            <select name="edit_roles">
                    <option value="1" <c:if test="${editUser.role.roleId == 1 }">selected</c:if>>system admin</option>
                    <option value="2" <c:if test="${editUser.role.roleId == 2 }">selected</c:if>>regular user</option>
                    <option value="3" <c:if test="${editUser.role.roleId == 3 }">selected</c:if>>company admin</option>
            </select>
            <br>
            <input type="hidden" name="action" value="edit">
            <input type="submit" value="Update">
        </form>
        </div>
    </body>
</html>
