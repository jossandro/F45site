<%@LANGUAGE="VBSCRIPT"%> 
<!--#include file="../Connections/dbConnect.asp" -->
<% 
Dim MM_editAction
  Dim RSOrders__ID
  Dim RSOrders
  Dim RSOrders_numRows

	Dim RSEmail
	Dim RSEmail_numRows

	Dim client_ID
	Dim RSClient
	Dim RSClient_numRows

	Dim RsCust
	Dim RsCust__User_ID
	
	Dim RSAddress
	Dim RSAddress_numRows

	Dim Delivery
	Dim MM_Status
	
	Dim RsOrderHistory
	Dim RsOrderHistory_numRows
	' Define Table Variables
	Dim TableRows, TableIndex, RowTotal, OrderTotal
	TableRows = -1
	TableIndex = 0
	RowTotal = 0
	OrderTotal = 0
	
	Dim error_message
	message = ""
 %>


<%

If (Request.querystring("refnumber") <> "") Then ' orderID is set to refnumber in the payway fields.
    RSOrders__ID = CStr(Request.querystring("refnumber"))
	get_order()
	message = ""
	If (Request.querystring("Status") <> "") Then
 	    MM_Status = CStr(Request.querystring("Status"))
		
	    update_order()
	End	If
	'send_email()
Else
	message =  " No order number received"
End If

MM_editAction = CStr(Request("URL"))


Function update_order()

  MM_Update_String = "UPDATE Orders SET Status = '" & MM_Status & "' WHERE OrderID = '" & RSOrders__ID & "'"
  set Authorise = Server.CreateObject("ADODB.Command")
  Authorise.ActiveConnection = MM_dbConnect_STRING
  Authorise.CommandText = MM_Update_String
  Authorise.CommandType = 1
  Authorise.CommandTimeout = 0
  Authorise.Prepared = true
  Authorise.Execute()
End Function
%>

<% 
Function get_order()
  MM_Update_String = "SELECT * FROM Orders WHERE OrderID = " & RSOrders__ID & " "
  Set RSOrders = Server.CreateObject("ADODB.Recordset")
  RSOrders.ActiveConnection = MM_dbConnect_STRING
  RSOrders.Source = "SELECT * FROM Orders WHERE OrderID = '" & RSOrders__ID & "'"
  RSOrders.CursorType = 0
  RSOrders.CursorLocation = 2
  RSOrders.LockType = 1
  RSOrders.Open()
  
  RSOrders_numRows = 0
  If ( RSOrders.EOF) Then  ' order is not in the system.
		  RSOrders.Close()
		  Set RSOrders = Nothing
		  message =  " No record found"
  Else
	RsCust__User_ID = RSOrders.Fields.Item("UserID").Value
  	Address_id = RSOrders.Fields.Item("Address").Value
	
 
	set RsCust = Server.CreateObject("ADODB.Recordset")
	RsCust.ActiveConnection = MM_dbConnect_String
	RsCust.Source = "SELECT * FROM customers WHERE userid = '" + Replace(RsCust__User_ID, "'", "''") + "'"
	RsCust.CursorType = 0
	RsCust.CursorLocation = 2
	RsCust.LockType = 3
	RsCust.Open()
	RsCust_numRows = 0

	
	Set RSEmail = Server.CreateObject("ADODB.Recordset")
	RSEmail.ActiveConnection = MM_dbConnect_STRING
	RSEmail.Source = "SELECT * FROM email"
	RSEmail.CursorType = 0
	RSEmail.CursorLocation = 2
	RSEmail.LockType = 1
	RSEmail.Open()
	
	RSEmail_numRows = 0
	
	client_ID = RsCust.Fields.Item("client_ID").Value
	Set RSClient = Server.CreateObject("ADODB.Recordset")
	RSClient.ActiveConnection = MM_dbConnect_STRING
	RSClient.Source = "SELECT * FROM client WHERE client_ID = " + Cstr(client_ID) + ""
	RSClient.CursorType = 0
	RSClient.CursorLocation = 2
	RSClient.LockType = 1
	RSClient.Open()
	
	RSClient_numRows = 0

	Set RSAddress = Server.CreateObject("ADODB.Recordset")
	RSAddress.ActiveConnection = MM_dbConnect_STRING
	RSAddress.Source = "SELECT * FROM Address WHERE ID = " + Cstr(Address_id) + ""
	RSAddress.CursorType = 0
	RSAddress.CursorLocation = 2
	RSAddress.LockType = 1
	RSAddress.Open()
	
	RSAddress_numRows = 0
	
	set RsOrderHistory = Server.CreateObject("ADODB.Recordset")
	RsOrderHistory.ActiveConnection = MM_dbConnect_String
	RsOrderHistory.Source = "SELECT * FROM OrderDetails WHERE OrderID = '" + RSOrders__ID +"'"
	RsOrderHistory.CursorType = 0
	RsOrderHistory.CursorLocation = 2
	RsOrderHistory.LockType = 3
	RsOrderHistory.Open()
	RsOrderHistory_numRows = 0

  End If

