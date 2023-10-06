<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLDecoder" %>
<%
		String encoding = "UTF-8";
		request.setCharacterEncoding(encoding);
		
		// 주문 번호를 쿠키에서 들고 옴
		String orderId = "";
		Cookie[] cookies = request.getCookies();
		if(cookies != null) {
			for(Cookie cookie : cookies) {
				String cookieName = cookie.getName();
				if("orderId".equals(cookieName)) {
					orderId = URLDecoder.decode(cookie.getValue(), encoding);
				}
			}
		}
	%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>주문완료</title>
</head>
<body>
	<jsp:include page="../inc/menu.jsp"/>
	<div class="jumbotron">
		<div class="container">
			<h1 class="dispaly-3">주문 완료</h1>
		</div>
	</div>
	<div class="container">		
		<h2 class="alert alert-danger">주문 해주셔서 감사합니다.</h2>
		<p> 주문번호 : <%=orderId %></p>		
	</div>
	<div class="container">		
		<p><a href="../product/products.jsp" class="btn btn-secondary"> 상품 목록 >> </a></p>		
	</div>
	<jsp:include page="../inc/footer.jsp"/>
	<%
		/*
		실제 작업은 페이지 상단이나 이전 페이지에서 데이터베이스에 저장이 되어야함 
		데이터 베이스 저장에 성공한 후 완료 페이지가 출력이 되어야 함
		1) 작업이 마무리 되었으니 세션의 장바구니 삭제 및
		2) 쿠키의 주문 정보를 삭제 해야 함
		*/
		
		// 1) 세션의 장바구니 삭제
		session.removeAttribute("carts");
		
		// 2) 쿠키의 정보 삭제
		for(Cookie cookie : cookies) {
			String cookieName = cookie.getName();
			switch (cookieName) {
				case "orderId" : case "orderName" : case "tel" : case "zipCode" : case "address01" : case "address02" :
					cookie.setMaxAge(0);
					response.addCookie(cookie);
					break;
			}
		}
	%>
</body>
</html>