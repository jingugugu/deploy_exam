<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="dao.ProductRepository" %>
<%@ page import="dto.Product" %>
<%@ page import="com.oreilly.servlet.*" %>
<%@ page import="com.oreilly.servlet.multipart.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록</title>
</head>
<body>
	<%@ include file="../inc/dbconn.jsp" %>
	<%
		request.setCharacterEncoding("UTF-8");
		
		String folder = "/Users/imjingu/Desktop/dev/upload"; // 저장폴더
		int maxSize = 5 * 1024 * 1024; // 업로드 최대 크기 5mb
		String encType = "UTF-8"; // 인코딩 타입
		
		MultipartRequest multipartRequest = new MultipartRequest(request, folder, maxSize, encType, new DefaultFileRenamePolicy());
		
		String productId = multipartRequest.getParameter("productId");
		String productName = multipartRequest.getParameter("productName");
		String unitPrice = multipartRequest.getParameter("unitPrice");
		String description = multipartRequest.getParameter("description");
		String manufacturer = multipartRequest.getParameter("manufacturer");
		String category = multipartRequest.getParameter("category");
		String unitsInStock = multipartRequest.getParameter("unitsInStock");
		String condition = multipartRequest.getParameter("condition");
		String fileName = multipartRequest.getFilesystemName("fileName");
		
		//문자열을 변경
		Integer price = unitPrice.isEmpty() ? 0 : Integer.parseInt(unitPrice);
		Long stock = unitsInStock.isEmpty() ? 0L : Long.parseLong(unitsInStock);
		
		PreparedStatement preparedStatement = null;
		ResultSet resultSet = null;
		
		String sql = "select * from product where productId = ?";
		preparedStatement = connection.prepareStatement(sql);
		preparedStatement.setString(1, productId);
		resultSet = preparedStatement.executeQuery();
		
		if(resultSet.next()) { // productId에 대한 상품이 있다면
			if(fileName != null) { // 첨부 파일이 있는 경우
				sql = "update product set productName = ?, unitPrice = ?, description = ?, manufacturer = ?," + "category = ?, unitsInStock = ?, `condition` = ?, fileName = ? where productId = ?";
		
				preparedStatement = connection.prepareStatement(sql);
				preparedStatement.setString(1, productName);
				preparedStatement.setInt(2, price);
				preparedStatement.setString(3, description);
				preparedStatement.setString(4, manufacturer);
				preparedStatement.setString(5, category);
				preparedStatement.setLong(6, stock);
				preparedStatement.setString(7, condition);
				preparedStatement.setString(8, fileName);
				preparedStatement.setString(9, productId);
				preparedStatement.executeUpdate();
			}
		
			else {
				sql = "update product set productName = ?, unitPrice = ?, description = ?, manufacturer = ?," + "category = ?, unitsInStock = ?, `condition` = ? where productId = ?";
				preparedStatement = connection.prepareStatement(sql);
				preparedStatement.setString(1, productName);
				preparedStatement.setInt(2, price);
				preparedStatement.setString(3, description);
				preparedStatement.setString(4, manufacturer);
				preparedStatement.setString(5, category);
				preparedStatement.setLong(6, stock);
				preparedStatement.setString(7, condition);
				preparedStatement.setString(8, productId);
				preparedStatement.executeUpdate();
			}
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
		
		
		
		response.sendRedirect("products.jsp");
		
	%>
</body>
</html>