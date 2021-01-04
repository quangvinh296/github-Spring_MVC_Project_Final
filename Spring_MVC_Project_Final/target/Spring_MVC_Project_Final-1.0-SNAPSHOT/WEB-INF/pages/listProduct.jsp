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

        <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css">

        <script src="<c:url value="/resources/paging/jquery.twbsPagination.js"/>"></script>

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
                                    <c:if test="${message == 'ByProduct'}">
                                        <div class="home_content">
                                            <div class="home_title" style="color:grey;">Smart Phones<span>.</span></div>
                                        </div>
                                    </c:if>
                                    <c:if test="${message == 'byCategory'}">
                                        <div class="home_title" style="color:grey;">${category}<span>.</span></div>
                                    </c:if>
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

                            <!-- Product Sorting -->
                            <div class="sorting_bar d-flex flex-md-row flex-column align-items-md-center justify-content-md-start">

                                <c:if test="${numberPages != 1}">
                                    <c:if test="${(page + 1) < numberPages}">
                                        <i><td colspan="2">Showing ${page*size + 1} - ${page*size + products.size()} of ${n} results</td></i>
                                    </c:if>
                                    <c:if test="${(page + 1) >= numberPages}">
                                        <i><td colspan="2">Showing ${page*size + 1}-${n} of ${n} results</td></i>  
                                    </c:if> 
                                </c:if>
                                <div class="sorting_container ml-md-auto">
                                    <div class="sorting">
                                        <ul class="item_sorting">
                                            <li>
                                                <span class="sorting_text">Sort by</span>
                                                <i class="fa fa-chevron-down" aria-hidden="true"></i>
                                                <c:if test="${message == 'ByProduct'}">

                                                    <ul>
                                                        <li class="product_sorting_btn" data-isotope-option='{ "sortBy": "original-order" }'><a href="${pageContext.request.contextPath}/ListProduct/selling">Selling</a></li>
                                                        <li class="product_sorting_btn" data-isotope-option='{ "sortBy": "price" }'><a href="${pageContext.request.contextPath}/ListProduct/price">Price</a></li>
                                                        <li class="product_sorting_btn" data-isotope-option='{ "sortBy": "stars" }'><a href="${pageContext.request.contextPath}/ListProduct/new">New</a></li>
                                                    </ul>
                                                </c:if>
                                                <c:if test="${message == 'byCategory'}">
                                                    <ul>
                                                        <li class="product_sorting_btn" data-isotope-option='{ "sortBy": "original-order" }'><a href="${pageContext.request.contextPath}/cate/${category}/selling">Selling</a></li>
                                                        <li class="product_sorting_btn" data-isotope-option='{ "sortBy": "price" }'><a href="${pageContext.request.contextPath}/cate/${category}/price">Price</a></li>
                                                        <li class="product_sorting_btn" data-isotope-option='{ "sortBy": "stars" }'><a href="${pageContext.request.contextPath}/cate/${category}/new">New</a></li>
                                                    </ul>
                                                </c:if>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col">
                            <div class="product_grid">
                                <!-- Product -->

                                <c:forEach items="${products}" var="p">
                                    <c:if test="${p.quantityProduct > 0}">
                                        <div class="product">

                                            <c:forEach items="${images}" var="image" >
                                                <c:if test="${p.id == image.product.id}">
                                                    <div class="product_image"  style="height:300px;width:260px;"><a href="${pageContext.request.contextPath}/productDetail/${p.id}"><img style="height:240px; width:230px;"src="<c:url value="/resources/img/category/${image.name}"/>" alt=""></a></div>

                                                </c:if>
                                            </c:forEach>

                                            <div class="product_content">

                                                <div class="product_title" style="text-align:center;"><a href="${pageContext.request.contextPath}/productDetail/${p.id}">${p.name}</a></div>
                                                <div class="product_price" style="text-align:center;">
                                                    
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
                                        </div>
                                    </c:if>
                                    <c:if test="${p.quantityProduct == 0}">
                                        <div class="product">
                                            <c:forEach items="${images}" var="image" >
                                                <c:if test="${p.id == image.product.id}">
                                                    <div class="product_image"><a href="${pageContext.request.contextPath}/productDetail/${p.id}"><img src="<c:url value="/resources/img/category/${image.name}"/>" alt=""></a></div>

                                                </c:if>
                                            </c:forEach>
                                            <div class="product_extra product_new" style="transform: rotate(0deg);margin-left:-54px;"><a href="#" >Sold out</a></div>
                                            <div class="product_content">

                                                <div class="product_title" style="text-align:center;"><a href="${pageContext.request.contextPath}/productDetail/${p.id}">${p.name}</a></div>
                                                <div class="product_price" style="text-align:center;">
                                                    <fmt:formatNumber value="${p.price}" pattern="###,###" type="number"/> VND

                                                </div>
                                            </div>
                                        </div>
                                    </c:if>
                                </c:forEach >

                            </div>
                        </div>

                    </div>
                </div>
            </div>
            <c:if test="${by == null && message != 'byCategory'}" >
                <div class="container" style="text-align: center;">
                    <tr>
                        <td colspan="3" style="text-align: center;">
                            <c:if test="${page <= 1}">
                                <button id="btnPN" class="btn btn-default" onclick="location.href = '<c:url value="/listProduct/page?page=${0}&start=${0}"/>'">
                                    Previous
                                </button>
                            </c:if>
                            <c:if test="${page > 1}">
                                <button id="btnPN" class="btn btn-default" onclick="location.href = '<c:url value="/listProduct/page?page=${page - 1}&start=${start-1}"/>'">
                                    Previous
                                </button>
                            </c:if>
                            <c:forEach var = "i" begin = "${start}" end = "${start + 1}">
                                <c:if test="${i < numberPages}">
                                    <c:if test="${page == i}">
                                        <button id="btnN" style="color: red" class="btn btn-danger" onclick="location.href = '<c:url value="/listProduct/page?page=${i}&start=${start}"/>'">
                                            ${i + 1}
                                        </button>
                                    </c:if>
                                    <c:if test="${page != i}">
                                        <button id="btnN" class="btn btn-default" onclick="location.href = '<c:url value="/listProduct/page?page=${i}&start=${start}"/>'">
                                            ${i + 1}
                                        </button>
                                    </c:if>
                                </c:if>
                            </c:forEach>
                            <c:if test="${page < numberPages - 1}">
                                <button id="btnPN" class="btn btn-default" onclick="location.href = '<c:url value="/listProduct/page?page=${page + 1}&start=${start + 1}"/>'">
                                    Next
                                </button>
                            </c:if>
                            <c:if test="${page == numberPages - 1}">
                                <button id="btnPN" class="btn btn-default" onclick="location.href = '<c:url value="/listProduct/page?page=${page}&start=${start}"/>'">
                                    Next
                                </button>
                            </c:if>
                        </td>
                    </tr>
                    </td>


                </div>
            </c:if>
            <c:if test="${by != null && message != 'byCategory'}" >
                <div class="container" style="text-align: center;">
                    <tr>
                        <td colspan="3" style="text-align: center;">
                            <c:if test="${page <= 1}">
                                <button id="btnPN" class="btn btn-default" onclick="location.href = '<c:url value="/ListProduct/page/${by}?page=${0}&start=${0}"/>'">
                                    Previous
                                </button>
                            </c:if>
                            <c:if test="${page > 1}">
                                <button id="btnPN" class="btn btn-default" onclick="location.href = '<c:url value="/ListProduct/page/${by}?page=${page - 1}&start=${start-1}"/>'">
                                    Previous
                                </button>
                            </c:if>
                            <c:forEach var = "i" begin = "${start}" end = "${start + 1}">
                                <c:if test="${i < numberPages}">
                                    <c:if test="${page == i}">
                                        <button id="btnN" style="color: red" class="btn btn-danger" onclick="location.href = '<c:url value="/ListProduct/page/${by}?page=${i}&start=${start}"/>'">
                                            ${i + 1}
                                        </button>
                                    </c:if>
                                    <c:if test="${page != i}">
                                        <button id="btnN" class="btn btn-default" onclick="location.href = '<c:url value="/ListProduct/page/${by}?page=${i}&start=${start}"/>'">
                                            ${i + 1}
                                        </button>
                                    </c:if>
                                </c:if>
                            </c:forEach>
                            <c:if test="${page < numberPages - 1}">
                                <button id="btnPN" class="btn btn-default" onclick="location.href = '<c:url value="/ListProduct/page/${by}?page=${page + 1}&start=${start + 1}"/>'">
                                    Next
                                </button>
                            </c:if>
                            <c:if test="${page == numberPages - 1}">
                                <button id="btnPN" class="btn btn-default" onclick="location.href = '<c:url value="/ListProduct/page/${by}?page=${page}&start=${start}"/>'">
                                    Next
                                </button>
                            </c:if>
                        </td>
                    </tr>
                    </td>


                </div>
            </c:if>
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
