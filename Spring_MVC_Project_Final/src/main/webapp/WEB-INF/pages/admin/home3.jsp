<%-- 
    Document   : home3
    Created on : Nov 23, 2020, 5:21:59 PM
    Author     : BTD
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Sublime Admin</title>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <link rel="stylesheet" href="<c:url value="/resources-management/css/bootstrap.min.css"/>" />
        <link rel="stylesheet" href="<c:url value="/resources-management/css/bootstrap-responsive.min.css"/>" />
        <link rel="stylesheet" href="<c:url value="/resources-management/css/fullcalendar.css"/>" />
        <link rel="stylesheet" href="<c:url value="/resources-management/css/matrix-style.css"/>" />
        <link rel="stylesheet" href="<c:url value="/resources-management/css/matrix-media.css"/>" />
        <link href="<c:url value="/resources-management/font-awesome/css/font-awesome.css"/>" rel="stylesheet" />
        <link href="<c:url value="http://fonts.googleapis.com/css?family=Open+Sans:400,700,800"/>" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <!--Header-part-->
        <div id="header">
            <h1><a href="<c:url value="/admin/home"/>">Sublime Admin</a></h1>
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
        <!--sidebar-menu-->

        <!--main-container-part-->
        <div id="content">
            <!--breadcrumbs-->
            <div id="content-header">
                <div id="breadcrumb"> <a href="<c:url value="/admin/home"/>" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a></div>
            </div>
            <!--End-breadcrumbs-->
            <!--Action boxes-->
            <div class="container-fluid">
                <div class="quick-actions_homepage">
                    <ul class="quick-actions">
                        <li class="bg_lb"> <a href="<c:url value="/admin/home"/>"> <i class="icon-dashboard"></i> My Dashboard </a> </li>
                        <li class="bg_lg"> <a href="<c:url value="/admin/listAdAccount"/>"> <i class="icon-calendar"></i> Account Management</a> </li>
                        <li class="bg_ly"> <a href="<c:url value="/admin/listAdCategory"/>"> <i class="icon-inbox"></i> Category Management</a> </li>
                        <li class="bg_lr"> <a href="<c:url value="/admin/listAdProduct"/>"> <i class="icon-th"></i> Product Management</a> </li>
                        <li class="bg_ls"> <a href="<c:url value="/admin/listAdPromotion"/>"> <i class="icon-fullscreen"></i> Promotion Management</a> </li>
                        <li class="bg_lo span3"> <a href="<c:url value="/admin/listAdOrder"/>"> <i class="icon-th-list"></i> Order Management</a> </li>
                    </ul>
                </div>
                <!--End-Action boxes-->    

                <!--Chart-box-->    
                <div class="row-fluid">
                    <div class="widget-box">
                        <div class="widget-title bg_lg"><span class="icon"><i class="icon-signal"></i></span>
                            <h5>Site Analytics</h5>
                        </div>
                        <div class="widget-content" >
                            <div class="row-fluid">
                                <div class="span9">
                                    <div class="chart"></div>
                                </div>
                                <div class="span3">
                                    <ul class="site-stats">
                                        <li class="bg_lh"><i class="icon-user"></i> <strong>${userSize}</strong> <small>Total Users</small></li>
                                        <li class="bg_lh"><i class="icon-tag"></i> <strong>${productSize}</strong> <small>Total Product </small></li>
                                        <li class="bg_lh"><i class="icon-shopping-cart"></i> <strong>${orderSize}</strong> <small>Total Order</small></li>
                                        <li class="bg_lh"><i class="icon-book"></i> <strong>${categorySize}</strong> <small>Total Category</small></li>
                                        <li class="bg_lh"><i class="icon-circle-arrow-down"></i> <strong>${promotionSize}</strong> <small>Promotion Orders</small></li>
                                        <li class="bg_lh"><i class="icon-globe"></i> <strong>1</strong> <small>Online Orders</small></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--End-Chart-box--> 
                <hr/>
                <div class="row-fluid">
                    <div class="span12">
                        <div class="widget-box widget-calendar">
                            <div class="widget-title"> <span class="icon"><i class="icon-calendar"></i></span>
                                <h5>Calendar</h5>
                                <div class="buttons"> <a id="add-event" data-toggle="modal" href="#modal-add-event" class="btn btn-inverse btn-mini"><i class="icon-plus icon-white"></i> Add new event</a>
                                    <div class="modal hide" id="modal-add-event">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal">×</button>
                                            <h3>Add a new event</h3>
                                        </div>
                                        <div class="modal-body">
                                            <p>Enter event name:</p>
                                            <p>
                                                <input id="event-name" type="text" />
                                            </p>
                                        </div>
                                        <div class="modal-footer"> <a href="#" class="btn" data-dismiss="modal">Cancel</a> <a href="#" id="add-event-submit" class="btn btn-primary">Add event</a> </div>
                                    </div>
                                </div>
                            </div>
                            <div class="widget-content">
                                <div class="panel-left">
                                    <div id="fullcalendar"></div>
                                </div>
                                <div id="external-events" class="panel-right">
                                    <div class="panel-title">
                                        <h5>Drag Events to the calander</h5>
                                    </div>
                                    <div class="panel-content">
                                        <div class="external-event ui-draggable label label-inverse">My Event 1</div>
                                        <div class="external-event ui-draggable label label-inverse">My Event 2</div>
                                        <div class="external-event ui-draggable label label-inverse">My Event 3</div>
                                        <div class="external-event ui-draggable label label-inverse">My Event 4</div>
                                        <div class="external-event ui-draggable label label-inverse">My Event 5</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <!--end-main-container-part-->
        <!--Footer-part-->

        <div class="row-fluid">
            <div id="footer" class="span12"> 2013 &copy; Matrix Admin. </div>
        </div>

        <!--end-Footer-part-->

        <!--Footer-js-->
        <script src="<c:url value="/resources-management/js/excanvas.min.js"/>"></script> 
        <script src="<c:url value="/resources-management/js/jquery.min.js"/>"></script> 
        <script src="<c:url value="/resources-management/js/jquery.ui.custom.js"/>"></script> 
        <script src="<c:url value="/resources-management/js/bootstrap.min.js"/>"></script> 
        <script src="<c:url value="/resources-management/js/jquery.flot.min.js"/>"></script> 
        <script src="<c:url value="/resources-management/js/jquery.flot.resize.min.js"/>"></script> 
        <script src="<c:url value="/resources-management/js/jquery.peity.min.js"/>"></script> 
        <script src="<c:url value="/resources-management/js/fullcalendar.min.js"/>"></script> 
        <script src="<c:url value="/resources-management/js/matrix.js"/>"></script> 
        <script src="<c:url value="/resources-management/js/matrix.dashboard.js"/>"></script> 
        <script src="<c:url value="/resources-management/js/jquery.gritter.min.js"/>"></script> 
        <script src="<c:url value="/resources-management/js/matrix.interface.js"/>"></script> 
        <script src="<c:url value="/resources-management/js/matrix.chat.js"/>"></script> 
        <script src="<c:url value="/resources-management/js/jquery.validate.js"/>"></script> 
        <script src="<c:url value="/resources-management/js/matrix.form_validation.js"/>"></script> 
        <script src="<c:url value="/resources-management/js/jquery.wizard.js"/>"></script> 
        <script src="<c:url value="/resources-management/js/jquery.uniform.js"/>"></script> 
        <script src="<c:url value="/resources-management/js/select2.min.js"/>"></script> 
        <script src="<c:url value="/resources-management/js/matrix.popover.js"/>"></script> 
        <script src="<c:url value="/resources-management/js/jquery.dataTables.min.js"/>"></script> 
        <script src="<c:url value="/resources-management/js/matrix.tables.js"/>"></script> 

        <script type="text/javascript">
            // This function is called from the pop-up menus to transfer to
            // a different page. Ignore if the value returned is a null string:
            function goPage(newURL) {

                // if url is empty, skip the menu dividers and reset the menu selection to default
                if (newURL != "") {

                    // if url is "-", it is this page -- reset the menu:
                    if (newURL == "-") {
                        resetMenu();
                    }
                    // else, send page to designated URL            
                    else {
                        document.location.href = newURL;
                    }
                }
            }

            // resets the menu selection upon entry to this page:
            function resetMenu() {
                document.gomenu.selector.selectedIndex = 2;
            }
        </script>
    </body>
</html>