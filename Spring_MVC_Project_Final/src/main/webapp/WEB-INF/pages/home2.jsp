<%-- 
    Document   : home2
    Created on : Nov 18, 2020, 8:02:05 PM
    Author     : ASUS
--%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib  uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <!-- Author Meta -->
        <meta name="author" content="CodePixar">
        <!-- Meta Description -->
        <meta name="description" content="">
        <!-- Meta Keyword -->
        <meta name="keywords" content="">
        <!-- meta character set -->
        <meta charset="UTF-8">
        <title>JSP Page</title>

        <jsp:include page="include/css-header.jsp" />
    </head>
    <body>
        <div class="super_container">
            <jsp:include page="include/menu1.jsp" />

            <div class="home"   style="height:600px;">
                <div class="home_slider_container"  style="height:550px;">

                    <!-- Home Slider -->
                    <div class="owl-carousel owl-theme home_slider">

                        <!-- Slider Item -->
                        <div class="owl-item home_slider_item">
                            <a href="${pageContext.request.contextPath}/promotion">
                                <div class="home_slider_background" style="background-image:url(${pageContext.request.contextPath}/resources/img/promotion/b996db8f7393160f33d896c7b417e887.jpg);height:450px;"></div>
                            </a>
                            <div class="home_slider_content_container">
                                <div class="container">
                                    <div class="row">
                                        <div class="col">
                                            <div class="home_slider_content"  data-animation-in="fadeIn" data-animation-out="animate-out fadeOut">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Slider Item -->
                        <div class="owl-item home_slider_item">
                            <a href="${pageContext.request.contextPath}/promotion">
                                <div class="home_slider_background" style="background-image:url(${pageContext.request.contextPath}/resources/img/promotion/samsung-1212-sale-lazada-philippines-2019.jpg);height:600px;"></div>
                            </a>
                            <div class="home_slider_content_container">
                                <div class="container">
                                    <div class="row">
                                        <div class="col">
                                            <div class="home_slider_content"  data-animation-in="fadeIn" data-animation-out="animate-out fadeOut">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Slider Item -->
                        <div class="owl-item home_slider_item" >
                            <a href="${pageContext.request.contextPath}/promotion">
                                <div class="home_slider_background" style="background-image:url(${pageContext.request.contextPath}/resources/img/promotion/samsung-galaxy-a71-053720-033719-472.jpg);height:600px;"></div>
                            </a>
                            <div class="home_slider_content_container">
                                <div class="container">
                                    <div class="row">
                                        <div class="col">
                                            <div class="home_slider_content"  data-animation-in="fadeIn" data-animation-out="animate-out fadeOut">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>

                    <!-- Home Slider Dots -->

                    <div class="home_slider_dots_container" >
                        <div class="container">
                            <div class="row">
                                <div class="col">
                                    <div class="home_slider_dots">
                                        <ul id="home_slider_custom_dots" class="home_slider_custom_dots">
                                            <li class="home_slider_custom_dot active">01.</li>
                                            <li class="home_slider_custom_dot">02.</li>
                                            <li class="home_slider_custom_dot">03.</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>	
                    </div>

                </div>
            </div>

            <!-- Ads -->

            <div class="avds">
                <div class="avds_container d-flex flex-lg-row flex-column align-items-start justify-content-between">
                    <div class="avds_small">
                        <div class="avds_background" style="background-image:url(${pageContext.request.contextPath}/resources/img/promotion/article_4246.jpg)"></div>
                        <div class="avds_small_inner">
                            <div class="avds_discount_container">
                                <img src="<c:url value="/resources/images/discount.png"/>" alt="">
                                <div>
                                    <div class="avds_discount">
                                        <div>20<span>%</span></div>
                                        <div>Discount</div>
                                    </div>
                                </div>
                            </div>
                            <div class="avds_small_content">
                                <div class="avds_title">Smart Phones</div>

                                <div class="avds_link"><a href="categories.html">See More</a></div>
                            </div>
                        </div>
                    </div>
                    <div class="avds_large">
                        <div class="avds_background" style="background-image:url(${pageContext.request.contextPath}/resources/img/promotion/Vivo-V20-SE.jpg)"></div>
                        <div class="avds_discount_container">
                            <img src="<c:url value="/resources/images/discount.png"/>" alt="">
                            <div>
                                <div class="avds_discount">
                                    <div>30<span>%</span></div>
                                    <div>Discount</div>
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
                                <br><br><br>
                                <c:forEach items="${products}" var="p">
                                    <c:if test="${p.quantityProduct > 0}">
                                        <div class="product">
                                            <c:forEach items="${images}" var="image" >
                                                <c:if test="${p.id == image.product.id}">
                                                    <div class="product_image"  style="height:300px;width:250px;"><a  href="${pageContext.request.contextPath}/productDetail/${p.id}"><img src="<c:url value="/resources/img/category/${image.name}"/>" alt=""></a></div>

                                                </c:if>
                                            </c:forEach>
                                            <div class="product_extra product_new" style="color:red;"><a href="#" >New</a></div>
                                            <div class="product_content">
                                                <div class="product_title" style="text-align:center;"><a href="${pageContext.request.contextPath}/productDetail/${p.id}">${p.name}</a></div>
                                                    <c:set scope="request" var="discount" value="1" />
                                                    <c:forEach items="${promotion}" var="pro">
                                                        <c:forEach items="${pro.categories}" var="c">

                                                        <c:if test="${ p.category.id == c.id}">
                                                            <div class="product_price" style="text-align:center;color:red;"><fmt:formatNumber value="${p.price*(1-pro.discount)}"
                                                                              pattern="###,###" type="number"/>VNĐ</div>


                                                            <c:remove scope="request" var="discount" />
                                                        </c:if>
                                                    </c:forEach>

                                                </c:forEach>
                                                <c:if test="${ discount == null}">
                                                    <div class="product_price" style="text-align:center;color:black;text-decoration-line:line-through;"><fmt:formatNumber value="${p.price}"
                                                                      pattern="###,###" type="number"/>VNĐ</div>
                                                    </c:if>
                                                    <c:if test="${ discount != null}">
                                                    <div class="product_price" style="text-align:center;color:red;"><fmt:formatNumber value="${p.price}" pattern="###,###" type="number"/> VND</div>
                                                </c:if>


                                            </div>
                                        </div>
                                    </c:if>
                                    <c:if test="${p.quantityProduct == 0}">
                                        <div class="product">
                                            <div class="product_image"><img src="<c:url value="/resources/images/product_1.jpg"/>" alt=""></div>
                                            <div class="product_extra product_new" style="color:red;"><a href="#" >Sold out</a></div>
                                            <div class="product_content">
                                                <div class="product_title" style="text-align:center;"><a href="${pageContext.request.contextPath}/productDetail/${p.id}">${p.name}</a></div>
                                                <div class="product_price" style="text-align:center;"><fmt:formatNumber value="${p.price}" pattern="###,###" type="number"/> VND</div>
                                            </div>
                                        </div>
                                    </c:if>
                                </c:forEach>

                            </div>

                        </div>
                    </div>
                </div>
            </div>

            <!-- Ad -->

            <div class="avds_xl">
                <div class="container">
                    <div class="row">
                        <div class="col">
                            <div class="avds_xl_container clearfix">
                                <a href="#"><div class="avds_xl_background" style="background-image:url(${pageContext.request.contextPath}/resources/img/promotion/j6b-pc.jpg)"></div></a>
                                <div class="avds_discount_container">
                                    <img src="<c:url value="/resources/images/discount.png"/>" alt="">
                                    <div>
                                        <div class="avds_discount">
                                            <div>New</div>
                                            <div>Product</div>
                                        </div>
                                    </div>
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
                                <div class="icon_box_image"><img src="<c:url value="/resources/images/icon_1.svg" />"alt=""></div>
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

        </div>
        <jsp:include page="include/js-page.jsp" />
    </body>
</html>
