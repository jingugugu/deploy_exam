<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.ProductRepository" %>
<%@ page import="dto.Product" %>
<%@ page import="java.util.*" %>
<%@ page import="dto.Cart" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
</head>
<body>
	<jsp:include page="../inc/menu.jsp"/>
	<div class="jumbotron">
		<div class="container">
			<h1 class="dispaly-3">장바구니</h1>
		</div>
	</div>
	<div class="container">
		<div class="row">
			<table width="100%">
				<tr>
					<td align="left">
						<a href="#" class="btn btn-danger btn-removeAll" >비우기</a>
						<a href="#" class="btn btn-danger btn-selected" >선택삭제</a>
					</td>
					<td align="right">
						<a href="./shippingInfo.jsp" class="btn btn-success">주문</a>
					</td>
				</tr>
			</table>
		</div>
		<div style="padding-top: 50px">
		<form name="frmCart" method="post">
		<input type="hidden" name="productId">
			<table class="table table-hover">
				<tr>
					<td>선택</td>
					<td>사진</td>
					<td>상품</td>
					<td>가격</td>
					<td>수량</td>
					<td>소계</td>
					<td>비고</td>
				</tr>
				<%@ include file="../inc/dbconn.jsp" %>
			<%
				PreparedStatement pstmt = null;
				ResultSet rs = null;

				String sql = "SELECT * FROM cart C INNER JOIN product P ON C.productId = P.productId WHERE orderId = ?;";
				pstmt = connection.prepareStatement(sql);
				pstmt.setString(1, orderId);
				rs = pstmt.executeQuery();

				Integer total = 0;

				while(rs.next()) {
					String unitPrice = rs.getString("unitPrice");
					Integer price = unitPrice.isEmpty() ? 0 : Integer.parseInt(unitPrice);

					String cartCnt = rs.getString("cnt");
					Integer cnt = cartCnt.isEmpty() ? 0 : Integer.parseInt(cartCnt);
					Integer sum = price * cnt;

					total += sum;
			%>
				<tr>
					<td><input type="checkbox" name="checkedId" value="<%=rs.getString("productId") %>"></td>
					<td><img src="/upload/<%=rs.getString("FileName")%>" style="width:100px;"> </td>
					<td><a href="../product/product.jsp?productId=<%=rs.getString("productId") %>"> <%=rs.getString("productName") %></a></td>
					<td><%=rs.getString("unitPrice") %></td>
					<td><%=rs.getString("cnt") %></td>
					<td><%=sum %></td>
					<td><a href="#" role="<%=rs.getString("productId") %>" class="badge badge-danger btn-removeById">삭제</a></td>
				</tr>
			<%
				}

			%>
				<tr>
					<td colspan="7">합계 : <%=total%>원</td>
				</tr>
				</table>
			</form>
			<a href="../product/products.jsp" class="btn btn-secondary"> &laquo; 쇼핑 계속하기</a>
	</div>
	<jsp:include page="../inc/footer.jsp"/>
</body>
<script type="text/javascript">
	document.addEventListener('DOMContentLoaded', function() {
		const btnRemoveAll = document.querySelector(".btn-removeAll");
		const btnRemoveSelected = document.querySelector(".btn-selected");
		const frmCart = document.querySelector('form[name=frmCart]');
		btnRemoveAll.addEventListener('click', function() {
			if(confirm('정말 삭제하시겠습니까? > ')) {
				location.href= './processRemoveCart.jsp';
			}
		});
		
		btnRemoveSelected.addEventListener('click', function() {
			if(confirm('정말 삭제하시겠습니까? > ')) {
				frmCart.action = '../order/processRemoveCartSelected.jsp';
				frmCart.submit();
			}
		});
		const btnRemoveByIds = document.querySelectorAll('.btn-removeById');
		btnRemoveByIds.forEach(button => {
			button.addEventListener('click', function(e) {
				if(confirm('정말 삭제하시겠습니까?')) {
					frmCart.productId.value = e.target.role;
					frmCart.action = '../order/processRemoveCartById.jsp';
					frmCart.submit();
				}
			});
		});
	});
</script>
</html>