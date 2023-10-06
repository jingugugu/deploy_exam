<%--
  Created by IntelliJ IDEA.
  User: imjingu
  Date: 2023/09/16
  Time: 11:34 PM
  To change this template use File | Settings | File Templates.
--%>
<html>
<head>
    <title>정보수정</title>
</head>
<body>
<%@ include file="../inc/dbconn.jsp" %>
<%
  request.setCharacterEncoding("UTF-8");

  String memberId = (String) session.getAttribute("sessionMemberId");
  String passwd = request.getParameter("passwd");
  String memberName = request.getParameter("memberName");
  String gender = request.getParameter("gender");
  String birthyy = request.getParameter("birthyy");
  String birthmm = request.getParameter("birthmm");
  String birthdd = request.getParameter("birthdd");
  String mail1 = request.getParameter("mail1");
  String mail2 = request.getParameter("mail2");
  String phone = request.getParameter("phone");
  String zipCode = request.getParameter("zipCode");
  String address01 = request.getParameter("address01");
  String address02 = request.getParameter("address02");

  PreparedStatement preparedStatement = null;

  String sql = "UPDATE member SET passwd = ?, memberName = ?, gender = ?, birthday = ?, email = ?, phone = ?, zipCode = ?, address01 = ?, address02 = ? WHERE memberId = ?";
  preparedStatement = connection.prepareStatement(sql);
  preparedStatement.setString(1, passwd);
  preparedStatement.setString(2, memberName);
  preparedStatement.setString(3, gender);
  preparedStatement.setString(4, birthyy + "-" + birthmm + "-" + birthdd);
  preparedStatement.setString(5, mail1 + "@" + mail2);
  preparedStatement.setString(6, phone);
  preparedStatement.setString(7, zipCode);
  preparedStatement.setString(8, address01);
  preparedStatement.setString(9, address02);
  preparedStatement.setString(10, memberId);
  preparedStatement.executeUpdate();
  if(preparedStatement.executeUpdate() == 1) { // UPDATE가 성공적으로 수행
    response.sendRedirect("resultMember.jsp?msg=0");
  }
  else {

  }

%>
</body>
</html>
