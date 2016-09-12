<%@LANGUAGE="VBSCRIPT"%> 
<!--#include file="restrict.asp" -->
<!--#include file="./Connections/dbConnect.asp" -->
<% 
Session("orderid") = ""
 %>
<!doctype html><html><!-- InstanceBegin template="/Templates/f45training.dwt.asp" codeOutsideHTMLIsLocked="false" -->


<head>
<meta charset="utf-8">
<!-- InstanceBeginEditable name="doctitle" -->
<title>Joseph Dahdah - Uniform Apparel Collection</title>
<!-- InstanceEndEditable -->
<link href="../joseph.css" rel="stylesheet" type="text/css">
<!-- InstanceBeginEditable name="head" -->



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

<!-- InstanceEndEditable --><!-- InstanceParam name="layer" type="boolean" value="true" -->
<link href="F45_files/style_002.css" rel="stylesheet" media="all">
<link href="F45_files/responsive.css" rel="stylesheet" media="all">
<link href="F45_files/font-awesome_002.css" rel="stylesheet" media="all">
<link href="F45_files/font-awesome.css" rel="stylesheet">
<link href="F45_files/css.css" rel="stylesheet" type="text/css">
<link href="F45_files/style.css" rel="stylesheet" type="text/css">
<link href="F45_files/skins.css" rel="stylesheet" type="text/css">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="description" content="At F45 Training we have been the pioneers of functional group training and we are now taking it to the Australian market via our franchisee network.">
<meta name="author" content="Creative Lounge">
</head>
<body>
	<!-- *.Wrapper.* -->
<div id="wrapper">
	<!-- *.Inner Wrapper.* -->
	<div class="inner-wrapper">
	   <!-- *.Header.* -->
        <header id="header">
            <!-- *.Header Container.* -->
            <div class="container">
			
                
                
                <!-- Logo -->
                <div id="logo">
                    <a href="http://f45training.com.au/" title=""> <img src="F45_files/f45_logo.png" alt="" title=""> </a> 
                </div><!-- Logo End -->
                 <!-- Logo -->
                <div id="robbie-logo">
                    <a href="http://www.robbiebarsman.com/" title=""> <img src="images/robbie-barsman-logo.png" alt="" title="Robie Barsman"> </a> 
                </div><!-- Logo End -->               
                 
            </div><!-- *.Header Container End.* -->
        </header><!-- *.Header End.* -->
        
        <!-- *.Main Menu.* -->
        <nav id="main-menu">	
            <!-- *.Main Menu Container.* -->
            <div class="container">    	
				<div class="menu-top-menu-left-container"><ul class="left-main-menu sf-menu sf-js-enabled"><li id="menu-item-30" class="menu-item menu-item-type-post_type menu-item-object-page menu-item-30"><a href="http://f45training.com.au/">F45 Training Home</a><span>&nbsp;</span></li>

</ul></div>				<div class="menu-top-menu-right-container"><ul class="right-main-menu sf-menu sf-js-enabled">
</ul></div>			</div><!-- *.Main Menu Container End.* -->
        </nav>
		
	
<section class="main-title">
	<div class="container">
		<h1> Robbie Barsman Online Ordering System</h1>
	</div>
</section><!-- *.Main Title.* -->


	
<!-- *.Main.* -->
<section id="main">
<!-- *.Main Container.* -->
	<div class="container">
<!-- *.Content.* -->

<div class="left">
              
<div id="cart">
        <% 
	Dim Check_cart
	Check_cart = 0
 	For Each strKeyname in Request.Cookies("splat") 
		if Request.Cookies("splat")(strKeyname) <> "" then
			Check_cart = Check_cart + 1
		End If
	Next
%> 
<%
	If Check_cart>0 Then %>
          Order no -> <%= Session("orderid") %><br>
		&nbsp;&nbsp;&nbsp;<a href="view_order.asp" ><img src="images/ico_shopping_cart.gif" border="0"> &nbsp;&nbsp;<%= Check_cart  %> Orders in Cart</a>
		<% End If %>
</div>
  



             
<div id="catmenu" >
<% 
Dim   cat_title
Dim dept
Cat_title = ""
dept = 1

 %>
  <% While ((Repeat5__numRows <> 0) AND (NOT RSCat.EOF)) %>
<a href="products.asp?category=<%=(RSCat.Fields.Item("Cat_ID").Value)%>">
<%  
     If (Request.QueryString("category") <> "") Then 
 	 	If (Cstr(RSCat.Fields.Item("Cat_ID").Value) = Cstr(Request.QueryString("category"))) Then 
			Cat_title = RSCat.Fields.Item("categorys").Value 
			dept = RSCat.Fields.Item("dept").Value
		End If
	End If
	%>
 			
	<%=(RSCat.Fields.Item("categorys").Value)%></a>
    <% 
  Repeat5__index=Repeat5__index+1
  Repeat5__numRows=Repeat5__numRows-1
  RSCat.MoveNext()
Wend
%>
</div>
   <div id="submenu" >
            <a href="default.asp" > Ordering Instructions </a> 
               <a href="view_order.asp">View Cart </a>
            <a href="getOrderHistory.asp">Order History</a> 
           <% If (Session("client_ID") = 73) or (Session("client_ID") = 75)   Then  %>
            <% Else %>
             <a href="updatecustomerinfo.asp">Update Profile</a> 
			<% End If %>
			</div>
			<div id="submenu1">
            <a href="returns_exchanges.asp" > Returns &amp; Exchanges </a> 
            <a href="freight.asp" > Freight </a> 
            <a href="garment.asp" > Garment Care </a> 
            <a href="non_standard.asp" > Recommended Retail Price </a> 
             <a href="login.asp?logout=yes" > Log Out </a> 
</div>
           
 </div>
<div id="admin"> 
							<!-- InstanceBeginEditable name="main" -->
<div align="center"> 
  <h1 align="center">Online Ordering system.</h1>
  <p align="center">Transaction 
    Status: Cancelled</p>
  <p align="center"><br>
    If you wish to make alternative ordering arrangements<br>
    
    please <a href="http://josephdahdah.com.au/contactus.html">contact us </a>
  here .</p>
  <p align="center">
    <br>
    To  return to our Home page
    click on the Home Page button.<br>
    To proceed with a new order click on the New Order button.</p>
  <p align="center"> 
&nbsp;
<input type="submit" name="Submit" value="Joseph Dahdah Home Page" onClick=dahdah_web()>    
&nbsp;
    <input type="submit" name="Submit" value="New Order" onClick=doNewOrder()>
  </p>
</div>
<!-- InstanceEndEditable -->
	  </div>
      
<!-- *.Content End.* -->
			</div><!-- *.Main Container End.* -->
		</section>
		
		<footer id="footer">
			<!-- *.Footer Container.* -->
			<div class="container">
									
<div class="column one-fourth">
	   
</div>

				<div class="column one-fourth"></div>  
                
               
				
									
				<div class="column one-fourth">
					   
				</div>
                
                <div class="column one-fourth last">
                    
                </div>
            </div><!-- *.Footer Container End.* -->
        </footer><!-- *.Footer End.* -->
        
        <footer class="footer-copyright">
            <div class="container">
                <p> <span>Copyright © F45 2015</span> Site by <a href="http://www.splatgraphics.com.au/" title="" target="_blank">Splat Graphics</a></p>
                  
            </div>
        </footer>
    
	</div><!-- *.Inner Wrapper End.* -->
</div><!-- *.Wrapper End.* -->
</body>
<!-- InstanceEnd --></html>