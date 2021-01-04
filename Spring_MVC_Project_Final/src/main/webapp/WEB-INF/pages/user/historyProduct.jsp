<%-- 
    Document   : home
    Created on : Jun 20, 2019, 7:47:58 PM
    Author     : AnhLe
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
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
                                                <li>HISTORY ORDER</li>

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

                        <div class="col-lg-12 contact_col">
                            <div class="get_in_touch">
                                <div class="section_title" style="color:rgba;">HISTORY ORDER</div>

                                <div class="contact_form_container" style="color:black;">
                                   
                                    <table class="table table-bordered table-hover" style="color:black;">
                                        <tr>
                                            <th colspan="2">Number Order</th>
                                            <th>Name</th>
                                            <th>Address</th>
                                            <th>Date Order</th>
                                            <th>Total</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                            
                                            
                                        </tr>
                                        <c:forEach items="${orders}" var="orders">
                                            <tr>
                                                <td colspan="2"><a href="${pageContext.request.contextPath}/orderDetail/${orders.orderUId}">${orders.orderUId}</a></td></td>
                                                <td>${orders.user.fullName}</td>
                                                <td>${orders.user.address}</td>
                                                <td> <fmt:formatDate value="${orders.dateOrder}"
                                                                pattern="dd/MM/yyyy" /></td>
                                               
                                                <td> <fmt:formatNumber value="${orders.totalOrder}"
                                                                  pattern="###,###" type="number"/>VNĐ</td>
                                                <td>${orders.status}</td>
                                               <td> <c:if test="${orders.status == 'CONFIRM' || orders.status == 'SHIPPING' }">
                                                    <a href="${pageContext.request.contextPath}/user/history/${orders.id}">Cancel</a>
                                                </c:if></td>

                                            </tr>
                                        </c:forEach>

                                    </table>
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
