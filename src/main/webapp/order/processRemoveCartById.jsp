<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.ProductRepository" %>
<%@ page import="dto.Product" %>
<%@ page import="java.util.*" %>
<%@ page import="dto.Cart" %>
<%@ page import="java.sql.PreparedStatement" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 삭제</title>
</head>
<body>
<%@ include file="../inc/dbconn.jsp" %>
	<%
		String productId = request.getParameter("productId");
		if(productId == null || productId.trim().equals("")) {
			// null이 반환하거나 빈 문자열이 들어온 경우
			response.sendRedirect("../products.jsp");
			return;
		}
		PreparedStatement preparedStatement = null;

		String sql = "DELETE from cart WHERE productId = ? and orderId = ?";
		try {
			preparedStatement = connection.prepareStatement(sql);
			preparedStatement.setString(1, productId);
			preparedStatement.setString(2, orderId);
			preparedStatement.executeUpdate();
		} catch (SQLException e) {
			throw new RuntimeException(e);
		}finally {
			if (preparedStatement != null) {
				preparedStatement.close();
			}
			if (connection != null) {
				connection.close();
			}
		}


//		// 유효한 productId 인지 확인
//		ProductRepository productRepository = ProductRepository.getInstance();
//		Product product = productRepository.getProductById(productId);
//		if(product == null) {
//			response.sendRedirect("../exception/exceptionNoPrdouct.jsp");
//		}
//
//		// 세션에서 장바구니 목록 가져옴
//		ArrayList<Cart> carts = (ArrayList<Cart>) session.getAttribute("carts");
//		for(int i = 0; i < carts.size(); i++) {
//			Cart cart = carts.get(i);
//			if(cart.getProductId().equals(productId)) {
//				carts.remove(cart);
//				break;
//			}
//		}
		response.sendRedirect("cart.jsp");
	%>
</body>
</html>