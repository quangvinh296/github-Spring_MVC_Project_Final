<%-- 
    Document   : checkout
    Created on : Nov 23, 2020, 11:22:42 AM
    Author     : my
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <jsp:include page="include/css-header.jsp" />
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/checkout.css"/>"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/checkout_responsive.css"/>"/>

    <body>
        <div class="super_container">
            <jsp:include page="include/menu1.jsp" />
            <!-- Checkout -->
            <div class="home">
                <div class="home_container">
                    <div class="home_background" style="background-image:url(${pageContext.request.contextPath}/resources/images/cart.jpg)"></div>
                    <div class="home_content_container">
                        <div class="container">
                            <div class="row">
                                <div class="col">
                                    <div class="home_content">
                                        <div class="breadcrumbs">
                                            <ul>
                                                <li><a href="${pageContext.request.contextPath}/home">Home</a></li>
                                                <li><a href="#">Checkout</a></li>

                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="checkout">
                <form action="${pageContext.request.contextPath}/creditcard" method="POST" modelAttribute="user">
                    <div class="container">
                        <div class="row">
                            <input type="hidden" path="totalBill" id="totalBill" name="totalBill" value="${totalBill}">
                            <!-- Billing Info -->
                            <div class="col-lg-6">
                                <div class="billing checkout_section">
                                    <div class="section_title">Billing Address</div>
                                    <div class="section_subtitle">Enter your address info</div>
                                    <div class="checkout_form_container">

                                        <div>
                                            <!-- Company -->
                                            <label for="checkout_company">Fullname *</label>
                                            <input type="text" name="fullName" id="fullName" class="checkout_input" pattern="^[a-zA-Z '\s]*$" value="${user.fullName}" required="required">
                                        </div>
                                        <div>
                                            <!-- Phone no -->
                                            <label for="checkout_phone">Phone *</label>
                                            <input type="phone" name="phone" id="phone" class="checkout_input" pattern="^[0-9]*$" value="${user.phone}" required="required">
                                        </div>
                                        <c:if test="${user.email == null}">
                                            <div>
                                                <!-- Email -->
                                                <label for="checkout_email">Email *</label>
                                                <input type="email" name="email" id="email" class="checkout_input" required="required">
                                            </div>
                                        </c:if>
                                        <c:if test="${user.email != null}">

                                            <input type="hidden" name="email" id="email" value="${user.email}" class="checkout_input" required="required">

                                        </c:if>
                                        <div>
                                            <!-- Address -->
                                            <label for="checkout_address">Address*</label>
                                            <input type="text" id="address" name="address" class="checkout_input" value="${user.address}" required="required">

                                        </div>

                                    </div>
                                    <!-- Payment Options -->

                                </div>
                            </div>


                            <div class="col-lg-6">

                                <div class="order checkout_section">
                                    <div class="section_title">Your order</div>


                                    <!-- Order details -->
                                    <div class="order_list_container">
                                        <div class="order_list_bar d-flex flex-row align-items-center justify-content-start">
                                            <div class="order_list_title">Product</div>
                                            <div class="order_list_value ml-auto">Total</div>
                                        </div>
                                        <ul class="order_list">
                                            <c:forEach var="item" items="${sessionScope.myCart}">
                                                <li class="d-flex flex-row align-items-center justify-content-start">
                                                    <div class="order_list_title" style="color:blue;">${item.value.quantity}&nbsp;&nbsp;&nbsp;${item.value.product.name}</div>
                                                    <div class="order_list_value ml-auto" style="color:blue;">

                                                        <fmt:formatNumber value="${item.value.discount}" pattern="###,###" type="number"/>VND</div>
                                                </li>
                                            </c:forEach>
                                            <li class="d-flex flex-row align-items-center justify-content-start">
                                                <div class="order_list_title">Subtotal</div>
                                                <div class="order_list_value ml-auto" style="color:blue;">
                                                    <fmt:formatNumber value=" ${sessionScope.myCartTotal}" pattern="###,###" type="number"/>VND
                                                </div>
                                            </li>
                                            <c:if test="${discount != 0}">
                                                <li class="d-flex flex-row align-items-center justify-content-start">
                                                    <div class="order_list_title">Discount</div>
                                                    <div class="order_list_value ml-auto" style="color:grey;">

                                                        <fmt:formatNumber value=" ${discount}" pattern="###,###" type="number"/>VND

                                                    </div>

                                                </li>
                                            </c:if>
                                            <li class="d-flex flex-row align-items-center justify-content-start">
                                                <div class="order_list_title">Total</div>
                                                <div class="order_list_value ml-auto" style="color:blue;">
                                                    <fmt:formatNumber  value="${totalBill}" pattern="###,###" type="number"/>VND

                                                </div>
                                            </li>
                                        </ul>
                                    </div>

                                    <button class="checkout_button" style="color:red;font-size: 20px;margin-left: 150px;text-align: center;border: 2px none #b1154a;" type="submit">Place Order</button>
                                    <!-- Order Text -->
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <jsp:include page="include/js-page.jsp" />

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>
</html>
