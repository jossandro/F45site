<%@LANGUAGE="VBSCRIPT"%> 
<% 'Option Explicit %>
<!--#include file="restrict.asp" -->
<!--#include file="process_order_functions.asp" -->
<!--#include file="./Connections/dbConnect.asp" -->

<% 
Dim online
Dim payment
online = false
payment = false
Dim UC_redirectPage
Dim MM_editAction
Dim MM_abortEdit
Dim MM_editQuery
Dim RsCust
Dim RsCust_numRows
Dim UC_CartColNames
Dim UC_ComputedCols
Dim UCCart1
Dim UCCart1__i
Dim UC_destColName

  Dim RSOrders__MMColParam
  Dim RSOrders
  Dim RSOrders_numRows

	Dim RSEmail
	Dim RSEmail_numRows

	Dim client_ID
	Dim RSClient
	Dim RSClient_numRows

	Dim RSAddress
	Dim RSAddress_numRows

	Dim Delivery

 %>
<%
' *** Set Session Var To Value Of Form Element
' *** MagicBeat Server Behavior - 2007 - by Jag S. Sidhu - www.magicbeat.com
Session("grandtotal") = cStr(Request("totalamount"))

  If (CStr(Request("ordstatus")) = "Cancelled") Then
    UC_redirectPage = "cancelOrder.asp"
  Else
    UC_redirectPage = "final.asp"
  End if
%>

<%
response.expires = -1
' *** Edit Operations: declare variables

'MM_editAction = CStr(Request("URL"))
'MM_editAction = MM_editAction + "?UC_SaveCartToTable=1"
MM_editAction = "disclaimer.asp?UC_SaveCartToTable=1"

' boolean to abort record edit
MM_abortEdit = false

' query string to execute
MM_editQuery = ""
%>

<%
Dim RsCust__MMColParam
RsCust__MMColParam = "1"
Session("svUser") = Session("MM_Username")
if (Session("svUser") <> "") then RsCust__MMColParam = Session("svUser")
%>





<%
	If (Request.Form("refnumber") <> "") Then 
		get_order()  ' will reset the url if they have used the back button and there is a ref in the database
	End If

' *** Insert Record: set variables
	If (CStr(Request("MM_insert")) <> "") Then
		 insert_record()

	End If

	

%>



