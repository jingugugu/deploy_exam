<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="dto.Cart" %>
<%@ page import="dao.ProductRepository" %>
<%@ page import="dto.Product" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>장바구니 선택 삭제</title>
</head>
<body>
    <%@ include file="../inc/dbconn.jsp"%>
	<%
        String[] checkedId = request.getParameterValues("checkedId");

        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String sql = "select * from cart";
        pstmt = connection.prepareStatement(sql);
        rs = pstmt.executeQuery();

        while(rs.next()) {
            for(String s : checkedId) {
                if(rs.getString("productId").equals(s)) {
                    sql = "delete from cart WHERE productId = ? AND orderId = ?";
                    try {
                        pstmt = connection.prepareStatement(sql);
                        pstmt.setString(1, s);
                        pstmt.setString(2, orderId);
                        pstmt.executeUpdate();
                    } catch(SQLException e) {
                        throw new RuntimeException(e);
                    } finally {
                            if(pstmt != null) {
                                pstmt.close();
                            }
                            if(rs != null) {
                                rs.close();
                            }
                            if (connection != null) {
                                connection.close();
                            }
                    }
                }
                else {

                }
            }
        }


//      ArrayList<Cart> carts = (ArrayList<Cart>) session.getAttribute("carts");
//

//      if(checkedId != null){
//         for(String s : checkedId){
//            for(int i=0; i < carts.size(); i++){
//               Cart cart = carts.get(i);
//               if(cart.getProductId().equals(s)){
//                  carts.remove(cart);
//                  break;
//               }
//            }
//         }
//      }
      
      response.sendRedirect("./cart.jsp");
   %>
</body>
</html>