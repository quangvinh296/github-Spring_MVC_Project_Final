<%-- 
    Document   : listProduct
    Created on : Nov 23, 2020, 11:23:24 AM
    Author     : my
--%>
<%@taglib  uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <jsp:include page="include/css-header.jsp" />
        <link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/categories.css"/>"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/categories_responsive.css"/>"/>
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"/>
    </head>
    <body>
        <div class="super_container">
            <jsp:include page="include/menu1.jsp" />
            <div class="home">
                <div class="home_container">
                    <div class="home_background" style="background-image:url(${pageContext.request.contextPath}/resources/img/logo/hinh-nen-dep-mau-trang_104324637.jpg)"></div>
                    <div class="home_content_container">
                        <div class="container">
                            <div class="row">
                                <div class="col">
                                        <div class="home_content">
                                            <div class="home_title" style="color:grey;">MY FAVORITE PAGE<span>.</span></div>
                                        </div>
                                 
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Products -->

            <div class="products">
                <div class="container">
                    
                    <div class="row">
                        <div class="col">
                            <div class="product_grid">
                                <!-- Product -->
                                <c:forEach items="${favorites}" var="f">
                                    <div class="product">

                                        <c:forEach items="${images}" var="image" >
                                            <c:if test="${f.product.id == image.product.id}">
                                                <div class="product_image"  style="height:300px;width:260px;"><a href="${pageContext.request.contextPath}/productDetail/${f.product.id}"><img style="height:260px; width:250px;"src="<c:url value="/resources/img/category/${image.name}"/>" alt=""></a></div>
                                            <div class="product_extra product_new" style="transform: rotate(0deg);margin-left:-54px;"><a href="${pageContext.request.contextPath}/user/removeFavorite/favoriteProduct/${f.product.id}" class="like-btn"><span style="color:red;" class="fas fa-heart"></span></a></div>
                                            </c:if>
                                        </c:forEach>
                                        <div class="product_content">

                                            <div class="product_title" style="text-align:center;"><a href="${pageContext.request.contextPath}/productDetail/${f.product.id}">${f.product.name}</a></div>
                                            <div class="product_price" style="text-align:center;">
                                                <fmt:formatNumber value="${f.product.price}" pattern="###,###" type="number"/> VND
                                            </div>
                                        </div>
                                    </div>

                                </c:forEach >
                             
                            </div>
                        </div>
                      

                    </div>
                </div>
            </div>
        </div>

        <!-- Icon Boxes -->

        <div class="icon_boxes">
            <div class="container">
                <div class="row icon_box_row">

                    <!-- Icon Box -->
                    <div class="col-lg-4 icon_box_col">
                        <div class="icon_box">
                            <div class="icon_box_image"><img src="<c:url value="/resources/images/icon_1.svg"/>" alt=""></div>
                            <div class="icon_box_title">Free Shipping Worldwide</div>

                        </div>
                    </div>

                    <!-- Icon Box -->
                    <div class="col-lg-4 icon_box_col">
                        <div class="icon_box">
                            <div class="icon_box_image"><img src="<c:url value="/resources/images/icon_2.svg"/>" alt=""></div>
                            <div class="icon_box_title">Free Returns</div>

                        </div>
                    </div>

                    <!-- Icon Box -->
                    <div class="col-lg-4 icon_box_col">
                        <div class="icon_box">
                            <div class="icon_box_image"><img src="<c:url value="/resources/images/icon_3.svg"/>" alt=""></div>
                            <div class="icon_box_title">24h Fast Support</div>

                        </div>
                    </div>

                </div>
            </div>
        </div>

        <!-- Newsletter -->

        <div class="newsletter">
            <div class="container">
                <div class="row">
                    <div class="col">
                        <div class="newsletter_border"></div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-8 offset-lg-2">
                        <div class="newsletter_content text-center">
                            <div class="newsletter_title">Subscribe to our newsletter</div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <jsp:include page="include/footer.jsp" />
    </div>
    <jsp:include page="include/js-page.jsp" />
    <script src="<c:url value="/resources/js/categories.js"/>"></script>
</body>
</html>