End Function

Function send_email()
	Delivery = 0
	Set jmail = Server.CreateObject("JMail.Message")
	jmail.Logging = true
	jmail.silent = true


	jmail.HTMLBody = "<HTML>"
	jmail.appendHTML "<HEAD>"
	jmail.appendHTML "<TITLE>Order </TITLE>"
	jmail.appendHTML "</HEAD>"
	jmail.appendHTML "<BODY >"
	jmail.appendHTML "<TABLE cellpadding=""4"" border=1>"
	jmail.appendHTML "<TR><TD> Date: "
	jmail.appendHTML now() & "</td></tr>"
	jmail.appendHTML "<tr><td>"
	jmail.appendHTML "Order Status - " & MM_Status
	jmail.appendHTML "</td></tr>"

	jmail.appendHTML "<tr><td>"
	jmail.appendHTML "Order Client - " & (RSClient.Fields.Item("client").Value) & ", Customer - " & (RsCust.Fields.Item("Cust_Name").Value)
	jmail.appendHTML "</td></tr>"
	jmail.appendHTML "<tr><td>Cost Centre/Purchase Order: " & RSOrders.Fields.Item("purchase_order").Value  & "</td></tr>"
	jmail.appendHTML "<tr><td>Site or Building: " & RSOrders.Fields.Item("building").Value  & "</td></tr>"
	jmail.appendHTML "<tr><td>Employee Name: " & RSOrders.Fields.Item("employee").Value  & "</td></tr>"
	jmail.appendHTML "<tr><td>Instructions:<br>" & RSOrders.Fields.Item("Comment").Value  & "</td></tr>"
    jmail.appendHTML "<TR><TD align=right><table width=100% cellpadding=""2"" border=1>"
	jmail.appendHTML "<TR><TD align=center>Name</td><td>Code</td><td>Customisation</td><td>Custom</td><td>Colour</td><td>size</td><td>Print</td><td>Qty</td><td>Price</td><td>total</td></tr>"

	total_items = 0
	While ((TableRows <> 0 ) AND (NOT RsOrderHistory.EOF))  
		jmail.appendHTML "<tr><td>" & (RsOrderHistory.Fields.Item("Description").Value) & "</td>"
		jmail.appendHTML "<td >" & (RsOrderHistory.Fields.Item("Prod_Code").Value) & "</td>"
		jmail.appendHTML "<td >"
		If RsOrderHistory.Fields.Item("NamePrinted").Value <>"" Then 
			jmail.appendHTML "Name Printed: " & (RsOrderHistory.Fields.Item("NamePrinted").Value)  
		End If  
		If RsOrderHistory.Fields.Item("Custom").Value <>"" Then 
			jmail.appendHTML "Custom: " & (RsOrderHistory.Fields.Item("Custom").Value)
		End If
		jmail.appendHTML "</td>"
		jmail.appendHTML "<td>" & (RsOrderHistory.Fields.Item("Colour").Value)& "</td>"
		jmail.appendHTML "<td>" & (RsOrderHistory.Fields.Item("Sizes").Value)& "</td>"
		jmail.appendHTML "<td>" & (RsOrderHistory.Fields.Item("Quantity").Value)& "</td>"
		jmail.appendHTML "<td><div align='right'>" & FormatCurrency((RsOrderHistory.Fields.Item("PriceInc").Value),2,-2,-2,-2) & "</div></td>"
		RowTotal=0
		RowTotal=(FormatCurrency((RsOrderHistory.Fields.Item("PriceInc").Value)*(RsOrderHistory.Fields.Item("Quantity")),2,-2,-2,-2))
		OrderTotal = OrderTotal+RowTotal
		 
		jmail.appendHTML "<td><div align='right'>"  & RowTotal & "</div></td> </tr>"
	
		TableIndex=TableIndex+1
		TableRows=TableRows-1
		RsOrderHistory.MoveNext() 
	Wend 
	RsOrderHistory.close
    jmail.appendHTML "<tr > <td colspan='4' valign='top'> <div align=right>&nbsp;</div></td> <td colspan='2' valign='right> "
     jmail.appendHTML "<div align='right'>Order Total: </div></td> <td><div align='right'>" & FormatCurrency((OrderTotal),2,-2,-2,-2) & "</div></td></tr></table>"
     jmail.appendHTML " </td></tr></table>"

  	Delivery = RSOrders.Fields.Item("Delivery").Value

	jmail.appendHTML "<TR><td valign=right > " & "Delivery: " & FormatCurrency((Delivery), 2, -2, -2, -2) & "</td></tr>"
	jmail.appendHTML "<TR><td valign=right > " & "Total: " & FormatCurrency(total_items + Delivery, 2, -2, -2, -2) & "</td></tr>"
	jmail.appendHTML "<tr><td>"
	jmail.appendHTML "<table border=""0"" cellpadding=""2"" cellspacing=""0"">"
	  
	jmail.appendHTML "<tr><td align=right>Client_ID</td><td align=left>" & (RsCust.Fields.Item("Client_ID").Value) & "</td></tr>"
	jmail.appendHTML "<tr><td align=right>Cust_Name</td><td align=left>" & (RsCust.Fields.Item("Cust_Name").Value) & "</td></tr>"
	jmail.appendHTML "<tr><td align=right>Account</td><td align=left>" & (RsCust.Fields.Item("Account").Value) & "</td></tr>"
	jmail.appendHTML "<tr><td align=right>Phone</td><td align=left>" & (RsCust.Fields.Item("Phone").Value) & "</td></tr>"
	jmail.appendHTML "<tr><td align=right>Fax</td><td align=left>" & (RsCust.Fields.Item("Fax").Value) & "</td></tr>"
	jmail.appendHTML "<tr><td align=right>Store Address</td><td align=left>" & (RsCust.Fields.Item("Store_Address").Value) & "</td></tr>"
	jmail.appendHTML "<tr><td align=right>Store Suburb</td><td align=left>" & (RsCust.Fields.Item("Store_Suburb").Value) & "</td></tr>"
	jmail.appendHTML "<tr><td align=right>Store State</td><td align=left>" & (RsCust.Fields.Item("Store_State").Value) & "</td></tr>"
	jmail.appendHTML "<tr><td align=right>Store Country</td><td align=left>" & (RsCust.Fields.Item("Store_Country").Value) & "</td></tr>"
	jmail.appendHTML "<tr><td align=right>Store Postcode</td><td align=left>" & (RsCust.Fields.Item("Store_Postcode").Value) & "</td></tr>"
	jmail.appendHTML "<tr><td align=right>Delivery Contact</td><td align=left>" & (RSAddress.Fields.Item("Delivery_Contact").Value) & "</td></tr>"
	jmail.appendHTML "<tr><td align=right>Delivery Address</td><td align=left>" & (RSAddress.Fields.Item("Delivery_Address").Value) & "</td></tr>"
	jmail.appendHTML "<tr><td align=right>Delivery Suburb</td><td align=left>" & (RSAddress.Fields.Item("Delivery_Suburb").Value) & "</td></tr>"
	jmail.appendHTML "<tr><td align=right>Delivery State</td><td align=left>" & (RSAddress.Fields.Item("Delivery_State").Value) & "</td></tr>"
	jmail.appendHTML "<tr><td align=right>Delivery Country</td><td align=left>" & (RSAddress.Fields.Item("Delivery_Country").Value) & "</td></tr>"
	jmail.appendHTML "<tr><td align=right>Delivery Postcode</td><td align=left>" & (RSAddress.Fields.Item("Delivery_Postcode").Value) & "</td></tr>"
	jmail.appendHTML "<tr><td align=right>contact</td><td align=left>" & (RsCust.Fields.Item("contact").Value) & "</td></tr>"
	jmail.appendHTML "<tr><td align=right>email</td><td align=left>" & (RsCust.Fields.Item("email").Value) & "</td></tr>"
                                 

	jmail.appendHTML "</table>"
	jmail.appendHTML "</td></tr>"
	jmail.appendHTML "</table></BODY>"
	jmail.appendHTML "</HTML>"
