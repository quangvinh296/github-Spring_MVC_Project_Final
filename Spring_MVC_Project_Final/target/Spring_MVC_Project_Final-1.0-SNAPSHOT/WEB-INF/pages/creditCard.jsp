<%-- 
    Document   : creditCard
    Created on : Nov 26, 2020, 8:54:15 AM
    Author     : my
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <link rel="stylesheet" type="text/css" href="<c:url value="/resources/2/bootstrap/css/bootstrap.min.css"/>"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/resources/2/font-awesome/css/font-awesome.min.css" />"/>

        <script type="text/javascript" src="<c:url value="/resources/2/js/jquery-1.10.2.min.js"/>"></script>
        <script type="text/javascript" src="<c:url value="/resources/2/bootstrap/js/bootstrap.min.js"/>"></script>
        <jsp:include page="include/css-header.jsp" />
    </head>
    <body>
        <div class="super_container">
            <jsp:include page="include/menu1.jsp" />
            <div class="container">

                <div class="page-header">
                    <h1>Credit Card Payment Form <small>A responsive credit card payment template</small></h1>
                </div>

                <!-- Credit Card Payment Form - START -->

                <div class="container">
                    <div class="row">
                        <div class="col-xs-12 col-md-4 col-md-offset-4">
                            <form id="cardForm" class="form-row" action="${pageContext.request.contextPath}/payment" method="POST" modelAttribute="card">
                               
                                <input type="hidden" path="totalBill" id="totalBill" name="totalBill" value="${sessionScope.myCartTotal}">
                                <div class="panel panel-default">
                                    <div class="panel-heading">
                                        <div class="row">
                                            <h3 class="text-center">Payment Details</h3>
                                            <img class="img-responsive cc-img" src="http://www.prepbootstrap.com/Content/images/shared/misc/creditcardicons.png">
                                        </div>
                                    </div>
                                    <div class="panel-body">
                                        <div class="row">
                                            <div class="col-xs-12">
                                                <div class="form-group">
                                                    ${error}
                                                    <label>CARD NUMBER</label>
                                                    <div class="input-group">
                                                        <input type="text" path="cardNumber" name="cardNumber" pattern="^[0-9]*$" required="true" class="form-control" placeholder="Valid Card Number" />
                                                        <span class="input-group-addon" style="width: 30px;"><span class="fa fa-credit-card"></span></span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-5 col-md-5">
                                                <label><span class="hidden-xs">EXPIRATION</span><span class="visible-xs-inline">EXP</span> DATE</label>
                                                <div class="form-group">
                                                    <input type="text" path="expiry" name="expiry" required="required" maxlength="7" pattern="[0-9]{1,2}/[0-9]{4}" class="form-control" placeholder="MM/YYYY" />
 
                                                </div>
                                            </div>
                                            
                                            <div class="col-xs-4 col-md-4 pull-right">
                                                <div class="form-group">
                                                    <label>CV CODE</label>
                                                    <input type="text" path="cvvcode" name="cvvcode" required="true" pattern="^[0-9]*$" class="form-control" placeholder="CVC" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-12">
                                                <div class="form-group">
                                                    <label>CARD OWNER</label>
                                                    <input type="text"  path="ownerName" name="ownerName" required="true" pattern="^[A-Z '\s]*$" class="form-control" placeholder="Card Owner Names" />
                                                </div>
                                            </div>
                                        </div>

                                    </div>
                                    <div class="panel-footer">
                                        <div class="row">
                                            <div class="col-xs-12">
                                                <input type="hidden" name="grandTotal" value="${grandTotal}">
                                                <button class="btn btn-warning btn-lg btn-block">Process payment</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <style>
                    .cc-img {
                        margin: 0 auto;
                    }
                </style>
                <!-- Credit Card Payment Form - END -->

            </div>
        </div>
    </body>
</html>
