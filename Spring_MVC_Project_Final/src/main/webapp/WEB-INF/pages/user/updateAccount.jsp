<%-- 
    Document   : home
    Created on : Jun 20, 2019, 7:47:58 PM
    Author     : AnhLe
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
            <!-- Home -->

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
                                                <li><a href="index.html">Home</a></li>
                                                <li>MY ACCOUNT</li>
                                            </ul>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Contact -->

            <div class="contact">
                <div class="container">
                    <div class="row">
                        <div class="col-lg-2 contact_col"></div>
                        <!-- Get in touch -->
                        <div class="col-lg-8 contact_col">
                            <div class="get_in_touch">
                                <div class="section_title">MY ACCOUNT</div>
                                
                                <c:if test="${message != 'changePassword'}">
                                    <form action="${pageContext.request.contextPath}/user/updateAccount" id="contact_form" class="contact_form" method="post">
                                        <input value="${user.id}" name="id" hidden />
                                        <div>
                                            <!-- Subject -->
                                            <label for="contact_company">Fullname:</label>
                                            <input type="text" name ="fullName" id="fullName" value="${user.fullName}" class="contact_input">
                                        </div>
                                        <div>
                                            <!-- Subject -->
                                            <label for="contact_company">Email:</label>
                                            <input type="email" name="email" id="email" value="${user.email}" class="contact_input">
                                        </div>
                                       
                                        <div>
                                            <!-- Subject -->
                                            <label for="contact_company">Phone Number:</label>
                                            <input type="text" id="phone" name="phone" value="${user.phone}" class="contact_input">
                                        </div>
                                        <div>
                                            <!-- Subject -->
                                            <label for="contact_company">Address:</label>
                                            <input type="text" id="address" name="address" value="${user.address}" class="contact_input">
                                        </div>
                                        <div>
                                            <label for="contact_company">Birthday:</label>
                                            <input type="Date" id="birthDate" name="birthDate" value="${user.birthDate}" class="contact_input">
                                        </div>
                                       s
                                        <button class="button contact_button"><span>Update Information</span></button>
                                    </form>
                                </c:if>
                                <c:if test="${message == 'changePassword'}">
                                    <form action="${pageContext.request.contextPath}/user/updatePass" id="contact_form" class="contact_form" method="post">
                                        ${error}
                                       <c:if test="${error == null || error == ''}">
                                        <div>
                                            <!-- Subject -->
                                            <label for="contact_company">New Password:</label>
                                            <input type="text" id="phone" name="newpass" class="contact_input">
                                        </div>
                                        <button class="button contact_button"><span>Update Information</span></button>
                                       </c:if>
                                       </form>
                                        
                                </c:if>
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-2 contact_col"></div>

                </div>
            </div>
        </div>
        <jsp:include page="include/footer.jsp" />
    </div>
    <script src="<c:url value="/resources/js/contact.js"/>"></script>
    <jsp:include page="include/js-page.jsp" />
</body>
</html>