'	jmail.AddRecipient "mark@splatgraphics.com.au"
	jmail.AddRecipient "mrobinson@josephdahdah.com.au"
	jmail.AddRecipient (RSClient.Fields.Item("email").Value)
	if RSClient.Fields.Item("confirmation").Value then
		jmail.AddRecipient (RsCust.Fields.Item("email").Value)
	end if
	jmail.From = (RSEmail.Fields.Item("email_order").Value)
	jmail.Subject = "Order - " & RSOrders__ID & ", User ID - " &  RsCust__User_ID

                     jmail.MailServerUserName = "JDWeb"
                     jmail.MailServerPassword = "Garment1"
 
	if  jmail.Send("mail.josephdahdah.com.au" ) then ' send email
 		message = "Order generated and sent succesfully!"
	elseif jmail.Send("mail.josephdahdah.com.au" ) then ' try again
 		message = "Order generated and sent second attempt!"
	else
 		message=  "<pre>" & jmail.log & "</pre>"
	end if
	
	'  Response.Redirect(UC_redirectPage)
	
End Function %>


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
<!--#include file="menu_left.asp" -->

<head>
<meta charset="utf-8">
<!-- InstanceBeginEditable name="doctitle" -->
<title>Joseph Dahdah - Uniform Apparel Collection</title>
<!-- InstanceEndEditable -->
<link href="../joseph.css" rel="stylesheet" type="text/css">
<!-- InstanceBeginEditable name="head" -->


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
                            <p><%= message %></p>
  <p align="center">   Update the status of a record</p>
  <p align="center"> 
