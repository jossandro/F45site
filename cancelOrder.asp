<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="restrict.asp" -->
<!--#include file="./Connections/dbConnect.asp" -->
<% 
Session("orderid") = ""
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
var dahdahURL = "http://josephdahdah.com.au/policy.html"

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
    <div class="container"> 

        <h4 >Online Ordering system.</h4>
        <p >Transaction Status: Cancelled</p>
        <p ></p>
        <p > If you wish to make alternative ordering arrangements please <a href="contactus.asp">contact us </a> here .</p>




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

<%
RSCustomer.Close()
Set RSCustomer = Nothing
%>
<%
RSGet_client.Close()
Set RSCustomer = Nothing
%>
<%
RSEmail.Close()
Set RSCustomer = Nothing
%>
