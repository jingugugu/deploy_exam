<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.sql.*"%>
<%
   Connection connection = null;
   try{
      String url             = "jdbc:mariadb://localhost:3306/market";
      String user          = "root";
      String password         = "6521";
      Class.forName("org.mariadb.jdbc.Driver");
      
      connection = DriverManager.getConnection(url, user, password); 
   } catch (SQLException e) {
      out.println("데이터베이스 연결이 실패했습니다<br>");
      out.println("SQLException : " + e.getMessage());
   }
%>
<%
   // 주문번호 관련처리

   String orderId = (String) session.getAttribute("orderId");
   if(orderId == null) {
      String sessionId = session.getId();

      java.text.SimpleDateFormat simpleDateFormat = new java.text.SimpleDateFormat("yyyyMMddHHmmss");
      String currentDateTime = simpleDateFormat.format(new java.util.Date());

      orderId = currentDateTime + "-" + sessionId;
      session.setAttribute("orderId", orderId);
   }
%>