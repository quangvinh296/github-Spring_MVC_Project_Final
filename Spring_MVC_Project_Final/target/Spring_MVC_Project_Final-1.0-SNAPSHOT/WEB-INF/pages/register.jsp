<%-- 
    Document   : login
    Created on : Jun 20, 2019, 8:17:26 PM
    Author     : AnhLe
--%>

<%@page import="java.util.Date"%>
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
                    <div class="col-md-3">

                    </div>
                    <div class="col-md-6">
                        <div class="register-form">
                            <h3 class="billing-title text-center">Register</h3>
                            <p class="text-center mt-40 mb-30">Create your very own account </p>
                            <p style="color:white;">${message1}</p>
                            <mvc:form action="${pageContext.request.contextPath}/Register" method="POST" modelAttribute="user">
                                <input type="text" id="fullName" name="fullName"  placeholder="Full name*" pattern="^[a-zA-Z '\s]*$" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Full name*'" required class="common-input mt-20">
                                <input type="email" id="email" name="email"  placeholder="Email address*" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Email address*'" required class="common-input mt-20">
                                <input type="tel" id="phone" name="phone" placeholder="Phone number*" pattern="^[0-9]*$" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Phone number*'" required class="common-input mt-20">
                                <input type="password" id="password" name="password" placeholder="Password*" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Password*'" required class="common-input mt-20">
                                <input type="address" id="address" name="address"  placeholder="Address*" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Adrress*'" required class="common-input mt-20">
                                <input type="date" id="birthDate" name="birthDate"  placeholder="Birthdate*" onfocus="this.placeholder = ''" onblur="this.placeholder = 'Birthdate*'" required class="common-input mt-20">
                                
                                <p>Gender:<br>
                                    <c:forEach items="${genders}" var="g">

                                        <input type="radio" name="gender" 
                                               value="${g}"/>${g} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    </c:forEach>
                                </p>
                                <button class="view-btn color-2 mt-20 w-100"><span>Register</span></button>
                            </mvc:form>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        <script src="<c:url value="resources/js/main.js"/>"></script> 

    </body>
</html>
