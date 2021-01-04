<%-- 
    Document   : 403
    Created on : Nov 23, 2020, 10:57:15 AM
    Author     : my
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <jsp:include page="include/css-header.jsp" />
        <link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/contact.css"/>"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/contact_responsive.css"/>"/>
    </head>
    <body>
        <div class="super_container">
            <jsp:include page="include/menu1.jsp" />
            <div class="home">
                <div class="home_container">
                    <div class="home_background" style="background-image:url(${pageContext.request.contextPath}/resources/images/contact.jpg)"></div>
                    <div class="home_content_container">
                        <div class="container">
                            <div class="row">
                                <div class="col">
                                    <div class="home_content">
                                        <div class="breadcrumbs">
                                            <ul>
                                                <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
                                                <li>Order Detail</li>
                                                <li>${orderUId}</li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="row">
                    <div class="col-lg-2 contact_col">


                    </div>
                    <!-- Get in touch -->
                    <div class="col-lg-8 contact_col">
                        <div class="get_in_touch">
                            <div class="contact_form_container">
                                <table class="table table-bordered table-hover" style="color:black;">
                                    <tr>
                                        <th>Name Product</th>
                                        <th>Quantity</th>
                                        <th>Price</th>
                                        <th>Total</th>                                      
                                    </tr>
                                    <c:forEach items="${orderDetail}" var="d">
                                        <tr>
                                            <td>${d.product.name}</td>
                                            <td>${d.quantity}</td>
                                            <td><fmt:formatNumber value="${d.discount}" pattern="###,###" type="number"/>VNĐ</td>
                                            <td> <fmt:formatNumber value="${d.discount*d.quantity}" pattern="###,###" type="number"/>VNĐ</td>

                                        </tr>
                                    </c:forEach>

                                </table>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="include/js-page.jsp" />
    </body>
</html>
