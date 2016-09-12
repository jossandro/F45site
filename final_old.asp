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

<% 

 %>


<%
' *** Redirect If Session Var Value Matches
' *** MagicBeat Server Behavior - 2018 - by Jag S. Sidhu - www.magicbeat.com

'If Session("result") = "400 refused" Then
'Response.Redirect("resultfail.asp")
'else if
'Response.Redirect("resultfail.asp")
'end if
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
<!-- InstanceEndEditable --><!-- InstanceParam name="layer" type="boolean" value="false" -->
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
  
  



 </div>
<div id="admin"> 
							<!-- InstanceBeginEditable name="main" -->
<div align="center"> 
  <p>&nbsp;</p>
  <p align="center">&nbsp;</p>
  <% If (left(Request.QueryString("message"),15) = "Order generated") Then %>
  <h1 align="center">Thank You 
    for your order</h1>
  <p align="center">Your order 
    has been received and will be processed shortly.</p>
  <p align="center">Order ID:<%= Session("ref") %></p>
  <p align="center">Authorisation 
    ID:<%= Session("auth") %></p>
  <p align="center">Transaction 
    Status: <%= Request.QueryString("message") %></p>
<% Else %>
	<h1>
    Your transaction has failed </h1>
    <p>Error: <%= Session("result") %> </p>
     <p align="center">please <a href="../contactus.html">contact us </a>for alternative arrangements and quote this number</p>   <p align="center">Order ID:<%= Session("ref") %></p>
       <p align="center">Transaction 
    Status: <%= Request.QueryString("message") %></p>

<% End If %>
  <p align="center">
    <br>
    To  return to our Home page
    click on the Home Page button.<br>
    To place a new order click on the New Order button.</p>
  <p align="center"> 
&nbsp;
<input type="submit" name="Submit2" value="Robbie Barsman  Home Page" onClick=dahdah_web()>    
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

<%
%>

<%
' Authorise.close() 
%>