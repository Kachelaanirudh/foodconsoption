
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "jakarta.servlet.http.*,jakarta.servlet.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <% 
            String reg_name = (String)request.getParameter("reg_name");
            String reg_email = request.getParameter("reg_email");
            String reg_num =(String) request.getParameter("reg_num");
            String f_item = request.getParameter("f_item");
            String pick_add = request.getParameter("pick_add");
            String city = request.getParameter("city");
            String con_name = request.getParameter("con_name");
            String con_num = request.getParameter("con_num");
            try {
                    Class.forName("com.mysql.cj.jdbc.Driver");

                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Food_Consumption", "root", "Sid@2002");

                    String q = "INSERT INTO food (reg_name, reg_num, reg_email, con_name, con_num, f_item, pick_add, city) VALUES (?,?,?,?,?,?,?,?)";
                    PreparedStatement stmt = con.prepareStatement(q);
                    stmt.setString(1, reg_name);
                    stmt.setLong(2,Long.parseLong(reg_num));
//            out.println("hello");
                    stmt.setString(3, reg_email);
                    stmt.setString(4, con_name);
                    stmt.setLong(5,Long.parseLong(con_num));
                    stmt.setString(6, f_item);
                    stmt.setString(7, pick_add);
                    stmt.setString(8, city);
                    stmt.executeUpdate();

                    con.close();
                    out.println("hello");
                    response.sendRedirect("signIn.html");
            } catch (Exception e) {
                    System.out.println("sql exception occured" + e);
            }
        %>
    </body>
</html>
