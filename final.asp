<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="./Connections/dbConnect.asp" -->

<%
Session("auth") = Session("orderid")
%>
<%
If (CStr(Request("message"))<> "") then
  Session("result") = CStr(Request("message"))
else
  Session("result") = "Email not sent"
end if

%>
<%
Session("ref") = Session("orderid")
%>

<%

if (Session("ref") <> "") then
  Authorise__ref = Session("ref") 
end if

if (Session("result") <> "") then
  Authorise__result = Session("result")
end if

if (Session("auth") <> "") then
  Authorise__auth = Session("auth")
else
  Authorise__auth = "rejected"
end if


%>
<% 
  For Each strKeyname in Request.Cookies("splat") 
    if Request.Cookies("splat")(strKeyname) <> "" then
      Response.Cookies("splat")(strKeyname) = ""
    End If
  Next
  Session("orderid") = ""
%> 

<%
MM_Status = ""
MM_Status = Left(Authorise__result  & Authorise__auth, 49)

MM_Update_String = ""
MM_Update_String = "UPDATE Orders SET Status = '" & MM_Status & "' WHERE OrderID = '" & Authorise__ref & "'"
Session("SQL_String") = MM_Update_String
set Authorise = Server.CreateObject("ADODB.Command")
Authorise.ActiveConnection = MM_dbConnect_STRING
Authorise.CommandText = MM_Update_String
Authorise.CommandType = 1
Authorise.CommandTimeout = 0
Authorise.Prepared = true
Authorise.Execute()
 
%>


 
<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->

<!--#include file="header_menu.asp" -->

<script language="JavaScript">

<!--
function close_window() {
    window.close();
}
//-->

<!--
var dahdahURL = "http://www.robbiebarsman.com.au"

function dahdah_web() {
  window.location.replace(dahdahURL)
}
//-->

<!--
var newOrderURL = "default.asp"

function doNewOrder() {
  window.location.replace(newOrderURL)
}
//-->

</script>


<section id="fh5co-login-section" class="section">
    <div class="container"> <% 
        If (left(Request.QueryString("message"),15) = "Order generated") Then %>
            <h4 align="center">Thank You for your order</h4>
            <p >Your order has been received and will be processed shortly.</p>
            <p >Order ID:<%= Session("ref") %></p>
            <p >Authorisation ID:<%= Session("auth") %></p>
            <p >Transaction Status: <%= Request.QueryString("message") %></p>   <% 
        Else %>
            <h1>Your transaction has failed </h1>
            <p >Error: <%= Session("result") %> </p>
            <p >please <a href="contactus.asp">contact us </a>for alternative arrangements and quote this number</p>   
            <p >Order ID:<%= Session("ref") %></p>
            <p >Transaction Status: <%= Request.QueryString("message") %></p>     <% 
        End If %>        

    </div>
</section><!-- end fh5co-login-section -->


