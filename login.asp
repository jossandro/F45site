<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="./Connections/dbConnect.asp" -->

<% 
Dim message
message = ""
 %>
 <% ' logout has occured
If Request.QueryString("logout") <> "" Then
 session.abandon 
 Response.Redirect("login.asp") 
End If
  %>
 <!--#include file="login_process.asp" -->
 
<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->

<!--#include file="header_menu.asp" -->


<section id="fh5co-login-section" class="section">
    <div class="container">
        <div class="col-md-12 text-center">
            <h2>Login</h2>
        </div>
        <div class="row">
            <div class="col-md-offset-4 col-md-4 col-sm-12 col-xs-12">

                <form name="loginform" method="POST" action="login.asp">        <!-- <%=MM_LoginAction%>   -->
                    <div class="form-group">
                        <label for="UserID">Username</label>
                        <input name="UserID" type="text" class="form-control" id="UserID" placeholder="Username">
                    </div>
                    <div class="form-group">
                        <label for="Password">Password</label>
                        <input name="Password" type="password" class="form-control" id="Password" placeholder="Password">
                    </div>
                    <input name="send" type="submit" class="btn btn-filters" value="Submit" />
                    <input type="button" name="send" value="Register" onclick="location.href='register.asp';" class="btn btn-filters" />
                </form>

            </div>
        </div>
    </div>
</section><!-- end fh5co-login-section -->

<!--#include file="footer.asp" -->

<!-- jQuery -->
<script src="js/jquery.min.js"></script>
<!-- jQuery Easing -->
<script src="js/jquery.easing.1.3.js"></script>
<!-- Bootstrap -->
<script src="js/bootstrap.min.js"></script>
<!-- Carousel -->
<script src="js/owl.carousel.min.js"></script>
<!-- Stellar -->
<script src="js/jquery.stellar.min.js"></script>
<!-- Waypoints -->
<script src="js/jquery.waypoints.min.js"></script>
<!-- Counters -->
<script src="js/jquery.countTo.js"></script>
<!-- Superfish -->
<script src="js/hoverIntent.js"></script>
<script src="js/superfish.js"></script>

<!-- MAIN JS -->
<script src="js/main.js"></script>

</body>
</html>