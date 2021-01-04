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
                        <div class="col-lg-2 contact_col">
                           
                               
                        </div>
                        <!-- Get in touch -->
                        <div class="col-lg-8 contact_col">
                            <div class="get_in_touch">
                                <div class="section_title">MY ACCOUNT</div>

                                <div class="contact_form_container">
                                    <div>
                                        <!-- Subject -->
                                        <label for="contact_company">Fullname: ${user.fullName}</label>
                                    </div>
                                    <div>
                                        <!-- Subject -->
                                        <label for="contact_company">Email: ${user.email}</label>
                                    </div>
                                     <div>
                                        <!-- Subject -->
                                        <label for="contact_company">Password: ********</label><a href="${pageContext.request.contextPath}/user/updatePass">Change</a>
                                    </div>
                                    <div>
                                        <!-- Subject -->
                                        <label for="contact_company">Phone Number: ${user.phone}</label>
                                    </div>
                                    <div>
                                        <!-- Subject -->
                                        <label for="contact_company">Address: ${user.address}</label>
                                    </div>
                                    <div>
                                        <label for="contact_company">Birthday: ${user.birthDate}</label>
                                    </div>
                                    <div class="button contact_button"><a href="${pageContext.request.contextPath}/user/update">Update Information</span></div>

                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <jsp:include page="include/footer.jsp" />
        </div>
        <script src="<c:url value="/resources/js/contact.js"/>"></script>
        <jsp:include page="include/js-page.jsp" />
    </body>
</html>
