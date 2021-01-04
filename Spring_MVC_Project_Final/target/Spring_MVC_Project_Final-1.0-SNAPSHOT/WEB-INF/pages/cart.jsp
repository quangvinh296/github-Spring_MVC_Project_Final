<%-- 
    Document   : cart
    Created on : Nov 23, 2020, 10:57:30 AM
    Author     : my
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <jsp:include page="include/css-header.jsp" />
        <link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/cart.css"/>"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/cart_responsive.css"/>"/>

    </head>
    <body>
        <jsp:include page="include/menu1.jsp" />
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
                                            <li><a href="${pageContext.request.contextPath}/listCategory">Categories</a></li>
                                            <li>Shopping Cart</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="cart_info">
            <div class="container">
                <div class="row">
                    <div class="col">
                        <!-- Column Titles -->
                        <div class="cart_info_columns clearfix">
                            <div class="cart_info_col cart_info_col_product">Product</div>
                            <div class="cart_info_col cart_info_col_price">Price</div>
                            <div class="cart_info_col cart_info_col_quantity">Quantity</div>
                            <div class="cart_info_col cart_info_col_total">Total</div>
                        </div>
                    </div>
                </div>

                <div class="row cart_items_row">
                    <div class="col">
                        ${error}
                        <!-- Cart Item --><c:forEach var="item" items="${sessionScope.myCart}">
                            <div class="cart_item d-flex flex-lg-row flex-column align-items-lg-center align-items-start justify-content-start">
                                <!-- Name -->
                                <div class="cart_item_product d-flex flex-row align-items-center justify-content-start">
                                    <div class="cart_item_image">
                                         <c:forEach items="${images}" var="image" >
                                                <c:if test="${item.value.product.id == image.product.id}">
                                                    <div class="product_image"  style="height:300px;width:250px;"><a  href="${pageContext.request.contextPath}/productDetail/${p.id}"><img src="<c:url value="/resources/img/category/${image.name}"/>" alt=""></a></div>

                                                </c:if>
                                            </c:forEach>
                                    </div>
                                    <div class="cart_item_name_container">
                                        <div class="cart_item_name"><a href="${pageContext.request.contextPath}/productDetail/${item.value.product.id}">${item.value.product.name}</a></div>
                                        <br> 
                                    </div>
                                    <div><a href="${pageContext.request.contextPath}/remove/${item.value.product.id}">(-)</a></div>
                                </div>
                                <!-- Price -->
                                <div class="cart_item_price"><fmt:formatNumber value="${item.value.discount}" pattern="###,###" type="number"/>VND</div>
                                <!-- Quantity -->
                                <div class="cart_item_quantity">
                                    <div class="product_quantity_container">

                                        <form action="${pageContext.request.contextPath}/update/${item.value.product.id}" method="POST" class="form-inline">
                                            <div class="product_quantity clearfix">
                                                <span>Qty</span>
                                                <input name="quantity_input" style="width: 300px" class="form-control"  type="text" pattern="^[0-9]*$" value="${item.value.quantity}">
                                                <div class="quantity_buttons">
                                                    <input  name="button" type="submit" style="height:35px" value="+" class="quantity_inc quantity_control" />
                                                    <input  name="button" type="submit" style="height:35px" value="-" class="quantity_inc quantity_control" />
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div><!--
                                <!-- Total -->
                                <div class="cart_item_total"><fmt:formatNumber value=" ${item.value.discount * item.value.quantity }" pattern="###,###" type="number"/>VND</div>
                            </div>
                        </c:forEach>

                    </div>
                </div>

                <div class="row row_cart_buttons">

                    <div class="col">
                        <div class="cart_buttons d-flex flex-lg-row flex-column align-items-start justify-content-start">
                            <div class="button continue_shopping_button"><a href="${pageContext.request.contextPath}/listProduct">Continue shopping</a></div>
                            <c:if test="${sessionScope.myCartTotal != 0}">


                            </div>
                        </div>

                    </div>

                    <div class="row row_extra">
                        <div class="col-lg-4">
                            <!-- Coupon Code -->
                             <c:if test="${message == '' || message == null}">
                            <div class="coupon">
                                <div class="section_title">Coupon code</div>
                                <div class="section_subtitle">Enter your coupon code</div>
                                <div class="coupon_form_container">
                                    <form action="${pageContext.request.contextPath}/promotion" id="coupon_form" class="coupon_form">
                                        <input type="text" name="coupon_input" id="coupon_input" class="coupon_input" required="required">
                                        ${pro}
                                        <button class="button coupon_button"><span>Apply</span></button>
                                    </form>
                                </div>
                            </div>
                             </c:if>
                        </div>

                        <div class="col-lg-6 offset-lg-2">
                            <form action="${pageContext.request.contextPath}/checkout" class="coupon_form" method="post" >
                                <div class="cart_total">
                                    <div class="section_title">Cart total</div>

                                    <div class="cart_total_container">

                                        <ul>
                                            <li class="d-flex flex-row align-items-center justify-content-start">
                                                <div class="cart_total_title">SubTotal</div>
                                                <div class="cart_total_value ml-auto">
                                                    <fmt:formatNumber value=" ${sessionScope.myCartTotal}" pattern="###,###" type="number"/>VND

                                                </div>
                                            </li>
                                            <c:if test="${pro == 'success'}">
                                            <li class="d-flex flex-row align-items-center justify-content-start">
                                                <div class="cart_total_title">Discount</div>
                                                <div class="cart_total_value ml-auto">
                                                     
                                                         <fmt:formatNumber value=" ${sessionScope.myCartTotal*discount}" pattern="###,###" type="number"/>VND
                                                     <input type="hidden" path="discount" id="discount" name="discount" value="${sessionScope.myCartTotal*discount}">
                                                </div>
                                            </li>
                                            </c:if>
                                            <c:if test="${pro == 'error' || pro == null}">
                                                <input type="hidden" path="discount" id="discount" name="discount" value="0">
                                            </c:if>
                                            <li class="d-flex flex-row align-items-center justify-content-start">
                                                <div class="cart_total_title">Total</div>
                                                <div class="cart_total_value ml-auto">
                                                    <c:if test="${pro == 'success'}">
                                                        <fmt:formatNumber value="${sessionScope.myCartTotal-sessionScope.myCartTotal*discount}" pattern="###,###" type="number"/>VND
                                                        <input type="hidden" path="totalBill" id="totalBill" name="totalBill" value="${sessionScope.myCartTotal-sessionScope.myCartTotal*discount}">
                                                    </c:if>
                                                    <c:if test="${pro == 'error' || pro == null}">
                                                        <fmt:formatNumber value="${sessionScope.myCartTotal}" pattern="###,###" type="number"/>VND
                                                        <input type="hidden" path="totalBill" id="totalBill" name="totalBill" value="${sessionScope.myCartTotal}">
                                                    </c:if>
                                                  
                                                </div>
                                            </li>
                                        </ul>

                                    </div>
                                    <button class="checkout_button" style="height:55px;"type="submit">Proceed to checkout</button>
                                </div>
                            </form>
                        </c:if>
                    </div>		
                </div>


                <script src="<c:url value="/resources/js/jquery-3.2.1.min.js"/>"></script>
                <script src="<c:url value="/resources/styles/bootstrap4/popper.js"/>"></script>
                <script src="<c:url value="/resources/styles/bootstrap4/bootstrap.min.js"/>"></script>
                <script src="<c:url value="/resources/plugins/greensock/TweenMax.min.js"/>"></script>
                <script src="<c:url value="/resources/plugins/greensock/TimelineMax.min.js"/>"></script>
                <script src="<c:url value="/resources/plugins/scrollmagic/ScrollMagic.min.js"/>"></script>
                <script src="<c:url value="/resources/plugins/greensock/animation.gsap.min.js"/>"></script>
                <script src="<c:url value="/resources/plugins/greensock/ScrollToPlugin.min.js"/>"></script>
                <script src="<c:url value="/resources/plugins/easing/easing.js"/>"></script>
                <script src="<c:url value="/resources/plugins/parallax-js-master/parallax.min.js"/>"></script>
                <script src="<c:url value="/resources/js/cart.js"/>"></script>
                <jsp:include page="include/js-page.jsp" />
                </body>
                </html>