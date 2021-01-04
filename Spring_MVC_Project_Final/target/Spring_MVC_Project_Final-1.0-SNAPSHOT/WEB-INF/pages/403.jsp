<%-- 
    Document   : 403
    Created on : Nov 23, 2020, 10:57:15 AM
    Author     : my
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        
        <jsp:include page="include/css-header.jsp" />
        <link rel="stylesheet" href="<c:url value="resources/1/css/main.css"/>"/>
    </head>
    <body>
        
        <jsp:include page="include/menu1.jsp" />
        <div class="super_container">
            
            <!-- Start Banner Area -->
            <section class="banner-area organic-breadcrumb">
                <div class="container">
                    <div class="breadcrumb-banner d-flex flex-wrap align-items-center">
                        <div class="col-first">
                            
                            <nav class="d-flex align-items-center justify-content-start">
                                <a href="${pageContext.request.contextPath}/home">Home<i class="fa fa-caret-right" aria-hidden="true"></i></a>
                                
                            </nav>
                        </div>
                    </div>
                </div>
            </section>
             <div class="container">
                 <h1 class="text-center">Access Denied!</h1>
                <p class="text-center">Sorry, you can not access this page!</p>
             </div>
                                
       </div>
       
         <jsp:include page="include/js-page.jsp" />
    </body>
</html>
