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
                <div id="breadcrumb"> <a href="<c:url value="/admin/home"/>" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="<c:url value="/admin/listAdAccount"/>" class="tip-bottom">Account Management</a> <a href="<c:url value="/admin/add-account"/>" class="current">Create Account</a> </div>
                <div class="row">
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12"
                         style="text-align: center">
                        <c:if test="${action == 'addaccount'}">
                            <h3>Create Account</h3>
                        </c:if>
                        <c:if test="${action == 'updateaccount'}">
                            <h3>Update Account Info</h3>
                        </c:if>
                        <c:if test="${message == 'updatepass'}">
                            <h3>Update Account Password</h3>
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
                                <h5>Account-info</h5>
                            </div>
                            <div class="widget-content nopadding">
                                <mvc:form action="${pageContext.request.contextPath}/admin/${action}"
                                          method="POST" class="form-horizontal" modelAttribute="product" enctype="multipart/form-data">


                                    <div class="control-group">
                                        <div hidden class="controls">
                                            <c:if test="${action == 'updateaccount'}">
                                                <input value="${account.id}" name="id" hidden >
                                            </c:if>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <div hidden class="controls">
                                            <c:if test="${action == 'updateaccount'}">
                                                <input value="${account.password}" name="password" hidden >
                                            </c:if>
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label"for="status">Status :</label>
                                        <div class="controls">
                                            <c:forEach items="${status}" var="s">
                                                <c:if test="${s == account.status}">
                                                    <label>

                                                        <input type="radio" name="status" 
                                                               value="${s}" checked/>${s} 

                                                    </label>
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                    </div> 
                                    <div class="control-group">
                                        <label class="control-label" for="fullName">Full Name :</label>
                                        <div class="controls">
                                            <input required type="text" class="span11" placeholder="Full Name" id="fullName"
                                                   name="fullName" value="${account.fullName}">
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label" for="phone">Phone :</label>
                                        <div class="controls">
                                            <input required pattern="[-+]?[0-9]" type="number" class="span11 mask " placeholder="(999) 999-9999" id="phone"
                                                   name="phone" value="${account.phone}">
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label required class="control-label" for="email">Email :</label>
                                        <div class="controls">
                                            <input type="text" class="span11" placeholder="abc@gmail.com" id="email"
                                                   name="email" value="${account.email}"
                                                   title="The domain portion of the email address is invalid (the portion after the @)." 
                                                   pattern="^([^\x00-\x20\x22\x28\x29\x2c\x2e\x3a-\x3c\x3e\x40\x5b-\x5d\x7f-\xff]+|\x22([^\x0d\x22\x5c\x80-\xff]|\x5c[\x00-\x7f])*\x22)(\x2e([^\x00-\x20\x22\x28\x29\x2c\x2e\x3a-\x3c\x3e\x40\x5b-\x5d\x7f-\xff]+|\x22([^\x0d\x22\x5c\x80-\xff]|\x5c[\x00-\x7f])*\x22))*\x40([^\x00-\x20\x22\x28\x29\x2c\x2e\x3a-\x3c\x3e\x40\x5b-\x5d\x7f-\xff]+|\x5b([^\x0d\x5b-\x5d\x80-\xff]|\x5c[\x00-\x7f])*\x5d)(\x2e([^\x00-\x20\x22\x28\x29\x2c\x2e\x3a-\x3c\x3e\x40\x5b-\x5d\x7f-\xff]+|\x5b([^\x0d\x5b-\x5d\x80-\xff]|\x5c[\x00-\x7f])*\x5d))*(\.\w{2,})+$">
                                        </div>
                                    </div>

                                    <div class="control-group">
                                        <label class="control-label" for="address">Address :</label>
                                        <div class="controls">
                                            <input type="text" class="span11" placeholder="" id="address"
                                                   name="address" value="${account.address}">
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label">Birth Date :</label>
                                        <div class="controls">
                                            <input required type="Date" id="birthDate"
                                                   name="birthDate"
                                                   value="${account.birthDate}" class="common-input span11">
                                        </div>
                                    </div>
                                    <div class="control-group">
                                        <label class="control-label"for="gender">Gender :</label>
                                        <div class="controls">
                                            <c:forEach items="${genders}" var="g">
                                                <c:if test="${g == account.gender}">
                                                    <label>
                                                        <input type="radio" name="gender" 
                                                               value="${g}" checked/>${g} 

                                                    </label>
                                                </c:if>
                                                <c:if test="${g != account.gender}">
                                                    <label>
                                                        <input type="radio" name="gender" 
                                                               value="${g}"/>${g}
                                                    </label>
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                    </div>  
                                    <div class="control-group">
                                        <label class="control-label" for="roles">Role :</label>
                                        <c:if test="${action == 'addaccount'}">
                                            <div class="controls">
                                                <select required multiple="true" name="userRoles.id" class="form-control">
                                                    <c:forEach items="${userroles}" var="r">
                                                        <option value="${r.id}">${r.role}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </c:if>
                                        <c:if test="${action == 'updateaccount'}">
                                            <div class="controls">

                                                <select multiple="true" name="userRoles.id" class="form-control">
                                                    <c:forEach items="${userroles}" var="r">
                                                        <% String select = "";%>
                                                        <c:forEach items="${r.getUsers()}" var="u">
                                                            <c:if test="${u.id == account.id}">
                                                                <% select = "selected";%>
                                                            </c:if>
                                                        </c:forEach> 
                                                        <option value="${r.id}" <%=select%> >${r.role}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </c:if>
                                    </div>    


                                    <div class="form-actions" style="text-align: center">
                                        <c:if test="${action == 'addaccount'}">
                                            <button class="btn btn-success" type="submit">Create Account</button>
                                        </c:if>
                                        <c:if test="${action == 'updateaccount'}">
                                            <button class="btn btn-warning" type="submit">Update Account</button>
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