&nbsp;
<form action="<%=MM_editAction%>" method="get">
<p align="center">Order ID <input name="refnumber" type="text" value="<%= Request.querystring("refnumber") %>"></p>
<p align="center"><input type="submit" name="Submit2" value="Update Order" > </p>   
&nbsp;
</form>
  </p>
<%   If (Request.querystring("refnumber") <> "") Then ' orderID is set to refnumber in the payway fields. %>

  	Order Client - <%= RSClient.Fields.Item("client").Value %> Customer - <%= RsCust.Fields.Item("Cust_Name").Value %> <br />
	Cost Centre/Purchase Order: <%= RSOrders.Fields.Item("purchase_order").Value  %>  <br />
	Site or Building: <%= RSOrders.Fields.Item("building").Value  %> <br />
	Employee Name:  <%= RSOrders.Fields.Item("employee").Value  %> <br />
	Instructions:<br> <%= RSOrders.Fields.Item("Comment").Value  %> <br />
    Delivery:<br> <%= RSOrders.Fields.Item("Delivery").Value  %> <br />

 <% 
 	TableRows = -1
	TableIndex = 0
	RowTotal = 0
	OrderTotal = 0
	total_items = 0

	set RsOrderHistory = Server.CreateObject("ADODB.Recordset")
	RsOrderHistory.ActiveConnection = MM_dbConnect_String
	RsOrderHistory.Source = "SELECT * FROM OrderDetails WHERE OrderID = '" + RSOrders__ID +"'"
 	RsOrderHistory.CursorType = 0
	RsOrderHistory.CursorLocation = 2
	RsOrderHistory.LockType = 3
	RsOrderHistory.Open() %>
   
