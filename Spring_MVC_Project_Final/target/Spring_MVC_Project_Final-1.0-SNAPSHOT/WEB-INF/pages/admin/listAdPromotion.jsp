<%-- 
    Document   : table
    Created on : Dec 6, 2020, 5:53:08 PM
    Author     : BTD
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Matrix Admin</title>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="<c:url value="/resources-management/css/bootstrap.min.css"/>" />
        <link rel="stylesheet" href="<c:url value="/resources-management/css/bootstrap-responsive.min.css"/>" />
        <link rel="stylesheet" href="<c:url value="/resources-management/css/uniform.css"/>" />
        <link rel="stylesheet" href="<c:url value="/resources-management/css/select2.css"/>" />
        <link rel="stylesheet" href="<c:url value="/resources-management/css/matrix-style.css"/>" />
        <link rel="stylesheet" href="<c:url value="/resources-management/css/matrix-media.css"/>" />
        <link href="<c:url value="/resources-management/font-awesome/css/font-awesome.css"/>" rel="stylesheet"/>
        <link href='<c:url value="http://fonts.googleapis.com/css?family=Open+Sans:400,700,800"/>" rel='stylesheet' type='text/css'/>
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
        <!--start-top-serch-->
        <jsp:include page="include-management/header-top-search.jsp"/>
        <!--close-top-serch--> 

        <!--sidebar-menu-->
        <jsp:include page="include-management/menu-admin.jsp"/>
        <div id="content">
            <div id="content-header">
                <div id="breadcrumb"> <a href="#" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="current">Promotion</a> </div>
                <h1>List Promotion</h1>
            </div>
            <div class="container-fluid">
                <hr>
                <div class="row-fluid">
                    <div class="span12">
                        <div class="widget-box">
                            <div class="widget-title"> <span class="icon"><i class="icon-th"></i></span>
                                <h5>Promotion list table</h5>
                                <div class="col-xs-6 col-sm-6 col-md-6 col-lg-6">
                                    <button class="btn btn-info"
                                            onclick="location.href = '<c:url value="/admin/add-promotion"/>'">Add Promotion</button>
                                </div>
                            </div>
                            <c:if test="${message != null && message!= ''}">
                                <div class="row">
                                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12"
                                         style="padding-top: 10px">
                                        <c:if test="${type != null && type!= '' && type == 'error'}">
                                            <div class="alert alert-danger">${message}</div>
                                        </c:if>
                                        <c:if test="${type != null && type!= '' && type == 'success'}">
                                            <div class="alert alert-success">${message}</div>
                                        </c:if>
                                    </div>
                                </div>
                            </c:if>
                            <div class="widget-content nopadding">
                                <table class="table table-bordered data-table">
                                    <thead>
                                        <tr>
                                            <th>Name Promotion</th>
                                            <th>Code</th>
                                            <th>Category</th>
                                            <th>Discount</th>
                                            <th>Start Date</th>
                                            <th>End Date</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:if test="${promotions != null && fn:length(promotions)>0}">
                                            <c:forEach items="${promotions}" var="p">
                                                <tr>
                                                    <td>${p.name}</td>
                                                    <td>${p.code}</td>
                                                    <td>
                                                        <c:forEach var="c" items="${p.categories}">
                                                            ${c.name}<br>
                                                        </c:forEach>
                                                    </td>
                                                    <td> 
                                                        <fmt:formatNumber 
                                                                value="${p.discount*100}" 
                                                                pattern="###,##" type="number"/>%
                                                    <td>
                                                        <fmt:formatDate value="${p.startDate}"
                                                                        pattern="dd/MM/yyyy" type="date"/>
                                                    </td>
                                                    <td>
                                                        <fmt:formatDate value="${p.endDate}"
                                                                        pattern="dd/MM/yyyy" type="date"/>
                                                    </td>                                                 

                                                    <td>
                                                        ${p.status}
                                                    </td>
                                            <td>
                                                <button class="btn btn-default"
                                                        onclick="location.href = '<c:url value="/admin/update-promotion/${p.id}"/>'">Update</button>
                                            </td>
                                            </tr>
                                        </c:forEach>
                                    </c:if>
                                    <c:if test="${promotions == null || fn:length(promotions)<=0}">
                                        <tr>
                                            <td colspan="8" style="color: red">
                                                Empty List!!!
                                            </td>
                                        </tr>
                                    </c:if>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Footer-part-->
        <div class="row-fluid">
            <div id="footer" class="span12"> 2013 &copy; Matrix Admin.  </div>
        </div>
        <!--end-Footer-part-->
        <script src="<c:url value="/resources-management/js/jquery.min.js"/>"></script> 
        <script src="<c:url value="/resources-management/js/jquery.ui.custom.js"/>"></script> 
        <script src="<c:url value="/resources-management/js/bootstrap.min.js"/>"></script> 
        <script src="<c:url value="/resources-management/js/jquery.uniform.js"/>"></script> 
        <script src="<c:url value="/resources-management/js/select2.min.js"/>"></script> 
        <script src="<c:url value="/resources-management/js/jquery.dataTables.min.js"/>"></script> 
        <script src="<c:url value="/resources-management/js/matrix.js"/>"></script> 
        <script src="<c:url value="/resources-management/js/matrix.tables.js"/>"></script>
    </body>
</html>

