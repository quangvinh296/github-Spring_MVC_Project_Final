<%-- 
    Document   : productDetail
    Created on : Nov 23, 2020, 11:23:39 AM
    Author     : my
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib  uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <jsp:include page="include/css-header.jsp" />
        <link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/product.css"/>"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/product_responsive.css"/>"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/resources/styles/comment.css"/>"/>

    </head>
    <body>
        <div class="super_container">
            <jsp:include page="include/menu1.jsp" />
            <!-- Home -->

            <div class="home">
                <div class="home_container">
                    <div class="home_background" style="background-image:url(${pageContext.request.contextPath}/resources/images/categories.jpg)"></div>
                    <div class="home_content_container">
                        <div class="container">
                            <div class="row">
                                <div class="col">
                                    <div class="home_content">
                                        <div class="home_title">${productDetail.name}<span>.</span></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Product Details -->

            <div class="product_details">
                <div class="container">
                    <div class="row details_row">

                        <!-- Product Image -->
                        <div class="col-lg-6">
                            <div class="details_image">
                                <c:forEach items="${img}" var="img" >
                                    <c:if test="${productDetail.id == img.product.id}">
                                        <div class="product_image" ><a  href="${pageContext.request.contextPath}/productDetail/${productDetail.id}"><img  style="height:400px;width:380px;" src="<c:url value="/resources/img/category/${img.name}"/>" alt=""></a></div>

                                    </c:if>
                                </c:forEach>

                                <div class="details_image_thumbnails d-flex flex-row align-items-start justify-content-between">

                                    <c:forEach items="${img}" var="img" >
                                        <c:if test="${productDetail.id == img.product.id}">
                                            <div class="details_image_thumbnail active" data-image="<c:url value="/resources/img/category/${img.name}"/>"><img src="<c:url value="/resources/img/category/${img.name}"/>" alt=""></div>
                                            </c:if>
                                        </c:forEach>
                                        <c:forEach items="${images}" var="images" >
                                            <c:if test="${productDetail.id == images.product.id}">
                                            <div class="details_image_thumbnail" data-image="<c:url value="/resources/img/category/${images.name}"/>"><img src="<c:url value="/resources/img/category/${images.name}"/>" alt=""></div>    
                                            </c:if>
                                        </c:forEach>

                                </div>
                            </div>
                        </div>

                        <!-- Product Content -->
                        <div class="col-lg-6">
                            <div class="details_content">

                                <div class="details_name">${productDetail.name}</div>
                                <div class="details_price"><fmt:formatNumber value="${productDetail.price*(1-discount)}"
                                                  pattern="###,###" type="number"/>VNĐ</div><br><br>
                                    <c:if test="${discount != 0}">

                                    <div class="details_discount"><fmt:formatNumber value="${productDetail.price}"
                                                      pattern="###,###" type="number"/>VNĐ</div>
                                    </c:if>

                                <!-- In Stock -->
                                <div class="in_stock_container">
                                    <div class="availability">Availability:</div>
                                    <span>${message}</span>
                                </div>
                                <p>${error}</p>
                                <!-- Product Quantity --><c:if test="${message == null}">
                                    <form action="${pageContext.request.contextPath}/updateQuantity/${productDetail.id}" method="POST" class="form-inline">

                                        <div class="product_quantity_container">
                                            <div class="product_quantity clearfix">
                                                <span>Qty</span>
                                                <input type="hidden" path="priceDiscount" id="priceDiscount" name="priceDiscount" value="${productDetail.price*(1-discount)}">
                                                <input  path="quantity_input" name="quantity_input" class="form-control" id="quantity_input" type="text" pattern="^([1-9][0-9]{0,2}|1000)$" value="1"/>
                                                <div class="quantity_buttons">
                                                    <div id="quantity_inc_button" class="quantity_inc quantity_control"><i class="fa fa-chevron-up" aria-hidden="true"></i></div>
                                                    <div id="quantity_dec_button" class="quantity_dec quantity_control"><i class="fa fa-chevron-down" aria-hidden="true"></i></div>
                                                </div>
                                            </div>

                                            <input type="submit" value="Add to cart" class="button cart_button" />



                                    </form>
                                    <sec:authorize access="isAuthenticated()">
                                            <c:if test="${productDetail.id == favorite.product.id}">
                                                <div class="form-control" style="color:red;"><a style="color:red;" href="${pageContext.request.contextPath}/user/removeFavorite/productDetail/${productDetail.id}" class="like-btn"><span style="color:red;" class="lnr lnr-heart"></span>Favorite</a></div>
                                            </c:if>
                                            <c:if test="${productDetail.id != favorite.product.id}">
                                                <div class="form-control" style="color:black;"><a style="color:black;" href="${pageContext.request.contextPath}/user/favorite/${productDetail.id}" class="like-btn"><span class="lnr lnr-heart" style="color:black;"></span>Favorite</a></div>
                                            </c:if>
                                    </sec:authorize>
                                </div>
                            </c:if>

                            <!-- Share -->
                            <div class="details_share">
                                <span>Share:</span>
                                <ul>
                                    <li><a href="#"><i class="fa fa-pinterest" aria-hidden="true"></i></a></li>
                                    <li><a href="#"><i class="fa fa-instagram" aria-hidden="true"></i></a></li>
                                    <li><a href="#"><i class="fa fa-facebook" aria-hidden="true"></i></a></li>
                                    <li><a href="#"><i class="fa fa-twitter" aria-hidden="true"></i></a></li>
                                </ul>
                            </div>
                        </div>
                    </div>


                    <div class="row description_row">
                        <div class="col">
                            <div class="description_title_container">
                                <div class="reviews_title"><a href="${pageContext.request.contextPath}/description/${productDetail.id}">Description            |    </a></div>

                                <div class="reviews_title"><a href="${pageContext.request.contextPath}/technical/${productDetail.id}">Technical specifications            |</a></div>

                                <div class="reviews_title"><a href="#"><a href="${pageContext.request.contextPath}/comment/${productDetail.id}">Reviews <span></span></a></div>
                            </div>
                            <c:if test="${message1 == 'description'}">
                                <div class="description_text">
                                    <p>${productDetail.description}</p>
                                </div>
                            </c:if>
                            <c:if test="${message1 == 'technical'}">
                                <div class="reviews_title">
                                    <Br><Br><Br><Br>
                                    <h3>Technical specifications</h3>
                                    <table class="table table-striped">

                                        <tr>
                                            <td>Screen:</td>
                                            <td>${productDetail.screen}</td>
                                        </tr>
                                        <tr>
                                            <td>Operating system:</td>
                                            <td>${productDetail.frontCamera}</td>
                                        </tr>
                                        <tr>
                                            <td>Rear camera:</td>
                                            <td>${productDetail.rearCamera}</td>
                                        </tr>
                                        <tr>
                                            <td>Front camera:</td>
                                            <td>${productDetail.frontCamera}</td>
                                        </tr>
                                        <tr>
                                            <td>RAM:</td>
                                            <td>${productDetail.ram}</td>
                                        </tr>
                                        <tr>
                                            <td>Memory card:</td>
                                            <td>${productDetail.memoryCard}</td>
                                        </tr>
                                        <tr>
                                            <td>Battery capacity:</td>
                                            <td>${productDetail.battery}</td>
                                        </tr>

                                    </table> 
                                </div>
                            </c:if>
                            <c:if test="${message1 == 'comment'}">

                                <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
                                    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
                                    <div class="container">
                                        <div class="be-comment-block">
                                            <h1 class="comments-title" style="color:red;">Comments (${count})</h1>
                                            <div class="be-comment"style="color:black;">
                                                <c:forEach items="${comment}" var="cmt" >
                                                    <div class="be-comment-content">

                                                        <span class="be-comment-name">
                                                            <i >${cmt.user.email}</i>
                                                        </span>
                                                        <span class="be-comment-time">
                                                            <i class="fa fa-clock-o" style="color:black;">${cmt.contentDate}</i>
                                                            <a href="${pageContext.request.contextPath}/user/deleteCmt/${cmt.id}"><i class="lnr lnr-trash"></i></a>
                                                            <a href="${pageContext.request.contextPath}/user/updateCmt/${cmt.id}"><i class="lnr lnr-pencil"></i></a>
                                                        </span>

                                                        <p class="be-comment-text">
                                                            ${cmt.content}
                                                        </p>
                                                    </div></c:forEach>
                                                </div>
                                                <br><br><br><br>
                                            <sec:authorize access="isAuthenticated()">

                                                <form class="form-block" action="${pageContext.request.contextPath}/user/comment/${productDetail.id}" method="POST" modelAttribute="cmt">
                                                    <div class="row">

                                                        <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">									
                                                            <div class="form-group">
                                                                <textarea style="color:black;" class="form-input" required="" name="content" placeholder="Your text"></textarea>
                                                            </div>
                                                        </div>
                                                        <input type="submit" value="Submit" class="button cart_button" />
                                                    </div>
                                                </form>
                                            </sec:authorize>
                                        </div>
                                    </div>
                                </div>

                            </c:if>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Products -->


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
                                <div class="newsletter_text"><p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam a ultricies metus. Sed nec molestie eros</p></div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </div>
        <jsp:include page="include/js-page.jsp" />
        <script src="<c:url value="/resources/js/product.js"/>"></script>
    </body>
</html>