<table cellspacing="0" cellpadding="2" align="center" class="list">
      <tr> 
        <td >
		Code:
	  </td>
      <td >
	  	Item:
	  </td>
      <td >
	  	Colour:
	  </td>
      <td >
	  	Size:
	  </td>
      <td >
	  	Qty:
	  </td>
      <td >
	  	Price: A$ 
	  </td>
      <td >
		Total A$: 
	  </td>
    </tr>
  	<% While ((TableRows <> 0 ) AND (NOT RsOrderHistory.EOF))%>  
    <tr> 
      <td >
	  	
		<%=(RsOrderHistory.Fields.Item("Prod_Code").Value)%>
		
	  </td>
      <td>
	  	
		<%=(RsOrderHistory.Fields.Item("Description").Value)%>
        <% If RsOrderHistory.Fields.Item("NamePrinted").Value <>"" Then %><br>
        Name Printed: <%=(RsOrderHistory.Fields.Item("NamePrinted").Value)%>
        <% End If %>
        <% If RsOrderHistory.Fields.Item("Custom").Value <>"" Then %><br>
        Custom: <%=(RsOrderHistory.Fields.Item("Custom").Value)%>
        <% End If %>

		
	  </td>
      <td>
	  	
		<%=(RsOrderHistory.Fields.Item("Colour").Value)%>
		
	  </td>
      <td>
	  	
		<%=(RsOrderHistory.Fields.Item("Sizes").Value)%>
		
	  </td>
      <td>
	  	 
        <%=(RsOrderHistory.Fields.Item("Quantity").Value)%>
		
	  </td>
      <td> 
      <div align="right">
		
		<%=FormatCurrency((RsOrderHistory.Fields.Item("PriceInc").Value),2,-2,-2,-2)%>
		
	  </div>
      </td>
      <td> 
      <div align="right">
	    
		<% RowTotal=0
		RowTotal=(FormatCurrency((RsOrderHistory.Fields.Item("PriceInc").Value)*(RsOrderHistory.Fields.Item("Quantity")),2,-2,-2,-2))
		OrderTotal = OrderTotal+RowTotal
		%><%=RowTotal %>
		
	  </div>
      </td>
    </tr>
    <%
	TableIndex=TableIndex+1
	TableRows=TableRows-1
	RsOrderHistory.MoveNext() 
	Wend%>
    <tr > 
      <td colspan="4" valign="top"> 
      <div align="right">&nbsp;</div>
      </td>
      <td colspan="2" valign="right"> 
      <div align="right">
	  	Order Total: 
	  </div>
      </td>
      <td> 
      <div align="right">
	  	
		<%=FormatCurrency((OrderTotal),2,-2,-2,-2)%> 
		
      </div>
      </td>
    </tr>
    </table>
    <%
RSClient.Close()
Set RSClient = Nothing
%>
<%
RSOrders.Close()
Set RSOrders = Nothing
%>
  <% End If %>



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


