<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="restrict.asp" -->

<!--#include file="../Connections/dbConnect.asp" -->

<!--#include file="menu_top_db.asp" -->

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
    <meta name="description" content="F45" />
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
            <div class="col-md-4 pull-left">
                <nav id="fh5co-sliding-nav-left" role="navigation">
                    <ul>
                        <li><a href="#">F45 Training</a></li>
                        <li><a href="#">Contact Us</a></li>
                        <li><a href="#">Support</a></li>
                    </ul>
                </nav>
            </div>
            <div class="col-md-4 text-center">
                <a class="fh5co-logo" href="#">F45</a>
            </div>
            <div class="col-md-4 pull-right">
                <nav id="fh5co-sliding-nav-right" role="navigation">
                    <ul>
                        <li><a href="#">
                            <span class="icon-search"></span>
                            <span class="visuallyhidden">Search</span>
                        </a></li>
                        <li><a href="#">
                            <span class="icon-user"></span>
                            <span class="visuallyhidden">Login</span>
                        </a></li>
                        <li> <% 
                            Dim Check_cart
                            Check_cart = 0
                            For Each strKeyname in Request.Cookies("splat") 
                                if Request.Cookies("splat")(strKeyname) <> "" then
                                    Check_cart = Check_cart + 1
                                End If
                            Next
                            %>
                            
                            <a href="view_order.asp">
                                <span class="icon-shopping-cart"></span>
                                <span class="visuallyhidden">Shopping</span>
                                <%
                                If Check_cart>0 Then %>
                                    <span class="label"><%= Check_cart  %></span> 
                                <% End If %>
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>

        </div>
        <!-- START #fh5co-menu-wrap -->
        <% 
        Dim   cat_title
        Dim dept
        Cat_title = ""
        dept = 1

         %>
          
        <nav id="fh5co-menu-wrap" role="navigation" class="col-md-12 text-center">
            <ul class="sf-menu" id="fh5co-primary-menu">
                <li class="active">
                    <a href="#" class="fh5co-sub-ddown">Mens</a>
                    <ul class="fh5co-sub-menu">
                        <li><a href="products.asp?category=298">Tees</a></li>
                        <li><a href="products.asp?category=342">Corporate Range</a></li>
                    </ul>
                </li>
                <li>
                    <a href="#">Womens</a>
                    <ul class="fh5co-sub-menu">
                        <li><a href="products.asp?category=299">Tees</a></li>
                        <li><a href="products.asp?category=357">Corporate Range</a></li>
                    </ul>
                </li>
                <li>
                    <a href="products.asp?category=303">Uniforms</a>
                </li>
                <li>
                    <a href="products.asp?category=356">Accessories</a>
                </li>
                <li>
                    <a href="#">Novelty</a>
                    <ul class="fh5co-sub-menu">
                        <li><a href="products.asp?category=355">Headwear</a></li>
                        <li><a href="products.asp?category=354">Hoodies + Trackpants</a></li>
                        <li><a href="products.asp?category=300">Tanks - Unisex</a></li>
                    </ul>
                </li>
        </nav>
    </div>
</header>


<section class="owl-carousel owl-carousel1 owl-carousel-fullwidth fh5co-light-arrow animate-box" data-animate-effect="fadeIn">
    <div class="item"><a href="images/under-armour.jpg" class="image-popup"><img src="images/under-armour.jpg" alt="image"></a></div>
    <div class="item"><a href="images/nike-just-do-it.jpg" class="image-popup"><img src="images/nike-just-do-it.jpg" alt="image"></a></div>
</section>


