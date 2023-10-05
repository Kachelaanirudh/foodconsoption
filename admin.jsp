<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "jakarta.servlet.http.*,jakarta.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>

<sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver"
                   url = "jdbc:mysql://localhost:3306/Food_Consumption"
                   user = "root"  password = "Sid@2002"/>

<sql:query dataSource = "${snapshot}" var = "result">
    SELECT * from user;
</sql:query>

<sql:query dataSource = "${snapshot}" var = "food">
    SELECT * from food;
</sql:query>

<sql:query dataSource = "${snapshot}" var = "afood">
    SELECT * from food where status = "New" or status ="Rejected" or status ="Completed";
</sql:query>

<sql:query dataSource = "${snapshot}" var = "nfood">
    SELECT * from food where status = "New" ;
</sql:query>

<sql:query dataSource = "${snapshot}" var = "rfood">
    SELECT * from food where status = "Rejected";
</sql:query>

<sql:query dataSource = "${snapshot}" var = "cfood">
    SELECT * from food where status = "Completed";
</sql:query>

<% int n = 1; %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="CSS/admin.css">
        <style>
            #Reg_Food_Donor, #Listed_Food, #All_Requests, #New_Requests, #Rejected_Requests, #Request_Completd {
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
                width: 13%;
                    cursor: pointer;
            }

        </style>
        <title>Document</title>
    </head>

    <body>
        <div id="container">
            <div id="nav">
                <ul>
                    <h2>ADMIN</h2>
                    <li><a href="#dashboard" onclick="dclick()">Dashboard</a></li><hr>
                    <li><a href="#Reg_Food_Donor" onclick="rfdclick()">Reg Food Donor</a></li><hr>
                    <li><a href="#Listed_Food" onclick="lfclick()">Listed Food</a></li><hr>
                    <li class="hover">Food Requests
                        <ul>
                            <li><hr><a href="#All_Requests" onclick="arclick()">All Requests</a></li>
                            <li><hr><a href="#New_Requests" onclick="nrclick()">New Requests</a></li>
                            <li><hr><a href="#Rejected_Requests" onclick="rrclick()">Rejected Requests</a></li>
                            <li><hr><a href="#Request_Completd" onclick="rcclick()">Request Completed</a></li>
                        </ul>
                    </li><hr>
                    <li><a href="index.html">Log Out</a></li><hr>
                </ul>
            </div>
            <div id="body">
                <div id="header">
                    <p>admin</p>
                </div>
                <div id="dashboard">

                    <div style="background-color: lightcoral;">
                        <a href="#Reg_Food_Donor" onclick="rfdclick()">
                            <h3>Total Food Donor</h3>
                            <h3><c:out value="${result.rowCount}" /></h3>
                        </a>
                    </div>
                    <div style="background-color: lightslategray;">
                        <a href="#Listed_Food" onclick="lfclick()">
                            <h3>Total Listed Food</h3>
                            <h3><c:out value="${food.rowCount}" /></h3>
                        </a>
                    </div>
                    <div style="background-color: lightgreen;">
                        <a href="#All_Requests" onclick="arclick()">
                            <h3>All Requests</h3>
                            <h3><c:out value="${afood.rowCount}" /></h3>
                        </a>
                    </div>
                    <div style="background-color: #ffef7a;">
                        <a href="#New_Requests" onclick="nrclick()">
                            <h3>New Requests</h3>
                            <h3><c:out value="${nfood.rowCount}" /></h3>
                        </a>
                    </div>
                    <div style="background-color: lightsalmon;">
                        <a href="#Rejected_Requests" onclick="rrclick()">
                            <h3>Rejected Requests</h3>
                            <h3><c:out value="${rfood.rowCount}" /></h3>
                        </a>
                    </div>
                    <div style="background-color: rgb(172, 101, 172);">
                        <a href="#Request_Completd" onclick="rcclick()">
                            <h3>Request Completed</h3>
                            <h3><c:out value="${cfood.rowCount}" /></h3>
                        </a>
                    </div>
                </div>
                <div id="Reg_Food_Donor" class="tableStyle">
                    <div>
                        <table>
                            <caption>FOOD DONOR DETAILS</caption>
                            <tr>
                                <th>S.No.</th>
                                <th>Full Name</th>
                                <th>Mobile Number</th>
                                <th>Email</th>
                                <th>Delete Account</th>
                            </tr>
                            <br>
                            <% n=1; %>
                            <c:forEach var = "row" items = "${result.rows}">
                                <tr>
                                    <!--<td>
                                    <%--<c:out value = "${row.id}"/>--%>
                                    </td>-->
                                    <td>
                                        <% out.println(n);
                                            n++;
                                        %>
                                    </td>
                                    <td><c:out value = "${row.name}"/></td>
                                    <td><c:out value = "${row.email}"/></td>
                                    <td><c:out value = "${row.phone}"/></td>
                                    <td>
                                        <form id="dform" action="deleteAcc" method="get">
                                            <input type="hidden" name="id" value="${row.id}">
                                            <input type="submit" id="dbtn" value="&#10008;">
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </table>
                    </div>
                </div>
                <div id="Listed_Food" class="tableStyle">
                    <div>
                        <table>
                            <caption>ALL LISTED FOOD</caption>
                            <tr>
                                <th>S.No.</th>
                                <th>Register By</th>
                                <th>Register Mobile Number</th>
                                <th>Contact Person Name</th>
                                <th>Contact Person Number</th>
                                <th>Food Items</th>
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
                                    <td><c:out value = "${row.reg_name}"/></td>
                                    <td><c:out value = "${row.reg_num}"/></td>
                                    <td><c:out value = "${row.con_name}"/></td>
                                    <td><c:out value = "${row.con_num}"/></td>
                                    <td><c:out value = "${row.f_item}"/></td>
                                </tr>
                            </c:forEach>
                        </table>
                    </div>
                </div>
                <div id="All_Requests" class="tableStyle">
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
                <div id="New_Requests" class="tableStyle">
                    <div>
                        <table>
                            <caption>NEW REQUESTS</caption>
                            <tr>
                                <th>S.No.</th>
                                <th>Request By</th>
                                <th>Request Mobile Number</th>
                                <th>Food Items</th>
                                <th>Status</th>
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
                                </c:forEach>
                        </table>
                    </div>
                </div>
                <div id="Rejected_Requests" class="tableStyle">
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
                        </table>
                    </div>
                </div>
                <div id="Request_Completd" class="tableStyle">
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
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <<script src="CSS/admin.js"></script>

    </body>

</html>