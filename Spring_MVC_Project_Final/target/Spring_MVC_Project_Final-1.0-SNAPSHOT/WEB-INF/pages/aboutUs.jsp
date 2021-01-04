<%-- 
    Document   : aboutUs
    Created on : Nov 23, 2020, 11:53:34 PM
    Author     : my
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib  uri="http://www.springframework.org/security/tags" prefix="sec" %>
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
                                                    <c:if test="${message != null && message!= ''}">
                                                    <li>Find Order</li>
                                                    </c:if>
                                                    <c:if test="${message == null && message== ''}">
                                                    <li>Contact</li>
                                                    </c:if>
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
                        <c:if test="${message == 'find'}">
                            <form action="${pageContext.request.contextPath}/findOrder"
                                  method="post" class="form-inline">
                                <div class="form-group">
                                    <input name="orderSearch" id="orderSearch" path="orderSearch" class="form-control"/>
                                    <input type="submit" value="Search" 
                                           class="btn btn-info" />
                                </div>
                            </form>
                        </c:if>
                    </div>

                    <div class="row">
                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12"
                             style="padding-top: 10px">
                            <div class="table-responsive">
                                <table class="table table-bordered table-hover">
                                    <c:if test="${message == 'findOrder'}">
                                        <c:if test="${type != 'error'}">
                                            <tr>
                                                <th>Number Order</th>
                                                <th>Name</th>
                                                <th>Address</th>
                                                <th>Date Order</th>
                                                <th>Your items</th>
                                                <th>Total</th>
                                                <th>Status</th>
                                                <c:if test="${order.status == 'CONFIRM' || order.status == 'SHIPPING' }">
                                                <th>Action</th>
                                                </c:if>
                                                
                                            </tr>


                                            <tr>
                                                <td><a href="${pageContext.request.contextPath}/orderDetail/${order.orderUId}">${order.orderUId}</a></td>
                                                <td>${order.fullName}</td>
                                                <td>${order.address}</td>

                                                <td> <fmt:formatDate value="${order.dateOrder}"
                                                                pattern="dd/MM/yyyy" /></td>
                                                <td>
                                                    <c:forEach items="${orderDetail}" var="d" >
                                                        <c:if test="${order.id == d.order.id}">
                                                            <a  href="${pageContext.request.contextPath}/productDetail/${d.product.id}">${d.quantity}&nbsp;&nbsp;${d.product.name}</a><br><br>
                                                        </c:if>
                                                    </c:forEach><br>
                                                </td>


                                                <td> <fmt:formatNumber value="${order.totalOrder}"
                                                                  pattern="###,###" type="number"/>VNĐ</td>
                                                <td>${order.status}</td>
                                                <c:if test="${order.status == 'CONFIRM' || order.status == 'SHIPPING' }">
                                                    <sec:authorize access="isAuthenticated()">
                                                        <td><a href="${pageContext.request.contextPath}/user/cancelOrder/${order.id}">Cancel</a></td>
                                                    </sec:authorize>
                                                    <sec:authorize access="!isAuthenticated()">
                                                        <td><a href="${pageContext.request.contextPath}/cancelOrder/${order.id}">Cancel</a></td>
                                                    </sec:authorize>
                                                </c:if>
                                            </tr>
                                            <p style="color: red">${cancel}</p>
                                        </c:if>
                                        <tr>
                                            <c:if test="${message == 'findOrder'&& order == null || order == ' '}">
                                                <td colspan="8" style="color: red">
                                                    NOT FOUND !!! FIND AGAIN
                                                </td>
                                            </c:if>
                                        </tr>
                                    </c:if>
                                </table>
                            </div>
                        </div>
                    </div>
                    <Br><Br><Br><Br><Br><Br><Br>
                    <div class="row">


                        <!-- Contact Info -->
                        <div class="col-lg-3 offset-xl-1 contact_col">
                            <div class="contact_info">
                                <div class="contact_info_section">
                                    <div class="contact_info_title">Marketing</div>
                                    <ul>
                                        <li>Phone: <span>+53 345 7953 3245</span></li>
                                        <li>Email: <span>vinh@gmail.com</span></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3 offset-xl-1 contact_col">
                            <div class="contact_info">
                                <div class="contact_info_section">
                                    <div class="contact_info_title">Shippiing & Returns</div>
                                    <ul>
                                        <li>Phone: <span>+53 345 7953 3245</span></li>
                                        <li>Email: <span>thanhmail@gmail.com</span></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3 offset-xl-1 contact_col">
                            <div class="contact_info">
                                <div class="contact_info_section">
                                    <div class="contact_info_title">Information</div>
                                    <ul>
                                        <li>Phone: <span>+53 345 7953 3245</span></li>
                                        <li>Email: <span>mymail@gmail.com</span></li>
                                    </ul>
                                </div>
                            </div>
                        </div>

                    </div>

                </div>

            </div>


            <jsp:include page="include/footer.jsp" />
        </div>
        <jsp:include page="include/js-page.jsp" />
    </body>
</html>
