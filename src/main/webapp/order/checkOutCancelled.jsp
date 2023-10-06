<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 취소</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
</head>
<body>
	<jsp:include page="../inc/menu.jsp"/>
	<div class="jumbotron">
		<div class="container">
			<h1 class="dispaly-3">주문 취소</h1>
		</div>
	</div>
	<div class="container">		
		<h2 class="alert alert-danger">주문이 취소되었습니다.</h2>	
	</div>
	<div class="container">		
		<a href="../product/products.jsp class="btn btn-secondary" role="button"> 상품 목록 >> </a>	
	</div>
	<jsp:include page="../inc/footer.jsp"/>
	<%
			// 2) 쿠키의 정보 삭제
			Cookie[] cookies = request.getCookies();
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