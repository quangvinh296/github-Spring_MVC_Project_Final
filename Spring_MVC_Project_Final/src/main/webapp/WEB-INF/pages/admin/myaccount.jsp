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
                <div id="breadcrumb"> <a href="index.html" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="tip-bottom">Account Management</a> <a href="#" class="current">Account info</a> </div>
                <div class="row">
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12"
                         style="text-align: center">

                        <h3>User Infomation</h3>

                    </div>
                </div>
            </div>
            <div class="container-fluid">
                <hr>
                <div class="row-fluid">
                    <div class="span6">
                        <div class="widget-box">
                            <div class="widget-title" > <span class="icon"> <i class="icon-align-justify"></i> </span>
                                <h5>${user.email}-user-detail-info</h5>
                                &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                                &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
                                <button class="btn btn-info"
                                        onclick="location.href = '<c:url value="/admin/home"/>'">Back to home</button>
                            </div>
                            <div class="widget-content nopadding">
                                <table class="table table-bordered data-table">
                                    <tr>
                                        <th>Full Name</th>
                                        <th>Email</th>
                                        <th>Gender</th>
                                        <th>Birth date</th>
                                        <th>Phone</th>
                                        <th>Status</th>
                                        <th>Action</th>                                     
                                    </tr>

                                    <tr>
                                        <td>${user.fullName}</td>
                                        <td>${user.email}</td>
                                        <td>${user.gender}</td>
                                        <td>
                                            <fmt:formatDate value="${user.birthDate}"
                                                            pattern="dd/MM/yyyy" type="date"/>
                                        </td>
                                        <td>${user.phone}</td>
                                        <td>${user.status}</td>
                                        <td>
                                            <button class="btn btn-primary"
                                                    onclick="location.href = '<c:url value="/admin/update-account/${user.id}"/>'">Update Info</button>
                                            <button class="btn btn-inverse"
                                                    onclick="location.href = '<c:url value="/admin/change-password/${user.id}"/>'">Change Password</button>      
                                        </td>
                                    </tr>


                                </table>


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
