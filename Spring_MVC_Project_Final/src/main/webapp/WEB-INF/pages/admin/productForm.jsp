<%-- 
    Document   : Form
    Created on : Dec 7, 2020, 1:35:39 AM
    Author     : BTD
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="mvc" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Matrix Admin</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="<c:url value="/resources-management/css/bootstrap.min.css"/>" />
        <link rel="stylesheet" href="<c:url value="/resources-management/css/bootstrap-responsive.min.css"/>" />
        <link rel="stylesheet" href="<c:url value="/resources-management/css/colorpicker.css"/>" />
        <link rel="stylesheet" href="<c:url value="/resources-management/css/datepicker.css"/>" />
        <link rel="stylesheet" href="<c:url value="/resources-management/css/uniform.css"/>" />
        <link rel="stylesheet" href="<c:url value="/resources-management/css/select2.css"/>" />
        <link rel="stylesheet" href="<c:url value="/resources-management/css/matrix-style.css"/>" />
        <link rel="stylesheet" href="<c:url value="/resources-management/css/matrix-media.css"/>" />
        <link rel="stylesheet" href="<c:url value="/resources-management/css/bootstrap-wysihtml5.css"/>" />
        <link href="<c:url value="/resources-management/font-awesome/css/font-awesome.css"/>" rel="stylesheet" />
        <link href="<c:url value="http://fonts.googleapis.com/css?family=Open+Sans:400,700,800"/>" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <!--Header-part-->
        <div id="header">
            <h1><a href="dashboard.html">Matrix Admin</a></h1>
        </div>
        <!--close-Header-part--> 
        <!--top-Header-menu-->
        <jsp:include page="include-management/header-body-admin.jsp"/>
        <!--close-top-Header-menu-->
        <!--start-top-search-->
        <jsp:include page="include-management/header-top-search.jsp"/>
        <!--close-top-search-->
        <!--sidebar-menu-->
        <jsp:include page="include-management/menu-admin.jsp"/>
        <!--sidebar-menu-->

        <div id="content">
            <div id="content-header">
                <div id="breadcrumb"> <a href="index.html" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="tip-bottom">Product Management</a> <a href="#" class="current">Create Product</a> </div>
                <div class="row">
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12"
                         style="text-align: center">
                        <c:if test="${action == 'addproduct'}">
                            <h3>Create Product</h3>
                        </c:if>
                        <c:if test="${action == 'updateproduct'}">
                            <h3>Update Product</h3>
                        </c:if>
                    </div>
                </div>
            </div>
            <div class="container-fluid">
                <hr>
                <div class="row-fluid">
                    <div class="span6">
                        <div class="widget-box">
                            <div class="widget-title" > <span class="icon"> <i class="icon-align-justify"></i> </span>
                                <h5>Product-info</h5>
                            </div>
                            <div class="widget-content nopadding">
                                <mvc:form action="${pageContext.request.contextPath}/admin/${action}"
                                          method="POST" class="form-horizontal" modelAttribute="product" enctype="multipart/form-data">
                                    <div class="control-group">
                                        <div hidden class="controls">
                                            <c:if test="${action == 'updateproduct'}">
                                                <input value="${product.id}" name="id" hidden >
                                            </c:if>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label" for="name">Name product :</label>
                                        <div class="controls">
                                            <input required type="text" class="span11" placeholder="Iphone 12" id="name"
                                                   name="name" value="${product.name}">
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label" for="description">Description product :</label>
                                        <div class="controls">
                                            <textarea class="span11" id="description"
                                                      name="description" type="text">${product.description}</textarea>
                                        </div>
                                    </div>   
                                    <div class="control-group">
                                        <label class="control-label" for="category">Category product :</label>
                                        <div class="controls">
                                            <select required name="category.id" class="form-control">
                                                <c:forEach items="${categories}" var="c">
                                                    <c:if test="${c.id == product.category.id}">
                                                        <option value="${c.id}" selected>${c.name}</option>
                                                    </c:if>
                                                    <c:if test="${c.id != product.category.id}">
                                                        <option value="${c.id}">${c.name}</option>
                                                    </c:if>
                                                </c:forEach>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label" for="quantityProduct">Quantity Product:</label>
                                        <div class="controls">
                                            <input required pattern="[-+]?[0-9]" type="number" class="span11" id="quantityProduct"
                                                   name="quantityProduct" value="${product.quantityProduct}">
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label" for="price">Price :</label>
                                        <div class="controls">
                                            <div class="input-append">
                                                <input required pattern="[-+]?[0-9]" type="number" placeholder="5000" class="span11" id="price"
                                                       name="price" value="${product.price}">
                                                <span class="add-on">VNĐ</span> 
                                            </div>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label" for="operatingSystem">System :</label>
                                        <div class="controls">
                                            <input type="text" class="span11" placeholder="iOS" id="operatingSystem"
                                                   name="operatingSystem" value="${product.operatingSystem}">
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label" for="rearCamera">Rear Camera :</label>
                                        <div class="controls">
                                            <input type="text" class="span11" id="rearCamera"
                                                   name="rearCamera" value="${product.rearCamera}">
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label" for="frontCamera">Front Camera :</label>
                                        <div class="controls">
                                            <input type="text" class="span11" id="frontCamera"
                                                   name="frontCamera" value="${product.frontCamera}">
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label" for="memoryCard">Memory Card :</label>
                                        <div class="controls">
                                            <input type="text" class="span11" id="memoryCard"
                                                   name="memoryCard" value="${product.memoryCard}">
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label" for="ram">Ram :</label>
                                        <div class="controls">
                                            <input type="text" class="span11" id="ram"
                                                   name="ram" value="${product.ram}">
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label" for="battery">Battery :</label>
                                        <div class="controls">
                                            <input type="text" class="span11" id="battery"
                                                   name="battery" value="${product.battery}">
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label" for="screen">Screen :</label>
                                        <div class="controls">
                                            <input type="text" class="span11" id="screen"
                                                   name="screen" value="${product.screen}">
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label">Date update :</label>
                                        <div class="controls">
                                            <input required type="Date" id="updateDate" name="updateDate" 
                                                   value="${product.updateDate}"
                                                   required class="common-input span11">
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label"for="status">Status :</label>
                                        <div class="controls">
                                            <c:forEach items="${status}" var="s">
                                                <c:if test="${s == product.status}">
                                                    <label>
                                                        <input type="radio" name="status" 
                                                               value="${s}" checked/>${s} 

                                                    </label>
                                                </c:if>
                                                <c:if test="${s != product.status}">
                                                    <label>
                                                        <input required type="radio" name="status" 
                                                               value="${s}"/>${s}
                                                    </label>
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                    </div>   
                                    <div class="control-group">
                                        <label class="control-label">File upload input :</label>

                                        <div class="controls">
                                            <input type="file" size="19" style="opacity: 0;" class="form-control" id="file"
                                                   name="file" value="image" >
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <div class="controls">

                                        </div>
                                    </div>
                                    <div class="form-actions" style="text-align: center">
                                        <c:if test="${action == 'addproduct'}">
                                            <button class="btn btn-success" type="submit">Create Product</button>
                                        </c:if>
                                        <c:if test="${action == 'updateproduct'}">
                                            <button class="btn btn-warning" type="submit">Update Product</button>
                                        </c:if>
                                    </div>
                                </mvc:form>
                            </div>
                        </div>
                    </div>
                </div>
                <!--Footer-part-->

                <div class="row-fluid">
                    <div id="footer" class="span12"> 2020 &copy; Matrix Admin. </div>
                </div>

                <!--end-Footer-part-->

                <!--Footer-js-->
                <script src="<c:url value="/resources-management/js/jquery.min.js"/>"></script> 
                <script src="<c:url value="/resources-management/js/jquery.ui.custom.js"/>"></script> 
                <script src="<c:url value="/resources-management/js/bootstrap.min.js"/>"></script> 
                <script src="<c:url value="/resources-management/js/bootstrap-colorpicker.js"/>"></script> 
                <script src="<c:url value="/resources-management/js/bootstrap-datepicker.js"/>"></script> 
                <script src="<c:url value="/resources-management/js/jquery.toggle.buttons.js"/>"></script> 
                <script src="<c:url value="/resources-management/js/masked.js"/>"></script> 
                <script src="<c:url value="/resources-management/js/jquery.uniform.js"/>"></script> 
                <script src="<c:url value="/resources-management/js/select2.min.js"/>"></script> 
                <script src="<c:url value="/resources-management/js/matrix.js"/>"></script> 
                <script src="<c:url value="/resources-management/js/matrix.form_common.js"/>"></script> 
                <script src="<c:url value="/resources-management/js/wysihtml5-0.3.0.js"/>"></script> 
                <script src="<c:url value="/resources-management/js/jquery.peity.min.js"/>"></script> 
                <script src="<c:url value="/resources-management/js/bootstrap-wysihtml5.js"/>"></script> 
                <script>
                    $('.textarea_editor').wysihtml5();
                </script>
                <!--end-Footer-js-->
                </body>
                </html>
