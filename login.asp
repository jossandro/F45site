<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="../Connections/dbConnect.asp" -->

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
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>F45</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="F45 website" />
    <meta name="keywords" content="F45" />
    <meta name="author" content="ReturnOnClick" />


    <!-- Facebook and Twitter integration -->
    <meta property="og:title" content=""/>
    <meta property="og:image" content=""/>
    <meta property="og:url" content=""/>
    <meta property="og:site_name" content=""/>
    <meta property="og:description" content=""/>
    <meta name="twitter:title" content="" />
    <meta name="twitter:image" content="" />
    <meta name="twitter:url" content="" />
    <meta name="twitter:card" content="" />

    <!-- Place favicon.ico and apple-touch-icon.png in the root directory -->
    <link rel="shortcut icon" href="">

    <link href='https://fonts.googleapis.com/css?family=Roboto:400,100,300,700' rel='stylesheet' type='text/css'>

    <!-- Icomoon Icon Fonts-->
    <link rel="stylesheet" href="css/icomoon.css">
    <!-- Bootstrap  -->
    <link rel="stylesheet" href="css/bootstrap.css">
    <!-- Owl Carousel -->
    <link rel="stylesheet" href="css/owl.carousel.min.css">
    <link rel="stylesheet" href="css/owl.theme.default.min.css">
    <!-- Animate.css -->
    <link rel="stylesheet" href="css/animate.css">
    <!-- Superfish -->
    <link rel="stylesheet" href="css/superfish.css">

    <!-- Theme Style -->
    <link rel="stylesheet" href="css/style.css">



    <!-- FOR IE9 below -->
    <!--[if lt IE 9]>
    <script src="js/modernizr-2.6.2.min.js"></script>
    <script src="js/respond.min.js"></script>
    <![endif]-->

</head>
<body>

<header id="fh5co-header-section" role="header">
    <div class="fluid-container text-center">
        <div class="fh5co-navbar-brand">
            <div class="col-md-offset-4 col-md-4 col-sm-12 col-xs-12 text-center">
                <a class="fh5co-logo" href="index.html">F45</a>
            </div>
        </div>
    </div>
</header>


<section id="fh5co-login-section" class="section">
    <div class="container">
        <div class="col-md-12 text-center">
            <h2>Login</h2>
        </div>
        <div class="row">
            <div class="col-md-offset-4 col-md-4 col-sm-12 col-xs-12">

                <form name="loginform" method="POST" action="<%=MM_LoginAction%>">
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