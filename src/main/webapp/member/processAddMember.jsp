<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.MemberRepository" %>
<%@ page import="dto.Member" %>
<%@ page import="java.sql.PreparedStatement" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
	<%@ include file="../inc/dbconn.jsp" %>
	<%
		request.setCharacterEncoding("UTF-8");
		
		String memberId = request.getParameter("memberId");
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

		String sql = "INSERT INTO member (memberId, passwd, memberName, gender, birthday, " +
				"email, phone, zipCode, address01, address02," + "addDate)" +
				"VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, now())";
		preparedStatement = connection.prepareStatement(sql);
		preparedStatement.setString(1, memberId);
		preparedStatement.setString(2, passwd);
		preparedStatement.setString(3, memberName);
		preparedStatement.setString(4, gender);
		preparedStatement.setString(5, birthyy + "-" + birthmm + "-" + birthdd);
		preparedStatement.setString(6, mail1 + "@" + mail2);
		preparedStatement.setString(7, phone);
		preparedStatement.setString(8, zipCode);
		preparedStatement.setString(9, address01);
		preparedStatement.setString(10, address02);
		if(preparedStatement.executeUpdate() == 1) { // insert가 성공적으로 수행
			response.sendRedirect("resultMember.jsp?msg=1");
		}
		else {
			response.sendRedirect("addMember.jsp?msg=1");
		}

	%>
</body>
</html>