<section id="fh5co-products-section" class="section">
    <div class="container">
        <div class="row">
            <div class="col-md-12 text-center">
                <h2>Top Products</h2>
            </div>
            <div class="col-md-6 col-md-offset-3 text-center">
                <a class="btn btn-filters" href="#">Best Sellers</a>
                <a class="btn btn-filters" href="#">New Arrivals</a>
                <a class="btn btn-filters" href="#">Featured</a>
            </div>
        </div>
    </div>

    <%
    Dim RSProduct
    Dim RSProduct_numRows

    Set RSProduct = Server.CreateObject("ADODB.Recordset")
    RSProduct.ActiveConnection = MM_dbConnect_STRING
    'RSProduct.Source = "SELECT * FROM extend_products WHERE Cat_ID = " + Replace(RSProduct__MMColParam, "'", "''") + " ORDER BY listp, Description ASC"
    RSProduct.Source = "SELECT * FROM extend_products WHERE Cat_ID = '300' ORDER BY listp, Description ASC"
    RSProduct.CursorType = 0
    RSProduct.CursorLocation = 2
    RSProduct.LockType = 1
    RSProduct.Open()

    RSProduct_numRows = 0
    %>

    <div class="container padding-top-60">
        <div class="row"> <% 
            While (NOT RSProduct.EOF) 
                Cat_title = RSProduct.Fields.Item("Description").value       
                %>
                <div class="products col-md-3 animate-box">
                    <!-- <span class="featured sale"><small>Sale</small></span> -->
                    <figure>
                        <img class="img-responsive" src="../databases/images/<%=(RSProduct.Fields.Item("smimage").Value)%>" alt="tshirt">
                    </figure>
                    <p class="item-name"><a href="#">Functional F45 Paramont</a></p>
                    <p class="item-category"><small>Men's Tshirt</small></p>
                    <p class="item-price">$12.50</p>
                </div>

                <%
                Repeat1__index=Repeat1__index+1
                Repeat1__numRows=Repeat1__numRows-1
                RSProduct.MoveNext()
            Wend
            %>  
            <div class="products col-md-3 animate-box">
                <span class="featured sale"><small>Sale</small></span>
                <figure>
                    <img class="img-responsive" src="images/tshirt.png" alt="tshirt">
                </figure>
                <p class="item-name"><a href="#">Functional F45 Paramont</a></p>
                <p class="item-category"><small>Men's Tshirt</small></p>
                <p class="item-price">$12.50</p>
            </div>
            <div class="products col-md-3 animate-box">
                <span class="featured"><small></small></span>
                <figure>
                    <img class="img-responsive" src="images/tshirt.png" alt="tshirt">
                </figure>
                <p class="item-name"><a href="#">Functional F45 Paramont</a></p>
                <p class="item-category"><small>Men's Tshirt</small></p>
                <p class="item-price">$12.50</p>
            </div>
            <div class="products col-md-3 animate-box">
                <span class="featured"><small></small></span>
                <figure>
                    <img class="img-responsive" src="images/tshirt.png" alt="tshirt">
                </figure>
                <p class="item-name"><a href="#">Functional F45 Paramont</a></p>
                <p class="item-category"><small>Men's Tshirt</small></p>
                <p class="item-price">$12.50</p>
            </div>
            <div class="products col-md-3 animate-box">
                <span class="featured arrival"><small>New Arrivals</small></span>
                <figure>
                    <img class="img-responsive" src="images/tshirt.png" alt="tshirt">
                </figure>
                <p class="item-name"><a href="#">Functional F45 Paramont</a></p>
                <p class="item-category"><small>Men's Tshirt</small></p>
                <p class="item-price">$12.50</p>
            </div>
            <div class="products col-md-3 animate-box">
                <span class="featured"><small></small></span>
                <figure>
                    <img class="img-responsive" src="images/tshirt.png" alt="tshirt">
                </figure>
                <p class="item-name"><a href="#">Functional F45 Paramont</a></p>
                <p class="item-category"><small>Men's Tshirt</small></p>
                <p class="item-price">$12.50</p>
            </div>
            <div class="products col-md-3 animate-box">
                <span class="featured arrival"><small>New Arrivals</small></span>
                <figure>
                    <img class="img-responsive" src="images/tshirt.png" alt="tshirt">
                </figure>
                <p class="item-name"><a href="#">Functional F45 Paramont</a></p>
                <p class="item-category"><small>Men's Tshirt</small></p>
                <p class="item-price">$12.50</p>
            </div>
            <div class="products col-md-3 animate-box">
                <span class="featured"><small></small></span>
                <figure>
                    <img class="img-responsive" src="images/tshirt.png" alt="tshirt">
                </figure>
                <p class="item-name"><a href="#">Functional F45 Paramont</a></p>
                <p class="item-category"><small>Men's Tshirt</small></p>
                <p class="item-price">$12.50</p>
            </div>
            <div class="products col-md-3 animate-box">
                <span class="featured"><small></small></span>
                <figure>
                    <img class="img-responsive" src="images/tshirt.png" alt="tshirt">
                </figure>
                <p class="item-name"><a href="#">Functional F45 Paramont</a></p>
                <p class="item-category"><small>Men's Tshirt</small></p>
                <p class="item-price">$12.50</p>
            </div>
            <div class="products col-md-3 animate-box">
                <span class="featured arrival"><small>New Arrivals</small></span>
                <figure>
                    <img class="img-responsive" src="images/tshirt.png" alt="tshirt">
                </figure>
                <p class="item-name"><a href="#">Functional F45 Paramont</a></p>
                <p class="item-category"><small>Men's Tshirt</small></p>
                <p class="item-price">$12.50</p>
            </div>
            <div class="products col-md-3 animate-box">
                <span class="featured"><small></small></span>
                <figure>
                    <img class="img-responsive" src="images/tshirt.png" alt="tshirt">
                </figure>
                <p class="item-name"><a href="#">Functional F45 Paramont</a></p>
                <p class="item-category"><small>Men's Tshirt</small></p>
                <p class="item-price">$12.50</p>
            </div>
            <div class="products col-md-3 animate-box">
                <span class="featured"><small></small></span>
                <figure>
                    <img class="img-responsive" src="images/tshirt.png" alt="tshirt">
                </figure>
                <p class="item-name"><a href="#">Functional F45 Paramont</a></p>
                <p class="item-category"><small>Men's Tshirt</small></p>
                <p class="item-price">$12.50</p>
            </div>
            <div class="products col-md-3 animate-box">
                <span class="featured"><small></small></span>
                <figure>
                    <img class="img-responsive" src="images/tshirt.png" alt="tshirt">
                </figure>
                <p class="item-name"><a href="#">Functional F45 Paramont</a></p>
                <p class="item-category"><small>Men's Tshirt</small></p>
                <p class="item-price">$12.50</p>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="row">
            <div class="col-md-6 col-md-offset-3 text-center">
                <a class="btn btn-filters" href="#">< PREV</a>
                <a class="btn btn-filters" href="#">NEXT ></a>
            </div>
        </div>
    </div>