<%
If (CStr(Request("MM_insert")) <> "") And (CStr(Request("ordstatus")) <> "Cancelled") Then
		get_db_fields()
		If (CStr(Request("ordstatus")) = "Order generated") Then
			send_email()
			save_to_database()		  
	 		RsCust.Close()
	  		RSEmail.Close()
	  		RSClient.Close()
	  		Response.Redirect(UC_redirectPage)
	  		' "<input type='text' name='merchant_id' value='23622780' />" &_

  		ElseIf (CStr(Request("ordstatus")) = "Pending Payment") Then 'online ordering selected
			Dim html
			html = "<html><body><div style='visibility:hidden'><form method='post' action='https://www.payway.com.au/MakePayment' name='wespac'>" &_
			"<input type='text' name='biller_code' value='125922' />" &_
			"<input type='text' name='merchant_id' value='TEST' />" &_
		    "<input type='text' name='payment_reference' value='" & Session("orderid") & "' />" &_
			"<input type='text' name='payment_reference_text' value='Order Id' />" &_
			"<input type='text' name='Client_ID' value='" & (RsCust.Fields.Item("Client_ID").Value) & "'/>" &_
		    "<input type='text' name='information_fields' value='Client_ID' />" &_
			"<input type='text' name='Cust_Name' value='" & (RsCust.Fields.Item("Cust_Name").Value) & "'  />" &_
			"<input type='text' name='information_fields' value='Cust_Name' />"  &_
			"<input type='text' name='Account' value='" & (RsCust.Fields.Item("Account").Value) & "'  />" &_
			"<input type='text' name='information_fields' value='Account' />"  &_
			"<input type='text' name='Phone' value='" & (RsCust.Fields.Item("Phone").Value) & "'  />" &_
			"<input type='text' name='information_fields' value='Phone' />"  &_
			"<input type='text' name='Store_Address' value='" & (RsCust.Fields.Item("Store_Address").Value) & "'  />" &_
			"<input type='text' name='information_fields' value='Store_Address' />"  &_
			"<input type='text' name='Store_Suburb' value='" & (RsCust.Fields.Item("Store_Suburb").Value) & "'  />" &_
			"<input type='text' name='information_fields' value='Store_Suburb' />"  &_
			"<input type='text' name='Store_Country' value='" & (RsCust.Fields.Item("Store_Country").Value) & "'  />" &_
			"<input type='text' name='information_fields' value='Store_Country' />"  &_
			"<input type='text' name='Store_Postcode' value='" & (RsCust.Fields.Item("Store_Postcode").Value) & "'  />" &_
			"<input type='text' name='information_fields' value='Store_Postcode' />"  &_
			"<input type='text' name='Delivery_Contact' value='" & (RSAddress.Fields.Item("Delivery_Contact").Value) & "'  />" &_
			"<input type='text' name='information_fields' value='Delivery_Contact' />"  &_
			"<input type='text' name='Delivery_Address' value='" & (RSAddress.Fields.Item("Delivery_Address").Value) & "'  />" &_
			"<input type='text' name='information_fields' value='Delivery_Address' />"  &_
			"<input type='text' name='Delivery_Suburb' value='" & (RSAddress.Fields.Item("Delivery_Suburb").Value) & "'  />" &_
			"<input type='text' name='information_fields' value='Delivery_Suburb' />"  &_
			"<input type='text' name='Delivery_State' value='" & (RSAddress.Fields.Item("Delivery_State").Value) & "'  />" &_
			"<input type='text' name='information_fields' value='Delivery_State' />"  &_
			"<input type='text' name='email' value='" & (RsCust.Fields.Item("email").Value) & "'  />" &_
			"<input type='text' name='information_fields' value='email' />"  
		
			total_items = 0
			For Each strKeyname in Request.Cookies("splat") 
			 if Request.Cookies("splat")(strKeyname) <> "" then
				cart_string= Request.Cookies("splat")(strKeyname)
				Cart_items=Split(cart_string,"|",-1,0)
				html = html &  "<input type='text' name='" & Cart_items(4) &_
				 " - " & Cart_items(2) &_
				 " - " & Cart_items(5) &_
				 " - " & Cart_items(6) &_
				 " - " & Cart_items(3)
				if Cart_items(8) <> "" then
					html = html &  " - Name: " & Cart_items(8) 
				end if
				html = html &  "' value='" & Cart_items(0) &_
				"," & Cart_items(1)  & "' />"
				price = Cart_items(1)
				qty = Cart_items(0)
				total_items = total_items + (price*qty)
			  end if
			Next 'UCCart1__i 
			If (Request("promo_disc") <> "") Then
				PromotionDiscount = CInt(Request("promo_disc"))
				PromotionDiscount = total_items * (PromotionDiscount/100)
				total_items = total_items - (PromotionDiscount)
				html = html &  "<input type='text' name='Discount' value='1,-" & Cstr(PromotionDiscount) & "' />"
			End If
			Delivery = get_delivery(total_items,Session("postcode"))
			if Delivery > 0 Then
					html = html &  "<input type='text' name='Delivery' value='1," & Delivery & "' />"
			End if
			html = html &  "<input type='text' name='payment_amount' value='" & (total_items + Delivery) & "' />" &_
			"<input type='text' name='payment_amount_text' value='Invoice Amount' />" &_
			"<input type='text' name='Return Link URL' value='www.josephdahdah.com.au/websales/default.asp?payment_reference&payment_status' />" &_
			"<input type='submit' name='button' id='button' value='Submit' />" &_
			 "</form></div><SCRIPT LANGUAGE='JavaScript'>document.wespac.submit(); </SCRIPT></body></html>" 

	save_to_database()		  
	  RsCust.Close()
	  RSEmail.Close()
	  RSClient.Close()
	  response.Write(html)
  		End If

%>
<% 
ElseIf (CStr(Request("ordstatus")) = "Cancelled") Then
	  Response.Redirect(UC_redirectPage)
%>
<% End If %>

<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->

<SCRIPT LANGUAGE="JavaScript">
<!--
function cancelOrder(JForm)
{
	JForm.ordstatus.value="Cancelled";
}

function setstatus_pend(JForm)
{
	JForm.ordstatus.value="Pending Payment";
}

function setstatus_gen(JForm)
{
	JForm.ordstatus.value="Order generated";
}
function check_i_agree()
{
	if (document.form2.ordstatus.value!="Cancelled")
	{
		if (document.form2.iagree.checked!=1)
		{
			alert("Check the box to agree to the terms or cancle the order");
			return false;
		}
//		else{
//			document.form2.ordstatus.value="Pending Payment";
//		}
	}
	else{
	  input_box=confirm("Are you sure you want to Cancel the order Click OK or Cancel to Continue Shopping");
	  if (input_box==true)
	  { 
	  // Output when OK is clicked
		//alert ("You clicked OK"); 
		return true;
	  }
	  
	  else
	  {
	  // Output when Cancel is clicked
		//alert ("You clicked cancel");
		document.form2.ordstatus.value="Pending Payment";
		return false;
	  }
	}
	return true;
}

// -->
</SCRIPT>

<!--#include file="header_menu.asp" -->

<section id="fh5co-product-section" class="section">


    <div class="container">



							<!-- InstanceBeginEditable name="main" -->
