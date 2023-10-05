<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "jakarta.servlet.http.*,jakarta.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver"
                   url = "jdbc:mysql://localhost:3306/Food_Consumption"
                   user = "root"  password = "Sid@2002"/>

<sql:query dataSource = "${snapshot}" var = "food">
    SELECT * from food where status = "Null" or status ="Rejected" ;
</sql:query>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="CSS/navbar.css">
        <style>
            body,html{
                margin: 0;
                padding: 0;
            }
            table,td,th{
                border: 2px solid gray;
                border-collapse: collapse;
                margin: auto;
                padding: 10px;
            }
            table{
                align-items: center;
                width: auto;
                hight:100%;
                /*margin: 100px auto;*/
                margin-left: auto;
                margin-right: auto;
                margin-top: auto;
                margin-bottom: 150px;

            }
            h1{
                margin-top: 100px;
                text-align: center;
            }
            th{
                width: auto;
            }
            #copyright h3{
                position: absolute;
                background-color: rgb(77 211 241);
                padding: 20px 100px;
                margin: 0;
                width: -webkit-fill-available;
            }
            .bg-modal {
                background-color: rgba(0, 0, 0, 0.8);
                width: 100%;
                height: 100%;
                position: absolute;
                top: 0;
                display: none;
                justify-content: center;
                align-items: center;
            }

            .modal-contents {
                height: 225px;
                width: 400px;
                background-color: white;
                text-align: center;
                padding: 20px;
                position: relative;
                border-radius: 4px;
            }

            input {
                margin:auto;
                display: block;
                width: auto;
                padding: 8px;
                border: 1px solid gray;
            }
            .popup{
                width: 80%;
                padding: 10px;
                margin: 10px auto;
            }
            .btn{
                width: auto;
                background-color: rgb(0 120 212);
                color: white;
            }

            .close {
                position: absolute;
                top: 0;
                right: 10px;
                font-size: 42px;
                color: #333;
                transform: rotate(45deg);
                cursor: pointer;

                &:hover {
                    color: #666;
                }
            }
        </style>
        <title>Document</title>
    </head>
    <body>
        <div id="navbar">
            <ul>
                <li> <a href="index.html">HOME</a></li>
                <li><a href="HTML/about.html">ABOUT</a></li>
                <li><a href="afl.jsp">AVAILABLE FOOD LIST</a></li>
                <li><a href="HTML/contact.html">CONTACT</a></li>
                <li><a href="HTML/signIn.html">DONOR</a></li>
                <li><a href="HTML/adminSignIn.html">ADMIN</a></li>
            </ul>
        </div>
        <div>
            <table id="table">
                <h1>AVAILABLE FOOD LIST</h1>
                <tr>
                    <th>S.No.</th>
                    <th>Contact Person Name</th>
                    <th>Contact Person Number</th>
                    <th>Food Items</th>
                    <th>Address</th>
                    <th>City Name</th>
                    <th>Request</th>
                </tr>
                <br>
                <% int n = 1; %>
                <% String id =""; %>
                <c:forEach var = "row" items = "${food.rows}">
                    <tr>
                        <td>
                            <% out.println(n);
                                n++;
                            %>
                        </td>
                        <td><c:out value = "${row.con_name}"/></td>
                        <td><c:out value = "${row.con_num}"/></td>
                        <td><c:out value = "${row.f_item}"/></td>
                        <td><c:out value = "${row.pick_add}"/></td>
                        <td><c:out value = "${row.city}"/></td>
                        <td class="event">
                            <form action="#" method="get">
                            
                                <input type="hidden" name="id" value="${row.id}">
                                <input type="submit" class="cbtn btn" value="Request Food">
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </table>
        </div>
        <div class="bg-modal" id="bgModal">
            <div class="modal-contents">
                <div class="close">+</div>
                <form action="addRequest" method="get">
                    <h2>FOOD REQUEST</h2>
                    <% id = request.getParameter("id"); %>
                    <input type="hidden" name="fid" value="<%=id%>">
                    <input type="text" class="popup" name="req_name" placeholder="Full Name">
                    <input type="tel" class="popup" name="req_num" placeholder="Mobile Number">
                    <input type="submit" class="popup btn"  value="SUBMIT">
                    <!--<a href="#" class="button">Submit</a>-->
                </form>
            </div>
        </div>
        <div id="copyright">
            <h3>Copyright &#169; 2023 Food Consumption. All Rights Reserved</h3>
        </div>
        <script>

            document.getElementById('table').addEventListener("click", e => {
                let td = e.target.closest('td[class="event"]');
                if (td) {
                    
                document.querySelector('.bg-modal').style.display = "flex";
                }
            });

            document.querySelector('.close').addEventListener("click", function () {
                document.querySelector('.bg-modal').style.display = "none";
            });
        </script>
    </body>
</html>