</section><!-- end fh5co-intro-section -->


<section id="fh5co-essentials-section" class="section">
    <div class="container">
        <div class="col-md-12 text-center">
            <h2>Essentials</h2>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="col-md-6 col-sm-6 animate-box essentials-box">
                    <div class="text-center">
                        <h1>Work basic Range</h1>
                    </div>
                </div>
                <div class="col-md-6 col-sm-6 animate-box essentials-box">
                    <div class="text-center">
                        <h1>Staff Uniform</h1>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section><!-- end fh5co-common-section -->


<section id="fh5co-newsletter-section">
    <div class="container">
        <div class="row">
            <div class="col-md-2 cols-sm-12">
                <h1>Newsletter</h1>
            </div>
            <div class="col-md-4 cols-sm-12">
                <p>If You Are Unable To Load Any Pages,</p>
                <p>Check Your Computer.</p>
            </div>
            <div class="col-md-6 cols-sm-12">
                <form action="">
                    <div class="row">
                        <div class="col-md-12">
                            <span class="icon-envelope"></span><input type="email" class="email-newsletter col-md-10" placeholder="Email">
                            <input type="submit" class="btn btn-newsletter col-md-2" value="Send">
                        </div>

                    </div>
                </form>
            </div>
        </div>
    </div>
</section>

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
                <div class="col-md-3 cols-sm-12">
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
                <div class="col-md-3 cols-sm-12">
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
                <div class="col-md-3 cols-sm-12">
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
                <div class="col-md-3 cols-sm-12">
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