<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib  uri="http://www.springframework.org/security/tags" 
           prefix="sec" %>
<!--sidebar-menu-->
<div id="sidebar"><a href="<c:url value="/admin/home"/>" class="visible-phone"><i class="icon icon-home"></i> Dashboard</a>
    <ul>
        <li class="${activehome}"><a href="<c:url value="/admin/home"/>"><i class="icon icon-home"></i> <span>Dashboard</span></a> </li>
            <sec:authorize access="isAuthenticated()">

            <sec:authorize access="hasRole('ROLE_ADMIN')">
                <li class="${activeuser}"> <a href="<c:url value="/admin/listAdAccount"/>"><i class="icon icon-signal"></i> <span>Account Management</span></a> </li>
                </sec:authorize>
                <sec:authorize access="hasRole('ROLE_SELLER') || hasRole('ROLE_ADMIN')">
                <li class="${activecategory}"> <a href="<c:url value="/admin/listAdCategory"/>"><i class="icon icon-inbox"></i> <span>Category Management</span></a> </li>
                <li class="${activeproduct}"> <a href="<c:url value="/admin/listAdProduct"/>"><i class="icon icon-th"></i> <span>Product Management</span></a></li>
                <li class="${activepromotion}"> <a href="<c:url value="/admin/listAdPromotion"/>"><i class="icon icon-fullscreen"></i> <span>Promotion Management</span></a></li>
                <li class="${activeorder}"> <a href="<c:url value="/admin/listAdOrder"/>"><i class="icon icon-th-list"></i> <span>Order Management</span></a></li>
                </sec:authorize>
            </sec:authorize>
    </ul>
</div>
