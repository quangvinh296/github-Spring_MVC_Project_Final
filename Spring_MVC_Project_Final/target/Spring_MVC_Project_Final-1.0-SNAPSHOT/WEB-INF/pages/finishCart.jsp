<%-- 
    Document   : finishCart
    Created on : Nov 23, 2020, 11:02:14 AM
    Author     : my
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="<c:url value="resources/1/css/main.css"/>"/>
        <jsp:include page="include/css-header.jsp" />
    </head>
    <body>
        <div class="super_container">
            <jsp:include page="include/menu1.jsp" />
            <!-- Start Banner Area -->
            <section class="banner-area organic-breadcrumb">
                <div class="container">
                    <div class="breadcrumb-banner d-flex flex-wrap align-items-center">
                        <div class="col-first">
                            <h1>Order Confermation</h1>
                            <nav class="d-flex align-items-center justify-content-start">
                                <a href="${pageContext.request.contextPath}/home">Home<i class="fa fa-caret-right" aria-hidden="true"></i></a>
                                
                            </nav>
                        </div>
                    </div>
                </div>
            </section>
            <!-- End Banner Area -->

            <!-- Start Checkout Area -->
            <div class="container">
                <p class="text-center">Thank you. Your order has been received.</p>
                <p class="text-center">My Order: ${orderUID}</p>
                <div class="row mt-50">
                    <div class="col-md-4">
                        <h3 class="billing-title mt-20 pl-15">Order Info</h3>
                        <table class="order-rable">
                            <tr>
                                <td>Order number</td>
                                <td>: 60235</td>
                            </tr>
                            <tr>
                                <td>Date</td>
                                <td>: Oct 03, 2017</td>
                            </tr>
                            <tr>
                                <td>Total</td>
                                <td>: USD 2210</td>
                            </tr>
                            <tr>
                                <td>Payment method</td>
                                <td>: Check payments</td>
                            </tr>
                        </table>
                    </div>
                    <div class="col-md-4">
                        <h3 class="billing-title mt-20 pl-15">Billing Address</h3>
                        <table class="order-rable">
                            <tr>
                                <td>Street</td>
                                <td>: 56/8 panthapath</td>
                            </tr>
                            <tr>
                                <td>City</td>
                                <td>: Dhaka</td>
                            </tr>
                            <tr>
                                <td>Country</td>
                                <td>: Bangladesh</td>
                            </tr>
                            <tr>
                                <td>Postcode</td>
                                <td>: 1205</td>
                            </tr>
                        </table>
                    </div>
                    <div class="col-md-4">
                        <h3 class="billing-title mt-20 pl-15">Shipping Address</h3>
                        <table class="order-rable">
                            <tr>
                                <td>Street</td>
                                <td>: 56/8 panthapath</td>
                            </tr>
                            <tr>
                                <td>City</td>
                                <td>: Dhaka</td>
                            </tr>
                            <tr>
                                <td>Country</td>
                                <td>: Bangladesh</td>
                            </tr>
                            <tr>
                                <td>Postcode</td>
                                <td>: 1205</td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
            <!-- End Checkout Area -->
            <!-- Start Billing Details Form -->
            <div class="container">
                <div class="billing-form">
                    <div class="row">
                        <div class="col-12">
                            <div class="order-wrapper mt-50">
                                <h3 class="billing-title mb-10">Your Order</h3>
                                <div class="order-list">
                                    <div class="list-row d-flex justify-content-between">
                                        <div>Product</div>
                                        <div>Total</div>
                                    </div>
                                    <div class="list-row d-flex justify-content-between">
                                        <div>Pixelstore fresh Blackberry</div>
                                        <div>x 02</div>
                                        <div>$720.00</div>
                                    </div>
                                    <div class="list-row d-flex justify-content-between">
                                        <div>Pixelstore fresh Blackberry</div>
                                        <div>x 02</div>
                                        <div>$720.00</div>
                                    </div>
                                    <div class="list-row d-flex justify-content-between">
                                        <div>Pixelstore fresh Blackberry</div>
                                        <div>x 02</div>
                                        <div>$720.00</div>
                                    </div>
                                    <div class="list-row d-flex justify-content-between">
                                        <h6>Subtotal</h6>
                                        <div>$2160.00</div>
                                    </div>
                                    <div class="list-row d-flex justify-content-between">
                                        <h6>Shipping</h6>
                                        <div>Flat rate: $50.00</div>
                                    </div>
                                    <div class="list-row border-bottom-0 d-flex justify-content-between">
                                        <h6>Total</h6>
                                        <div class="total">$2210.00</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- End Billing Details Form -->
          
        </div>
        <jsp:include page="include/js-page.jsp" />
        <script src="<c:url value="resources/1/js/main.js"/>"></script>  
    </body>
</html>