<footer id="fh5co-footer">
    <div class="container-fluid" id="footer-top">
        <div class="container">
        <div class="row">
            <div class="container">
                <div class="col-md-3 cols-sm-12">
                    <div class="row">
                        <div class="col-md-12 cols-sm-12">
                            <span class="pull-left icon-smile-o"></span>
                            <h4 class="pull-left">100% Satisfaction</h4>
                        </div>
                        <div class="col-md-12 cols-sm-12">
                            <div class="pull-left line"></div>
                            <p class="pull-left">If you are unable</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 cols-sm-12">
                    <div class="row">
                        <div class="col-md-12 cols-sm-12">
                            <span class="pull-left icon-thumbs-up"></span>
                            <h4 class="pull-left">100% Save 20% when you</h4>
                        </div>
                        <div class="col-md-12 cols-sm-12">
                            <div class="pull-left line"></div>
                            <p class="pull-left">use credit card</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 cols-sm-12">
                    <div class="row">
                        <div class="col-md-12 cols-sm-12">
                            <span class="pull-left icon-plane"></span>
                            <h4 class="pull-left">Fast Free Shipping</h4>
                        </div>
                        <div class="col-md-12 cols-sm-12">
                            <div class="pull-left line"></div>
                            <p class="pull-left">Load any computer's</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 cols-sm-12">
                    <div class="row">
                        <div class="col-md-12 cols-sm-12">
                            <span class="pull-left icon-money"></span>
                            <h4 class="pull-left">14 Days Money back</h4>
                        </div>
                        <div class="col-md-12 cols-sm-12">
                            <div class="pull-left line"></div>
                            <p class="pull-left">If your are unable</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="divider"></div>
        <div class="row">
            <div class="container">
                <div class="col-md-3 col-sm-6 cols-xs-12">
                    <div class="row">
                        <div class="col-md-12 cols-sm-12">
                            <h4>Policies & Info</h4>
                        </div>
                        <div class="col-md-12 cols-sm-12">
                            <div class="line"></div>
                            <ul class="pages-footer">
                                <li><a href="#">Term & Conditions</a></li>
                                <li><a href="#">Policy for Seller</a></li>
                                <li><a href="#">Policy for Buyer</a></li>
                                <li><a href="#">Shipping & Refund</a></li>
                                <li><a href="#">Wholesale policy</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 cols-xs-12">
                    <div class="row">
                        <div class="col-md-12 cols-sm-12">
                            <h4>Sellers</h4>
                        </div>
                        <div class="col-md-12 cols-sm-12">
                            <div class="line"></div>
                            <ul class="pages-footer">
                                <li><a href="#">Seller Login</a></li>
                                <li><a href="#">Seller Sign Up</a></li>
                                <li><a href="#">Seller Handbook</a></li>
                                <li><a href="#">Seller Control Panel</a></li>
                                <li><a href="#">Seller FAQS</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 cols-xs-12">
                    <div class="row">
                        <div class="col-md-12 cols-sm-12">
                            <h4>Our Services</h4>
                        </div>
                        <div class="col-md-12 cols-sm-12">
                            <div class="line"></div>
                            <ul class="pages-footer">
                                <li><a href="#">E-Commerce Stores</a></li>
                                <li><a href="#">Responsive Design</a></li>
                                <li><a href="#">Grid Layout</a></li>
                                <li><a href="#">Templates Services</a></li>
                                <li><a href="#">Website Development</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 col-sm-6 cols-xs-12">
                    <div class="row contact">
                        <div class="col-md-12 cols-sm-12">
                            <h4>Contact Us</h4>
                        </div>
                        <div class="col-md-12 cols-sm-12">
                            <div class="line"></div>
                            <ul class="pages-footer">
                                <li><span class="icon-map-pin2"></span><a href="#">Megnor Comp Pvt Limited,</a></li>
                                <li><a href="#">507-Union Trade Centre, Beside </a></li>
                                <li><a href="#">Apple Hospital, Udhana Darwaja,</a></li>
                                <li><span class="icon-phone"></span><a href="#">(91)-261 30023333</a></li>
                                <li><span class="icon-envelope"></span><a href="#">support@templatemela.com</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </div>
    </div>
    <div class="container-fluid" id="footer-bottom">
        <div class="row">
            <div class="container">
                <div class="col-md-4 cols-sm-12">
                    <ul class="fh5co-social-icons">
                        <li><a href="#"><span class="icon-facebook"></span></a></li>
                        <li><a href="#"><span class="icon-twitter"></span></a></li>
                        <li><a href="#"><span class="icon-instagram"></span></a></li>
                        <li><a href="#"><span class="icon-pinterest"></span></a></li>
                    </ul>
                </div>
                <div class="col-md-4 cols-sm-12 text-center">
                    <p>Copyright 2016 F45</p>
                </div>
                <div class="col-md-4 cols-sm-12">
                    <ul class="fh5co-cc-icons pull-right">
                        <li><a href="#"><span class="icon-cc-visa"></span></a></li>
                        <li><a href="#"><span class="icon-cc-mastercard"></span></a></li>
                        <li><a href="#"><span class="icon-cc-paypal"></span></a></li>
                        <li><a href="#"><span class="icon-cc-discover"></span></a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</footer>

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
