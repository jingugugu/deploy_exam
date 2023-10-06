<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dto.Product" %>
<%@ page import="dao.ProductRepository" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<title>상품 편집</title>
</head>
<body>
	<jsp:include page="../inc/menu.jsp" />
	<div class="jumbotron">
		<div class="container">
			<h1 class="display-3">상품편집</h1>
		</div>
	</div>
	<div class="container">
		<div class="row" elign="center">
			<%@ include file="../inc/dbconn.jsp" %>
			<%	
				PreparedStatement preparedStatement = null;
				ResultSet resultSet = null;
				String sql = "select * from product";
				preparedStatement = connection.prepareStatement(sql);
				resultSet = preparedStatement.executeQuery();
				while(resultSet.next()) {
			%>
			<div class="col-md-4">
				<img src="/upload/<%=resultSet.getString("fileName") %>" style="width:100%">
				<h3><%=resultSet.getString("productName") %></h3>
				<p><%=resultSet.getString("description") %></p>
				<p><%=resultSet.getString("unitPrice") %>원</p>
				<p><a href="./modifyProduct.jsp?productId=<%=resultSet.getString("productId") %>" class="btn btn-success" role="button"> 수정>> </a>
				<a href="#" class="btn btn-danger btn-remove" role="button" id="<%=resultSet.getString("productId") %>"> 삭제 >> </a></p>
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
	document.addEventListener('DOMContentLoaded', function () {
		const btns = document.querySelectorAll('.btn-remove');
		btns.forEach(btn => {
			btn.addEventListener('click', function(e) {
				const productId = e.target.id;
				// console.log(productId)
				location.href='./processRemoveProduct.jsp?productId=' + productId;
			});
		});
	});
</script>
</html>