<table align="center" width="100%">
<tr><td>
       <p class="heading3"><strong>Terms  and Conditions</strong></p>
          <p>The  use of this website is subject to the following terms of use.<strong> </strong></p>
          <p>Robbie Barsman  has carefully managed  the colours being presented in the images to ensure their accuracy to the true  garment colour. The sometimes substantial variation in colour presentation  between monitors and between flat panel screens can be minimised by adjusting  the contrast and brightness controls using the calibration tools supplied.&nbsp; If  you are unsure about the colour of a garment please contact <a href="mailto:info@robbiebarsman.com.au">info@robbiebarsman.com.au</a></p>
          <p>We  are not liable to you or anyone else for any loss whatsoever that arises in  connection with the use of this website, including, but not limited to, loss  arising either directly or indirectly as a result of interference with or  damage to your computer or your computer systems.</p>
          <p>The  information contained in this website has been prepared in good faith and is  believed to be acccurate and current at the date the information was placed on  the website. However, we may from time to time, change or add to this website  (including these terms of use) or the information, products and services shown  on the website without notice. We are not liable to you or anyone else if  errors occur in any information on this website or if that information is not  up to date and we make no representations or warranties of any kind, express or  implied, as to its completeness or accuracy. These terms do not attempt to  exclude or limit the application of any provision of any statute that would  otherwise be applicable (including the <em>Trade  Practices Act 1974 (Ch)</em>) where to do so would contravene that statute or  cause any part of these terms to be void.</p>
          <p>Any  information provided to Robbie Barsman  via this site will not be  forwarded in any manner whatsoever, to a third party for any purpose, without  the express written permission of the provider.</p>
          </td></tr>
  <tr> 
    <td height="61"> 
      <form name="form2" method="POST" action="<%=MM_editAction%>" onSubmit="return check_i_agree();" > 
	     
		  <p><input name="iagree" type="checkbox" value="1"> 
		  Check if you agree to the  terms above and click Continue, otherwise click on the &quot;Cancel&quot;  button to cancel your order. </p>
        <p align="center"> 
          
<% 
	If RSClient1.Fields.Item("online").Value Then
		If (Session("client_ID") = 73) or (Session("client_ID") = 75)   Then  
			online = true
			payment = false
		Else 
	
		  set RsCust = Server.CreateObject("ADODB.Recordset")
		  RsCust.ActiveConnection = MM_dbConnect_String
		  RsCust.Source = "SELECT * FROM customers WHERE userid = '" + Session("MM_Username") + "'"
		  RsCust.CursorType = 0
		  RsCust.CursorLocation = 2
		  RsCust.LockType = 3
		  RsCust.Open()
		  RsCust_numRows = 0
		  Session("MM_Username")
		  If RsCust.Fields.Item("online").Value Then
			online = true
		  End If
		  If RsCust.Fields.Item("payment").Value Then
			payment = true
		  End If
		  
		  RsCust.Close()
		  Set RsCust = Nothing
	    End If 
    End If
	 Dim ordstatus_value 
	 ordstatus_value = "Payment Required"
	If online Then  %> 
		<input type="submit" name="submit1" value="Continue -  Pay by Credit Card"  onClick="setstatus_pend(this.form)">   <% 
		If payment Then  %> 
			<input type="submit" name="submit1" value="Continue -  Generate Order " onClick="setstatus_gen(this.form)"> 	<% 
		End If 
	Else %>  
		<input type="submit" name="submit" value="Continue -  Generate Order"  onClick="setstatus_gen(this.form)">    <% 
	End If 		%>
		<input type="hidden" name="user" value="<%= Session("svuser") %>">
		<input type="hidden" name="refnumber" value="<%= Session("orderid") %>">
		<input type="hidden" name="MM_insert" value="true">
		<input type="hidden" name="ordstatus" value="<%= ordstatus_value %>">
		<input type="hidden" name="purchase_order" value="<%= CStr(Request("purchase_order")) %>">
		<input type="hidden" name="building" value="<%= CStr(Request("building")) %>">
		<input type="hidden" name="employee" value="<%= CStr(Request("employee")) %>">
		<input type="hidden" name="Comment" value="<%= CStr(Request("Comment")) %>">
		<input type="hidden" name="Address" value="<%= Request("Address") %>">
		<input type="hidden" name="Total" value="<%= Request("Total") %>">
		<input type="hidden" name="Delivery" value="<%= Request("Delivery") %>">
		<input type="hidden" name="promo_disc" value="<%= Request("promo_disc") %>" />
		<input type="submit" name="cancel" value="Cancel" onClick="cancelOrder(this.form)">
		<input type="hidden" name="Pickup" value="<%= Request("Pickup") %>" />
	  </form>
      <div align="center">
	To the terms of use listed above.</div>
    </td>
  </tr>
</table>
<!-- InstanceEndEditable -->
	 
	<div class="container">
        <div class="row">
            <div class="col-md-3">
                <div class="row">
                </div>
            </div>
            <div class="col-md-9">
                <div class="row">
                    <div class="products col-md-3 col-sm-3 col-xs-12 animate-box">
                    </div>
                </div>
            </div>
        </div>
    </div>

</section><!-- end fh5co-intro-section -->


<!--#include file="footer.asp" -->

<!-- jQuery -->
<script src="js/jquery.min.js"></script>
<!-- jQuery Easing -->
<script src="js/jquery.easing.1.3.js"></script>
<!-- Bootstrap -->
<script src="js/bootstrap.min.js"></script>
<!-- Toaster: Notifications -->
<script src="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/js/toastr.min.js"></script>
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
'RSCat.Close()
'Set RSCat = Nothing
%>
<%
'RSClient1.Close()
'Set RSClient1 = Nothing
%>



