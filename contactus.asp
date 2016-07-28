<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="restrict.asp" -->

<!--#include file="../Connections/dbConnect.asp" -->


<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->

<!--#include file="header_menu.asp" -->

<section id="fh5co-product-section" class="section">
  
    <div class="container">

        <h3>Contact Us</h3>
        <form role="form" method="POST">
            <fieldset class="form-group  col-md-6 col-sm-6 col-xs-12">
                <label for="contact_name">Name</label>
                <input type="text" class="form-control" name="contact_name" id="contact_name" placeholder="Your Name">
            </fieldset>
            <fieldset class="form-group  col-md-6 col-sm-6 col-xs-12">
                <label for="email">Email</label>
                <input type="email" class="form-control" name="email" id="email" placeholder="Your Email" required>
            </fieldset>
            <fieldset class="form-group  col-md-6 col-sm-6 col-xs-12">
                <label for="phone">Phone</label>
                <input type="text" class="form-control" name="phone" id="phone" placeholder="Your Phone">
            </fieldset>
            <fieldset class="form-group  col-md-6 col-sm-6 col-xs-12">
                <label for="subject">Subject</label>
                <input type="text" class="form-control" name="subject" id="subject" placeholder="Contact Subject">
            </fieldset>
            <fieldset class="form-group  col-md-12 col-sm-12 col-xs-12">
                <label for="subject">Message</label>
                <textarea class="form-control" name="message" id="message" rows="3" required></textarea>
            </fieldset>
            <fieldset class="form-group  col-md-12 col-sm-12 col-xs-12">
                <button type="submit" class="btn btn-filters">Submit</button>
            </fieldset>
        </form>

    </div>
    <%
    if len(Request.form("email")) > 3 then
        send_contact_email()
        %><div> Email Sent </div><%
    end if

    %>
    
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

Function send_contact_email()
    
    Dim content

    Set myMail = CreateObject("CDO.Message")
    myMail.Subject = "Contact from F45 website"
    myMail.From = "joe@returnonclick.com.au"
    myMail.To = "joe@returnonclick.com.au"

    content = "<h1>Contact from your website.</h1>"
    content = content & "<p>Name: "& CStr(Request("contact_name")) &"</p>"
    content = content & "<p>Email: "& CStr(Request("email")) &"</p>"
    content = content & "<p>Phone: "& CStr(Request("phone")) &"</p>"
    content = content & "<p>Subject: "& CStr(Request("subject")) &"</p>"
    content = content & "<p>Message: "& CStr(Request("message")) &"</p>"


    myMail.HTMLBody = content


    myMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
    myMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "smtp.gmail.com"
    myMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1
    myMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 465 
    myMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = true
    myMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = "joe@returnonclick.com.au"
    myMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") = "PASSWORD HERE"
    myMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 60 
    myMail.Configuration.Fields.Update 


    myMail.Send
    set myMail = nothing

end function


Function send_contact_email_jmail()
    Delivery = 0
    Set jmail = Server.CreateObject("JMail.Message")
    
    
    jmail.Logging = true
    jmail.silent = true


    jmail.HTMLBody = "<html>"
    jmail.appendHTML "<head>"
    jmail.appendHTML "<title>Order </title>"
    jmail.appendHTML "</head>"
    jmail.appendHTML "<body >"
    jmail.appendHTML "<table cellpadding=""4"" border=1>"
    jmail.appendHTML "<tr><td> Date: "
    jmail.appendHTML now() & "</td></tr>"
    jmail.appendHTML "<tr><td>"
    jmail.appendHTML "Order Status - " & CStr(Request("ordstatus"))
    jmail.appendHTML "</td></tr>"

    jmail.appendHTML "<tr><td>"
    jmail.appendHTML "Order Client - JOECLIENT, Customer - JOECUSTOMER"
    jmail.appendHTML "</td></tr>"
    jmail.appendHTML "<tr><td>Cost Centre/Purchase Order: " & Request.Form("purchase_order") & "</td></tr>"
    jmail.appendHTML "<tr><td>Site or Building: " & Request.Form("building") & "</td></tr>"
    jmail.appendHTML "<tr><td>Employee Name: " & Request.Form("employee") & "</td></tr>"
    jmail.appendHTML "<tr><td>Instructions:<br>" & Request.Form("Comment") & "</td></tr>"
    jmail.appendHTML "<tr><td align=right><table width=100% cellpadding=""2"" border=1>"
    jmail.appendHTML "<tr><td align=center>Name</td><td>Code</td><td>Customisation</td><td>Colour</td><td>Size</td><td>Print</td><td>Qty</td><td>Price</td><td>Total</td></tr>"

  
    jmail.appendHTML "</table>"
    jmail.appendHTML "</td></tr>"
    
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
    jmail.AddRecipient "joe@returnonclick.com.au"
'   jmail.AddRecipient "mark@splatgraphics.com.au"

'  If NOT RSCustomerEmail.EOF  Then  ' code to handle mulitple emails.
'       My_Array=split(RSCustomerEmail.Fields.Item("Email").Value,",")
'       For Each item In My_Array
'           jmail.AddRecipient (item)
'       Next       
        
'  Else  ' code to handle mulitple emails.
'       My_Array=split(RSClient.Fields.Item("email").Value,",")
'       For Each item In My_Array
'           jmail.AddRecipient (item)
'       Next       
'  End If 
    
    
    jmail.From = "joe@returnonclick.com.au"
    jmail.Subject = "Testing email  "

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
    response.write(message)
    'UC_redirectPage = UC_redirectPage + "?message=" + Server.URLEncode(message)
    
End Function %>