<%--
  Created by IntelliJ IDEA.
  User: imjingu
  Date: 2023/09/15
  Time: 2:50 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
    <title>아이디 중복확인</title>
</head>
<body>
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
    out.print("사용할 수 없는 아이디 입니다.");
  } else {
    out.print("사용 가능한 아이디 입니다.");
  }
%>
</body>
</html>
