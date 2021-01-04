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
                <div id="breadcrumb"> <a href="index.html" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="tip-bottom">Order Management</a> <a href="#" class="current">Change Order Status</a> </div>
                <div class="row">
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12"
                         style="text-align: center">
                        <c:if test="${action == 'updateorderstatus'}">
                            <h3>Update Order Status</h3>
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
                                <h5>order-status-info-${order.orderUId}</h5>
                            </div>
                            <div class="widget-content nopadding">
                                <mvc:form class="form-horizontal" method="POST" 
                                          action="${pageContext.request.contextPath}/admin/${action}/${order.id}" 
                                          name="password_validate" id="password_validate" novalidate="novalidate">
                                    <div class="control-group">
                                        <div hidden class="controls">
                                            <c:if test="${action == 'changepassword'}">
                                                <input value="${order.id}" name="id" hidden >
                                            </c:if>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label"for="status">Status :</label>
                                        <div class="controls">
                                            <c:forEach items="${status}" var="s">
                                                <c:if test="${s == order.status}">
                                                    <label>

                                                        <input type="radio" name="status" 
                                                               value="${s}" checked/>${s} 

                                                    </label>
                                                </c:if>
                                                <c:if test="${s != order.status}">
                                                    <c:if test="${CANCEL != s}">
                                                        <label>
                                                            <input type="radio" name="status" 
                                                                   value="${s}"/>${s}
                                                        </label>
                                                    </c:if>
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                    </div>   
                                    <div class="control-group">
                                        <div  class="controls">


                                        </div>
                                    </div>
                                    <div class="form-actions" style="text-align: center">
                                        <c:if test="${action == 'updateorderstatus'}">
                                            <button class="btn btn-warning" type="submit">Update Status</button>
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
