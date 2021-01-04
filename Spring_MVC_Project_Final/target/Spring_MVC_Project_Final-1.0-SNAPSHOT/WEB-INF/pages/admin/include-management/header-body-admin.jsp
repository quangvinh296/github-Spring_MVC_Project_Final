<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--top-Header-menu-->
<div id="user-nav" class="navbar navbar-inverse">
  <ul class="nav">
    <li  class="dropdown" id="profile-messages" ><a title="" href="#" data-toggle="dropdown" data-target="#profile-messages" class="dropdown-toggle"><i class="icon icon-user"></i>  <span class="text">Welcome ${user.email}</span><b class="caret"></b></a>
      <ul class="dropdown-menu">
        <li><a href="<c:url value="/admin/my-account/${user.id}"/>"><i class="icon-user"></i> My Profile</a></li>
        <li class="divider"></li>
        <li><a href="<c:url value="/logout"/>"><i class="icon-key"></i> Log Out</a></li>
      </ul>
    </li>
    <li class=""><a title="" href="<c:url value="/logout"/>"><i class="icon icon-share-alt"></i> <span class="text">Logout</span></a></li>
  </ul>
</div>
<!--close-top-Header-menu-->        
