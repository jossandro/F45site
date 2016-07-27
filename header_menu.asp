<%
'Dim RSCat__MMColParam
RSCat__MMColParam = "1"
If (Session("client_ID") <> "") Then 
  RSCat__MMColParam = Session("client_ID")
End If
%>
<%
'Dim RSClient1
'Dim RSClient1_numRows

Set RSClient1 = Server.CreateObject("ADODB.Recordset")
RSClient1.ActiveConnection = MM_dbConnect_STRING
RSClient1.Source = "SELECT * FROM client WHERE client_ID = " + Replace(RSCat__MMColParam, "'", "''") + ""
RSClient1.CursorType = 0
RSClient1.CursorLocation = 2
RSClient1.LockType = 1
RSClient1.Open()

RSClient1_numRows = 0
%>


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

    <!-- Toaster: notifications -->
    <link href="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/css/toastr.min.css" rel="stylesheet" type="text/css" />

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
                <a class="fh5co-logo" href="default.asp">F45</a>
            </div>
            <div class="col-md-4 pull-right">
                <nav id="fh5co-sliding-nav-right" role="navigation">
                    <ul>
                        <li><a href="#">
                            <span class="icon-search"></span>
                            <span class="visuallyhidden">Search</span>
                        </a></li>
                        <li><a href="updatecustomerinfo.asp" alt="profile">
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