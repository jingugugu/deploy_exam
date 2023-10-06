<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.Product" %>
<%@ page import="dao.ProductRepository" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품상세</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>상품 상세</title>
</head>
<body>
	<jsp:include page="../inc/menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품상세</h1>
		</div>
	</div>
	<%@ include file="../inc/dbconn.jsp" %>
	<%
		String productId = request.getParameter("productId");
		out.print(productId);
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		String sql = "select * from product where productId = ?";
		preparedStatement = connection.prepareStatement(sql);
		preparedStatement.setString(1, productId);
		resultSet = preparedStatement.executeQuery();
		if(resultSet.next()) {
	%>
	
	
	<div class="container">
		<div class="row">
			<div class="col-md-6">
				<p><img src="/upload/<%=resultSet.getString("fileName")%>" style="width:500px;"> </p>
				<h3><%=resultSet.getString("productName") %></h3>
				<p><%=resultSet.getString("description") %></p>
				<p><strong>상품 코드</strong> : <span class = "badge badge-danger">
					<%=resultSet.getString("productId") %>
				</span></p>
				<p><strong>제조사</strong> : <%=resultSet.getString("manufacturer") %></p>
				<p><strong>분류</strong> : <%=resultSet.getString("category")%></p>
				<p><strong>재고 수</strong> : <%=resultSet.getString("unitsInStock") %></p>
				<p><strong>상태</strong> : <%=resultSet.getString("condition") %></p>
				
				<h4><%=resultSet.getString("unitPrice") %>원</h4>
				<form name="frmAddCart" action="../order/processAddCart.jsp" method="post">
					<input type="hidden" name="productId" value="<%=resultSet.getString("productId") %>">
				</form>
				<p><a href="#" class="btn btn-info"> 장바구니 담기 >> </a></p>
				<p><a href="../order/cart.jsp" class="btn btn-info"> 장바구니 목록 >> </a></p>
				<p><a href="products.jsp" class="btn btn-secondary"> 상품 목록 >> </a></p>
			</div>
			<% 
				}
				if(resultSet != null) {
					resultSet.close();
				}
				if(preparedStatement != null) {
					preparedStatement.close();
				}
				if(connection != null) {
					connection.close();
				}
			%>
		</div>
		<hr>
	</div>
	<jsp:include page="../inc/footer.jsp"></jsp:include>
</body>
<script>
	document.addEventListener('DOMContentLoaded', function() {
		const btnCart = document.querySelector(".btn-info");
		const frmAddCart = document.querySelector('form[name=frmAddCart]');
		console.log(btnCart);
		
		btnCart.addEventListener('click', function() {
			frmAddCart.submit();
		});
	});
</script>
</html>