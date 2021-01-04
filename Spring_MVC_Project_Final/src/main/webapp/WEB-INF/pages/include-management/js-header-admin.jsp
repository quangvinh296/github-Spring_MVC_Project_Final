<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="application/x-javascript"> addEventListener("load", function() { setTimeout(hideURLbar, 0); }, false); function hideURLbar(){ window.scrollTo(0,1); } </script>
<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<!--js-->
<script src="<c:url value="/resources-management/js/jquery-2.1.1.min.js"/>"></script>
<!--static chart-->
<script src="<c:url value="/resources-management/js/Chart.min.js"/>"></script>
<!--//charts-->
<!-- geo chart -->
<script src="http://cdn.jsdelivr.net/modernizr/2.8.3/modernizr.min.js" type="text/javascript"></script>
<!--<script>window.modernizr || document.write('<script src="lib/modernizr/modernizr-custom.js"><\/script>')</script>-->
<!--<script src="lib/html5shiv/html5shiv.js"></script>-->
<!-- Chartinator  -->
<script src="<c:url value="/resources-management/js/chartinator.js" />"></script>
<script type="text/javascript">
    jQuery(function ($) {

        var chart3 = $('#geoChart').chartinator({
            tableSel: '.geoChart',

            columns: [{role: 'tooltip', type: 'string'}],

            colIndexes: [2],

            rows: [
                ['China - 2015'],
                ['Colombia - 2015'],
                ['France - 2015'],
                ['Italy - 2015'],
                ['Japan - 2015'],
                ['Kazakhstan - 2015'],
                ['Mexico - 2015'],
                ['Poland - 2015'],
                ['Russia - 2015'],
                ['Spain - 2015'],
                ['Tanzania - 2015'],
                ['Turkey - 2015']],

            ignoreCol: [2],

            chartType: 'GeoChart',

            chartAspectRatio: 1.5,

            chartZoom: 1.75,

            chartOffset: [-12, 0],

            chartOptions: {

                width: null,

                backgroundColor: '#fff',

                datalessRegionColor: '#F5F5F5',

                region: 'world',

                resolution: 'countries',

                legend: 'none',

                colorAxis: {

                    colors: ['#679CCA', '#337AB7']
                },
                tooltip: {

                    trigger: 'focus',

                    isHtml: true
                }
            }


        });
    });
</script>
<!--geo chart-->

<!--skycons-icons-->
<script src="<c:url value="/resources-management/js/skycons.js"/>"></script>
<!--//skycons-icons-->
<script>
    var toggle = true;

    $(".sidebar-icon").click(function () {
        if (toggle)
        {
            $(".page-container").addClass("sidebar-collapsed").removeClass("sidebar-collapsed-back");
            $("#menu span").css({"position": "absolute"});
        } else
        {
            $(".page-container").removeClass("sidebar-collapsed").addClass("sidebar-collapsed-back");
            setTimeout(function () {
                $("#menu span").css({"position": "relative"});
            }, 400);
        }
        toggle = !toggle;
    });
</script>
<!--scrolling js-->
<script src="<c:url value="/resources-management/js/jquery.nicescroll.js"/>"></script>
<script src="<c:url value="/resources-management/js/scripts.js"/>"></script>
<!--//scrolling js-->
<script src="<c:url value="/resources-management/js/bootstrap.js"/>"></script>
<!-- mother grid end here-->
<script src="<c:url value="/resources-management/js/bars.js"/>"></script>

<script type="text/javascript" src="<c:url value="/resources-management/js/nivo-lightbox.min.js"/>"></script>
<script type="text/javascript">
    $(document).ready(function () {
        $('#nivo-lightbox-demo a').nivoLightbox({effect: 'fade'});
    });
</script>
