<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.net.URLEncoder" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%	
		String encoding = "UTF-8";
		request.setCharacterEncoding(encoding);
		/* // 쿠키 생성
		Cookie orderId = new Cookie("orderId", URLEncoder.encode(request.getParameter("orderId"), encoding));
		Cookie orderName = new Cookie("orderName", URLEncoder.encode(request.getParameter("orderName"), encoding));
		Cookie tel = new Cookie("tel", URLEncoder.encode(request.getParameter("tel"), encoding));
		Cookie zipCode = new Cookie("zipCode", URLEncoder.encode(request.getParameter("zipCode"), encoding));
		Cookie address01 = new Cookie("address01", URLEncoder.encode(request.getParameter("address01"), encoding));
		Cookie address02 = new Cookie("address02", URLEncoder.encode(request.getParameter("address02"), encoding));
		
		out.print(orderId + ", " + orderName + ", " + tel + ", " + zipCode + ", " + address01 + ", " + address02);
		
		// 쿠키 저장 시간
		int maxAge = 24 * 60 * 60;
		orderId.setMaxAge(maxAge);
		orderName.setMaxAge(maxAge);
		tel.setMaxAge(maxAge);
		zipCode.setMaxAge(maxAge);
		address01.setMaxAge(maxAge);
		address02.setMaxAge(maxAge);
		
		// 쿠키를 추가
		response.addCookie(orderId);
		response.addCookie(orderName);
		response.addCookie(tel);
		response.addCookie(zipCode);
		response.addCookie(address01);
		response.addCookie(address02); */
		
		// 세션추가
		String orderId = request.getParameter("orderId");
		String orderName = request.getParameter("orderName");
		String tel = request.getParameter("tel");
		String zipCode = request.getParameter("zipCode");
		String address01 = request.getParameter("address01");
		String address02 = request.getParameter("address02");
		
		session.setAttribute("orderId", orderId);
		session.setAttribute("orderName", orderName);
		session.setAttribute("tel", tel);
		session.setAttribute("zipCode", zipCode);
		session.setAttribute("address01", address01);
		session.setAttribute("address02", address02);
		
		// 세션 저장 시간
		session.setMaxInactiveInterval(24 * 60 * 60);
		
		response.sendRedirect("orderConfirm.jsp");
	%>
</body>
</html>