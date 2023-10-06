<%--
  Created by IntelliJ IDEA.
  User: imjingu
  Date: 2023/09/15
  Time: 3:30 PM
  To change this template use File | Settings | File Templates.
  ajax로 아이디 중복확인
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
  request.setCharacterEncoding("UTF-8");
  String id = request.getParameter("id");
%>
<%@ include file="../inc/dbconn.jsp" %>
<%
  PreparedStatement preparedStatement = null;
  ResultSet resultSet = null;
  String sql = "SELECT * FROM member WHERE memberID = ?";
  preparedStatement = connection.prepareStatement(sql);
  preparedStatement.setString(1, id);
  resultSet = preparedStatement.executeQuery();
  if (resultSet.next()) {
    out.print("{\"result\":\"true\"}");
  } else {
    out.print("{\"result\":\"false\"}");
  }
  if(resultSet != null)
    resultSet.close();
  if(preparedStatement != null)
    preparedStatement.close();
  if(connection != null)
    connection.close();
%>
