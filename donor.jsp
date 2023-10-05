<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "jakarta.servlet.http.*,jakarta.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<% String email = request.getParameter("email"); %>

<sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver"
                   url = "jdbc:mysql://localhost:3306/Food_Consumption"
                   user = "root"  password = "Sid@2002"/>


<sql:query dataSource = "${snapshot}" var = "uname">
    SELECT * from user where email = "<%=email%>";
</sql:query>

<sql:query dataSource = "${snapshot}" var = "food">
    SELECT * from food where reg_email = "<%=email%>" ;
</sql:query>

<sql:query dataSource = "${snapshot}" var = "afood">
    SELECT * from food where reg_email = "<%=email%>" and (status = "New" or status ="Rejected" or status ="Completed") ;
</sql:query>

<sql:query dataSource = "${snapshot}" var = "nfood">
    SELECT * from food where reg_email = "<%=email%>" and status = "New" ;
</sql:query>

<sql:query dataSource = "${snapshot}" var = "rfood">
    SELECT * from food where reg_email = "<%=email%>" and status = "Rejected" ;
</sql:query>

<sql:query dataSource = "${snapshot}" var = "cfood">
    SELECT * from food where reg_email = "<%=email%>" and status = "Completed" ;
</sql:query>

<% int n = 1; %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="CSS/admin.css">
        <title>Document</title>
        <style>
            #Add, #Manage, #All, #New, #Rejected, #Completd{
                display: none;
            }

            #dform{
                background-color: rgb(235 231 231);
                margin: 0;
                padding: 0;
            }
            #dbtn{
                margin: 2px;
                padding: 2px;
                border-radius: 10px;
                    cursor: pointer;
            }
        </style>
    </head>

    <body>
        <div id="container">
            <div id="nav">
                <ul>
                    <h2>DONOR</h2>
                    <li><a href="#dashboard" onclick="dclick()">Dashboard</a></li><hr>
                    <li class="hover">List Your Food Details
                        <ul>
                            <li><hr><a href="#Add" onclick="afclick()">Add Food</a></li>
                            <li><hr><a href="#Manage" onclick="mclick()">Manage Food</a></li>
                        </ul>
                    </li><hr>
                    <li class="hover">Requests
                        <ul>
                            <li><hr><a href="#All" onclick="aclick()">All</a></li>
                            <li><hr><a href="#New" onclick="nclick()">New</a></li>
                            <li><hr><a href="#Rejected" onclick="rclick()">Rejected</a></li>
                            <li><hr><a href="#Completd" onclick="cclick()">Completed</a></li>
                        </ul>
                    </li><hr>
                    <li><a href="index.html"> Log Out</a></li><hr>
                </ul>
            </div>
            <div id="body">
                <div id="header">
                    <p>
                        <c:forEach var = "row" items = "${uname.rows}">
                            <c:out value = "${row.name}"/>
                        </c:forEach>
                    </p>
                </div>
                <div id="dashboard">
                    <div style="background-color: lightcoral;">
                        <a href="#Manage" onclick="mclick()">
                            <h3>Total Listed Food</h3>
                            <h3><c:out value="${food.rowCount}" /></h3>
                        </a>
                    </div>
                    <div style="background-color: lightslategray;">
                        <a href="#All" onclick="aclick()">
                            <h3>All Requests</h3>
                            <h3><c:out value="${afood.rowCount}" /></h3>
                        </a>
                    </div>
                    <div style="background-color: lightgreen;">
                        <a href="#New" onclick="nclick()">
                            <h3>New Requests</h3>
                            <h3><c:out value="${nfood.rowCount}" /></h3>
                        </a>
                    </div>
                    <div style="background-color: lightsalmon;">
                        <a href="#Rejected" onclick="rclick()">
                            <h3>Rejected Requests</h3>
                            <h3><c:out value="${rfood.rowCount}" /></h3>
                        </a>
                    </div>
                    <div style="background-color: rgb(172, 101, 172);">
                        <a href="#Completd" onclick="cclick()">
                            <h3>Request Completed</h3>
                            <h3><c:out value="${cfood.rowCount}" /></h3>
                        </a>
                    </div>
                </div>
                <div id="Add" class="tableStyle">
                    <div>
                        <h1>LIST YOUR FOOD DETAILS</h1>
                        <form action="addFood" method="get">
                            <input type="hidden" name="reg_email" value="<%=email%>" />
                            <label for="f_item">Food Items :</label><input type="text" name="f_item" id="f_item"><br>
                            <label for="pick_add">Pickup Address :</label><input type="text" name="pick_add" id="pick_add"><br>
                            <label for="city">City :</label><input type="text" name="city" id="city"><br>
                            <label for="con_name">Contact Person :</label><input type="text" name="con_name" id="con_name"><br>
                            <label for="con_num">Contact Person Mobile Number :</label><input type="tel" name="con_num" id="con_num"><br>
                            <input type="submit" id="btn" value="SUBMIT">
                        </form>
                    </div>
                </div>
                <div id="Manage" class="tableStyle">
                    <div>
                        <table>
                            <caption>FOOD DETAILS</caption>
                            <tr>
                                <th>S.No.</th>
                                <th>Food Items</th>
                                <th>Contact Person</th>
                                <th>Contact Person Mobile Number</th>
                                <th>City Name</th>
                                <th>Delete</th>
                            </tr>
                            <br>
                            <% n=1; %>
                            <c:forEach var = "row" items = "${food.rows}">
                                <tr>
                                    <td>
                                        <% out.println(n);
                                            n++;
                                        %>
                                    </td>
                                    <td><c:out value = "${row.f_item}"/></td>
                                    <td><c:out value = "${row.con_name}"/></td>
                                    <td><c:out value = "${row.con_num}"/></td>
                                    <td><c:out value = "${row.city}"/></td>
                                    <td>
                                        <form id="dform"action="deleteFood" method="get">
                                            <input type="hidden" name="email" value="${row.reg_email}">
                                            <input type="hidden" name="id" value="${row.id}"> 
                                            <input type="submit" id="dbtn" value="X">
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                            <!--                        <tr>
                                                        <td>x</td>
                                                        <td>x</td>
                                                        <td>x</td>
                                                        <td>x</td>
                                                        <td>x</td>
                                                        <td>x</td>
                                                    </tr>-->
                        </table>
                    </div>
                </div>
                <div id="All" class="tableStyle">
                    <div>
                        <table>
                            <caption>ALL REQUESTS</caption>
                            <tr>
                                <th>S.No.</th>
                                <th>Request By</th>
                                <th>Request Mobile Number</th>
                                <th>Food Items</th>
                                <th>Status</th>
                            </tr>
                            <br>
                            <% n=1; %>
                            <c:forEach var = "row" items = "${afood.rows}">
                                <tr>
                                    <td>
                                        <% out.println(n);
                                            n++;
                                        %>
                                    </td>
                                    <td><c:out value = "${row.req_name}"/></td>
                                    <td><c:out value = "${row.req_num}"/></td>
                                    <td><c:out value = "${row.f_item}"/></td>
                                    <td><c:out value = "${row.status}"/></td>
                                </tr>
                            </c:forEach>
                        </table>
                    </div>
                </div>
                <div id="New" class="tableStyle">
                    <div>
                        <table>
                            <caption>NEW REQUESTS</caption>
                            <tr>
                                <th>S.No.</th>
                                <th>Request By</th>
                                <th>Request Mobile Number</th>
                                <th>Food Items</th>
                                <th>Status</th>
                                <th>Reject</th>
                                <th>Accept</th>
                            </tr>
                            <br>
                            <% n=1; %>
                            <c:forEach var = "row" items = "${nfood.rows}">
                                <tr>
                                    <td>
                                        <% out.println(n);
                                            n++;
                                        %>
                                    </td>
                                    <td><c:out value = "${row.req_name}"/></td>
                                    <td><c:out value = "${row.req_num}"/></td>
                                    <td><c:out value = "${row.f_item}"/></td>
                                    <td><c:out value = "${row.status}"/></td>
                                    <td>
                                        <form id="dform"action="rejectReq" method="get">
                                            <input type="hidden" name="email" value="${row.reg_email}">
                                            <input type="hidden" name="id" value="${row.id}">
                                            <input type="submit" id="dbtn" value="&#10008;">
                                        </form>
                                    </td>
                                    <td>
                                        <form id="dform"action="acceptReq" method="get">
                                            <input type="hidden" name="email" value="${row.reg_email}">
                                            <input type="hidden" name="id" value="${row.id}">
                                            <input type="submit" id="dbtn" value="&#10004;">
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                            <!--                            <tr>
                                                            <td>x</td>
                                                            <td>x</td>
                                                            <td>x</td>
                                                            <td>x</td>
                                                            <td>x</td>
                                                        </tr>-->
                        </table>
                    </div>
                </div>
                <div id="Rejected" class="tableStyle">
                    <div>
                        <table>
                            <caption>REJECTED REQUESTS</caption>
                            <tr>
                                <th>S.No.</th>
                                <th>Request By</th>
                                <th>Request Mobile Number</th>
                                <th>Food Items</th>
                                <th>Status</th>
                            </tr>
                            <br>
                            <% n=1; %>
                            <c:forEach var = "row" items = "${rfood.rows}">
                                <tr>
                                    <td>
                                        <% out.println(n);
                                            n++;
                                        %>
                                    </td>
                                    <td><c:out value = "${row.req_name}"/></td>
                                    <td><c:out value = "${row.req_num}"/></td>
                                    <td><c:out value = "${row.f_item}"/></td>
                                    <td><c:out value = "${row.status}"/></td>
                                </tr>
                            </c:forEach>
                            <!--                            <tr>
                                                            <td>x</td>
                                                            <td>x</td>
                                                            <td>x</td>
                                                            <td>x</td>
                                                            <td>x</td>
                                                        </tr>-->
                        </table>
                    </div>
                </div>
                <div id="Completd" class="tableStyle">
                    <div>
                        <table>
                            <caption>REQUEST COMPLETED</caption>
                            <tr>
                                <th>S.No.</th>
                                <th>Request By</th>
                                <th>Request Mobile Number</th>
                                <th>Food Items</th>
                                <th>Status</th>
                            </tr>
                            <br>
                            <% n=1; %>
                            <c:forEach var = "row" items = "${cfood.rows}">
                                <tr>
                                    <td>
                                        <% out.println(n);
                                            n++;
                                        %>
                                    </td>
                                    <td><c:out value = "${row.req_name}"/></td>
                                    <td><c:out value = "${row.req_num}"/></td>
                                    <td><c:out value = "${row.f_item}"/></td>
                                    <td><c:out value = "${row.status}"/></td>
                                </tr>
                            </c:forEach>
                            <!--                            <tr>
                                                            <td>x</td>
                                                            <td>x</td>
                                                            <td>x</td>
                                                            <td>x</td>
                                                            <td>x</td>
                                                        </tr>-->
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <script>
            function dclick() {
                document.getElementById("dashboard").style.display = "grid";
                document.getElementById("Add").style.display = "none";
                document.getElementById("Manage").style.display = "none";
                document.getElementById("All").style.display = "none";
                document.getElementById("New").style.display = "none";
                document.getElementById("Rejected").style.display = "none";
                document.getElementById("Completd").style.display = "none";
            }
            function afclick() {
                document.getElementById("dashboard").style.display = "none";
                document.getElementById("Add").style.display = "block";
                document.getElementById("Manage").style.display = "none";
                document.getElementById("All").style.display = "none";
                document.getElementById("New").style.display = "none";
                document.getElementById("Rejected").style.display = "none";
                document.getElementById("Completd").style.display = "none";
            }
            function mclick() {
                document.getElementById("dashboard").style.display = "none";
                document.getElementById("Add").style.display = "none";
                document.getElementById("Manage").style.display = "block";
                document.getElementById("All").style.display = "none";
                document.getElementById("New").style.display = "none";
                document.getElementById("Rejected").style.display = "none";
                document.getElementById("Completd").style.display = "none";
            }
            function aclick() {
                document.getElementById("dashboard").style.display = "none";
                document.getElementById("Add").style.display = "none";
                document.getElementById("Manage").style.display = "none";
                document.getElementById("All").style.display = "block";
                document.getElementById("New").style.display = "none";
                document.getElementById("Rejected").style.display = "none";
                document.getElementById("Completd").style.display = "none";
            }
            function nclick() {
                document.getElementById("dashboard").style.display = "none";
                document.getElementById("Add").style.display = "none";
                document.getElementById("Manage").style.display = "none";
                document.getElementById("All").style.display = "none";
                document.getElementById("New").style.display = "block";
                document.getElementById("Rejected").style.display = "none";
                document.getElementById("Completd").style.display = "none";
            }
            function rclick() {
                document.getElementById("dashboard").style.display = "none";
                document.getElementById("Add").style.display = "none";
                document.getElementById("Manage").style.display = "none";
                document.getElementById("All").style.display = "none";
                document.getElementById("New").style.display = "none";
                document.getElementById("Rejected").style.display = "block";
                document.getElementById("Completd").style.display = "none";
            }
            function cclick() {
                document.getElementById("dashboard").style.display = "none";
                document.getElementById("Add").style.display = "none";
                document.getElementById("Manage").style.display = "none";
                document.getElementById("All").style.display = "none";
                document.getElementById("New").style.display = "none";
                document.getElementById("Rejected").style.display = "none";
                document.getElementById("Completd").style.display = "block";
            }
        </script>
    </body>

</html>
