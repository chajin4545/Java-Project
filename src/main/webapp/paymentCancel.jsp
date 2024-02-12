<!-- 
	GROUP 3
	DIT/2A/01
	HA JIN 		P2100030
	ISAAC		P2107251
	GEORGE		P2143990
 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sad to see you go!</title>
<link rel="stylesheet" href="./css/success.css" />
<link href="https://unpkg.com/cirrus-ui" type="text/css"
    rel="stylesheet" />
<link rel="stylesheet"
    href="https://use.fontawesome.com/releases/v5.2.0/css/all.css"
    integrity="sha384-hWVjflwFxL6sNzntih27bfxkr27PmbbK/iSvJ+a4+0owXq79v+lsFkW54bOGbiDQ"
    crossorigin="anonymous" />
</head>
<body align='center'>
    <% String errCode = request.getParameter("errCode"); %>
    <div class='card mx-20 p-4 vertical-center' align='center'>
        <img src='https://cdn.shopify.com/s/files/1/1061/1924/products/5_large.png?v=1571606116%27%3E%27%3E'>
        <h6 class='mt-2'>Aw mans!</h6>
        <h4>Your Order has been cancelled</h4>
        <%if (errCode != null) {
            if (errCode.equals("missingValues")) {
                out.println("<p>Sorry, there are missing values</p>");
            } else if (errCode.equals("cartEmpty")) {
                out.println("<p>Sorry, cart is empty.</p>");
            } else if (errCode.equals("failedRecords")) {
                out.println("<p>Sorry, failed to add tour history</p>");
            } else if (errCode.equals("stripeError")) {
                out.println("<p>Sorry, Stripe Error</p>");
            } else if (errCode.equals("unknownError")) {
                out.println("<p>Sorry, unknown error occured</p>");
            }
        } else {
            out.println("<p>Sad to see you go! Please come back soon!</p>");
        }
        %>
           <a href="cart.jsp"><button class='bg-info text-white'>Return to cart</button></a>
    </div>
</body>
</html>