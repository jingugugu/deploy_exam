<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 삭제</title>
</head>
<body>
	<%@ include file="../inc/dbconn.jsp" %>
	<%
		PreparedStatement pstmt = null;
		String sql = "TRUNCATE TABLE cart;"; // table cart 데이터 전체 삭제
		pstmt = connection.prepareStatement(sql); // db연결
		pstmt.executeUpdate(); // 실행후 업데이트


//		session.invalidate(); // 세션에 저장된 모든 속성 삭제
		response.sendRedirect("cart.jsp");
	%>
</body>
</html>