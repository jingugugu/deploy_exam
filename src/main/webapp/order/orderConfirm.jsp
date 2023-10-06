<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="dao.ProductRepository" %>
<%@ page import="dto.Product" %>
<%@ page import="java.util.*" %>
<%@ page import="dto.Cart" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 정보<</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
</head>
<body>
	<jsp:include page="../inc/menu.jsp"/>
		<div class="jumbotron">
			<div class="container">
				<h1 class="dispaly-3">주문 정보</h1>
			</div>
		</div>
		<%
			String encoding = "UTF-8";
			request.setCharacterEncoding(encoding);
			
			String orderId = "", orderName = "", tel = "", zipCode = "", address01 = "", address02= "";
			

			
			
			/* Cookie[] cookies = request.getCookies();
				 if (cookies != null) {
				for(Cookie cookie : cookies) {
					String cookieName = cookie.getName();
					switch(cookieName) {
					case "orderId":
						orderId = URLDecoder.decode(cookie.getValue(), encoding);
						break;
					case "orderName":
						orderName = URLDecoder.decode(cookie.getValue(), encoding);
						break;
					case "tel":
						tel = URLDecoder.decode(cookie.getValue(), encoding);
						break;
					case "zipCode":
						zipCode = URLDecoder.decode(cookie.getValue(), encoding);
						break;
					case "address01":
						address01 = URLDecoder.decode(cookie.getValue(), encoding);
						break;
					case "address02":
						address02 = URLDecoder.decode(cookie.getValue(), encoding);
						break;
					
					}
				}
			} */
			
			
		%>
		<div class="container col-8 alert alert-info">
			<div class="text-center">
				<h1>영수증</h1>
			</div>
			<div class="row justify-content-between">
				<div class="col-4" align="left">
					<strong>배송 주소</strong> <br>
					성명 : <%=session.getValue("orderName") %> <br>
					연락처 : <%=session.getValue("tel") %> <br>
					우편번호 : <%=session.getValue("zipCode") %> <br>
					주소 : <%=session.getValue("address01") %> - <%=session.getValue("address02") %>
				</div>
			</div>
		</div>
		<div class="container col-8 alert">
				<table class="table table-hover">
					<tr>
						<th class="text-center">상품</th>
						<th class="text-center">가격</th>
						<th class="text-center">수량</th>
						<th class="text-center">소계</th>
					</tr>
					<%
						int sum = 0;
						ArrayList<Cart> carts = (ArrayList<Cart>) session.getAttribute("carts");
						if(carts == null) {
							carts = new ArrayList<Cart>();
						}
						for(Cart cart : carts) { // 상품 리스트 하나씩 출력하기
							Product product = ProductRepository.getInstance().getProductById(cart.getProductId());
							int total = product.getUnitPrice() * cart.getCartCnt();
							sum = sum + total;
					%>
					<tr>
						<td class="text-center"><em><%=product.getProductName() %></em></td>
						<td class="text-center"><%=product.getUnitPrice() %></em>원</td>
						<td class="text-center"><%=cart.getCartCnt() %></em></td>
						<td class="text-center"><%=total %></em>원</td>
					</tr>
					<%
						}
					%>
					<tr>
						<td></td>
						<td></td>
						<td class="text-rigth"><strong>총액:</strong></td>
						<td class="text-center text-danger"><strong><%=sum %></strong></td>
					</tr>
				</table>
				<a href="./shippingInfo.jsp" class="btn btn-secondary" role="button"> 이전 </a>
				<a href="./thankCustomer.jsp" class="btn btn-secondary" role="button"> 주문완료 </a>
				<a href="./checkOutCancelled.jsp" class="btn btn-secondary" role="button"> 취소 </a>
			</div>
	<jsp:include page="../inc/footer.jsp"/>
</body>
</html>