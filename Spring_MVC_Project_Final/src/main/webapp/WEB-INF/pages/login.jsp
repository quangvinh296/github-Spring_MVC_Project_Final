<%-- 
    Document   : login
    Created on : Jun 20, 2019, 8:17:26 PM
    Author     : AnhLe
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="mvc" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <jsp:include page="include/css-header.jsp" />
        <link rel="stylesheet" href="<c:url value="resources/1/css/main.css"/>"/>
    </head>
    <body>
        <div class="super_container">
            <jsp:include page="include/menu1.jsp" />
            <!-- Start Banner Area -->
            <section class="banner-area organic-breadcrumb">
                <div class="container">
                    <div class="breadcrumb-banner d-flex flex-wrap align-items-center">
                        <div class="col-first">
                            <!--                            <h1>Shopping Cart</h1>
                                                        <nav class="d-flex align-items-center justify-content-start">
                                                            <a href="index.html">Home<i class="fa fa-caret-right" aria-hidden="true"></i></a>
                                                            <a href="cart.html">Shopping Cart</a>
                                                        </nav>-->
                        </div>
                    </div>
                </div>
            </section>
            <!-- End Banner Area -->

            <!-- Start My Account -->
            <div class="container">
                <div class="row">
                    <div class="col-md-3"></div>
                    <div class="col-md-6">
                        <div class="login-form">
                            <h3 class="billing-title text-center">Login</h3>
                            <p class="text-center mt-80 mb-40">Welcome back! Sign in to your account </p>
                                ${message}
                            <form action="j_spring_security_check" method="post">
                                <input type="email" name="email" placeholder="Email*" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Email*'" required class="common-input mt-20">
                                <input type="password" name="password" placeholder="Password*" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Password*'" required class="common-input mt-20">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                <button class="view-btn color-2 mt-20 w-100"><span>Login</span></button>
                                <div class="mt-20 d-flex align-items-center justify-content-between">
                                    
                                </div>
                            </form>
                        </div>
                    </div>
                   
                </div>
            </div>

        </div>
        <script src="<c:url value="resources/js/main.js"/>"></script> 

    </body>
</html>
