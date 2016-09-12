<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="restrict.asp" -->

<!--#include file="./Connections/dbConnect.asp" -->
<%

If Not MM_grantAccess Then
  MM_qsChar = "?"
  If (InStr(1,MM_authFailedURL,"?") >= 1) Then MM_qsChar = "&"
  MM_referrer = Request.ServerVariables("URL")
  if (Len(Request.QueryString()) > 0) Then MM_referrer = MM_referrer & "?" & Request.QueryString()
  MM_authFailedURL = MM_authFailedURL & MM_qsChar & "accessdenied=" & Server.URLEncode(MM_referrer)
  Response.Redirect(MM_authFailedURL)
End If



Dim MM_editAction
MM_editAction = CStr(Request.ServerVariables("SCRIPT_NAME"))
If (Request.QueryString <> "") Then
  MM_editAction = MM_editAction & "?" & Server.HTMLEncode(Request.QueryString)
End If

' boolean to abort record edit
Dim MM_abortEdit
MM_abortEdit = false
%>
<%
' IIf implementation
Function MM_IIf(condition, ifTrue, ifFalse)
  If condition = "" Then
    MM_IIf = ifFalse
  Else
    MM_IIf = ifTrue
  End If
End Function
%>
<%
    Dim MM_editCmd
    Dim MM_editRedirectUrl
If (CStr(Request("MM_update")) = "UpdateCustomer") Then
  If (Not MM_abortEdit) Then
    ' execute the update

    Set MM_editCmd = Server.CreateObject ("ADODB.Command")
    MM_editCmd.ActiveConnection = MM_dbConnect_STRING
    MM_editCmd.CommandText = "UPDATE Customers SET Cust_Name = ?, Account = ?, Phone = ?, Fax = ?, Store_Address = ?, Store_Suburb = ?, Store_State = ?, Store_Country = ?, Store_Postcode = ?, contact = ?, email = ?, passwd = ? WHERE userid = ?" 
    MM_editCmd.Prepared = true
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 202, 1, 255, Request.Form("Cust_Name")) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param2", 202, 1, 50, Request.Form("Account")) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param3", 202, 1, 255, Request.Form("Phone")) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param4", 202, 1, 255, Request.Form("Fax")) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param5", 202, 1, 255, Request.Form("Store_Address")) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param6", 202, 1, 255, Request.Form("Store_Suburb")) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param7", 202, 1, 255, Request.Form("Store_State")) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param8", 202, 1, 255, Request.Form("Store_Country")) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param9", 202, 1, 255, Request.Form("Store_Postcode")) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param10", 202, 1, 255, Request.Form("contact")) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param11", 202, 1, 255, Request.Form("email")) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param12", 202, 1, 50, Request.Form("passwd")) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param13", 200, 1, 50, Request.Form("MM_recordId")) ' adVarChar
    MM_editCmd.Execute
    MM_editCmd.ActiveConnection.Close

    ' append the query string to the redirect URL
    MM_editRedirectUrl = "updatecustomerinfo.asp"
    If (Request.QueryString <> "") Then
      If (InStr(1, MM_editRedirectUrl, "?", vbTextCompare) = 0) Then
        MM_editRedirectUrl = MM_editRedirectUrl & "?" & Request.QueryString
      Else
        MM_editRedirectUrl = MM_editRedirectUrl & "&" & Request.QueryString
      End If
    End If
    Response.Redirect(MM_editRedirectUrl)
  End If
End If
%>
<%
If (CStr(Request("MM_update")) = "UpdateAddress") Then
  If (Not MM_abortEdit) Then
    ' execute the update

    Set MM_editCmd = Server.CreateObject ("ADODB.Command")
    MM_editCmd.ActiveConnection = MM_dbConnect_STRING
    MM_editCmd.CommandText = "UPDATE Address SET Delivery_Contact = ?, Delivery_Address = ?, Delivery_Suburb = ?, Delivery_State = ?, Delivery_Country = ?, Delivery_Postcode = ?, Delivery_Name = ?, Delivery_Phone = ?, Customer_ID = ? WHERE ID = ?" 
    MM_editCmd.Prepared = true
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 202, 1, 255, Request.Form("Delivery_Contact")) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param2", 202, 1, 255, Request.Form("Delivery_Address")) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param3", 202, 1, 255, Request.Form("Delivery_Suburb")) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param4", 202, 1, 255, Request.Form("Delivery_State")) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param5", 202, 1, 255, Request.Form("Delivery_Country")) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param6", 202, 1, 255, Request.Form("Delivery_Postcode")) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param7", 202, 1, 255, Request.Form("Delivery_Name")) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param8", 202, 1, 255, Request.Form("Delivery_Phone")) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param9", 5, 1, -1, MM_IIF(Request.Form("Customer_ID"), Request.Form("Customer_ID"), null)) ' adDouble
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param10", 5, 1, -1, MM_IIF(Request.Form("MM_recordId"), Request.Form("MM_recordId"), null)) ' adDouble
    MM_editCmd.Execute
    MM_editCmd.ActiveConnection.Close

    ' append the query string to the redirect URL
    MM_editRedirectUrl = "updatecustomerinfo.asp"
    If (Request.QueryString <> "") Then
      If (InStr(1, MM_editRedirectUrl, "?", vbTextCompare) = 0) Then
        MM_editRedirectUrl = MM_editRedirectUrl & "?" & Request.QueryString
      Else
        MM_editRedirectUrl = MM_editRedirectUrl & "&" & Request.QueryString
      End If
    End If
    Response.Redirect(MM_editRedirectUrl)
  End If
End If
%>

<%
If (CStr(Request("MM_insert")) = "NewAddress") Then
  If (Not MM_abortEdit) Then
    ' execute the insert
    insert_new_address(1)
  End If
End If
%>
<%
Dim RSCustomer__MMColParam
RSCustomer__MMColParam = "1"
If (Session("MM_Username") <> "") Then 
  RSCustomer__MMColParam = Session("MM_Username")
End If
%>
<%
Dim RSCustomer
Dim RSCustomer_cmd
Dim RSCustomer_numRows

Set RSCustomer_cmd = Server.CreateObject ("ADODB.Command")
RSCustomer_cmd.ActiveConnection = MM_dbConnect_STRING
RSCustomer_cmd.CommandText = "SELECT  * FROM customer_address WHERE userid = ?" 
RSCustomer_cmd.Prepared = true
RSCustomer_cmd.Parameters.Append RSCustomer_cmd.CreateParameter("param1", 200, 1, 50, RSCustomer__MMColParam) ' adVarChar

Set RSCustomer = RSCustomer_cmd.Execute
RSCustomer_numRows = 0
%>
<%
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = -1
Repeat1__index = 0
RSCustomer_numRows = RSCustomer_numRows + Repeat1__numRows
%>
<%
If ( RSCustomer.EOF) Then
  Dim RSCustomer1
  Dim RSCustomer1_cmd
  Dim RSCustomer1_numRows
  
  Set RSCustomer1_cmd = Server.CreateObject ("ADODB.Command")
  RSCustomer1_cmd.ActiveConnection = MM_dbConnect_STRING
  RSCustomer1_cmd.CommandText = "SELECT * FROM customers WHERE userid = ?" 
  RSCustomer1_cmd.Prepared = true
  RSCustomer1_cmd.Parameters.Append RSCustomer1_cmd.CreateParameter("param1", 200, 1, 50, RSCustomer__MMColParam) ' adVarChar
  
  Set RSCustomer1 = RSCustomer1_cmd.Execute
  
  Delivery_Contact = RSCustomer1.Fields.Item("Contact").Value
  Delivery_Address = RSCustomer1.Fields.Item("Delivery_Address").Value
  Delivery_Suburb = RSCustomer1.Fields.Item("Delivery_Suburb").Value
  Delivery_State = RSCustomer1.Fields.Item("Delivery_State").Value
  Delivery_Country = RSCustomer1.Fields.Item("Delivery_Country").Value
  Delivery_Postcode = RSCustomer1.Fields.Item("Delivery_Postcode").Value
  Customer_ID = RSCustomer1.Fields.Item("ID").Value
  RSCustomer1_numRows = 0
    insert_new_address(0)
end if
%>
<%
function insert_new_address(get_form)
    Set MM_editCmd = Server.CreateObject ("ADODB.Command")
    MM_editCmd.ActiveConnection = MM_dbConnect_STRING
    MM_editCmd.CommandText = "INSERT INTO Address (Delivery_Contact,Delivery_Address, Delivery_Suburb, Delivery_State, Delivery_Country, Delivery_Postcode,Customer_ID) VALUES (?, ?, ?, ?, ?, ?, ?)" 
    MM_editCmd.Prepared = true
    if(get_form) Then
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 202, 1, 255, Request.Form("Delivery_Contact")) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param2", 202, 1, 255, Request.Form("Delivery_Address")) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param3", 202, 1, 255, Request.Form("Delivery_Suburb")) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param4", 202, 1, 255, Request.Form("Delivery_State")) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param5", 202, 1, 255, Request.Form("Delivery_Country")) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param6", 202, 1, 255, Request.Form("Delivery_Postcode")) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param7", 202, 1, 255, Request.Form("Customer_ID")) ' adVarWChar
    else
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 202, 1, 255, Delivery_Contact) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param2", 202, 1, 255, Delivery_Address) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param3", 202, 1, 255, Delivery_Suburb) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param4", 202, 1, 255, Delivery_State) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param5", 202, 1, 255, Delivery_Country) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param6", 202, 1, 255, Delivery_Postcode) ' adVarWChar
    MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param7", 202, 1, 255, Customer_ID) ' adVarWChar
    end if  
    MM_editCmd.Execute
    MM_editCmd.ActiveConnection.Close

    ' append the query string to the redirect URL
    MM_editRedirectUrl = "updatecustomerinfo.asp"
    If (Request.QueryString <> "") Then
      If (InStr(1, MM_editRedirectUrl, "?", vbTextCompare) = 0) Then
        MM_editRedirectUrl = MM_editRedirectUrl & "?" & Request.QueryString
      Else
        MM_editRedirectUrl = MM_editRedirectUrl & "&" & Request.QueryString
      End If
    End If
    Response.Redirect(MM_editRedirectUrl)
end function
%>

<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->

<!--#include file="header_menu.asp" -->

<section id="fh5co-product-section" class="section">

   <!--  <div class="container">
        <div class="row">
            <div class="col-md-6">
                <h6>MEN /</h6>
            </div>
            <div class="col-md-6">
                <h6>808 ITENS</h6>
            </div>
        </div>
    </div>
    <div class="container" style="padding: 0">
        <div class="divider" style="margin: 0 0 5rem 0"></div>
    </div> -->
    <div class="container">

        <h3>Update Your Profile</h3>

        <form ACTION="<%=MM_editAction%>" method="POST" name="UpdateCustomer">
            <fieldset class="form-group  col-md-12 col-sm-12 col-xs-12">
                <label for="Cust_Name">Customer Name</label>
                <input type="text" class="form-control" name="Cust_Name" id="Cust_Name" value='<%=(RSCustomer.Fields.Item("Cust_Name").Value)%>' placeholder="Customer Name">
                <!-- <small class="text-muted">We'll never share your email with anyone else.</small> -->
            </fieldset>
            <fieldset class="form-group col-md-6 col-sm-6 col-xs-12">
                <label for="Account">Account / Client ID</label>
                <input type="text" class="form-control" id="Account" placeholder="Account / Client ID" name="Account" value="<%=(RSCustomer.Fields.Item("Account").Value)%>" >
            </fieldset>
            <fieldset class="form-group col-md-6 col-sm-6 col-xs-12">
                <label for="Phone">Phone</label>
                <input type="text" class="form-control" id="Phone" placeholder="Phone" name="Phone" value="<%=(RSCustomer.Fields.Item("Phone").Value)%>">
            </fieldset>
            <fieldset class="form-group col-md-6 col-sm-6 col-xs-12">
                <label for="Fax">Fax</label>
                <input type="text" class="form-control" id="Fax" placeholder="Fax" name="Fax" value="<%=(RSCustomer.Fields.Item("Fax").Value)%>">
            </fieldset>
            <fieldset class="form-group col-md-6 col-sm-6 col-xs-12">
                <label for="Store_Address">Store Address</label>
                <input type="text" class="form-control" id="Store_Address" placeholder="Store Address" name="Store_Address" value="<%=(RSCustomer.Fields.Item("Store_Address").Value)%>">
            </fieldset>
            <fieldset class="form-group col-md-6 col-sm-6 col-xs-12">
                <label for="Store_Suburb">Store Suburb</label>
                <input type="text" class="form-control" id="Store_Suburb" placeholder="Store Suburb" name="Store_Suburb" value="<%=(RSCustomer.Fields.Item("Store_Suburb").Value)%>">
            </fieldset>
            <fieldset class="form-group col-md-6 col-sm-6 col-xs-12">
                <label for="Store_State">Store State</label>
                <input type="text" class="form-control" id="Store_State" placeholder="Store State" name="Store_State" value="<%=(RSCustomer.Fields.Item("Store_State").Value)%>">
            </fieldset>
            <fieldset class="form-group col-md-6 col-sm-6 col-xs-12">
                <label for="Store_Country">Store Country</label>
                <input type="text" class="form-control" id="Store_Country" placeholder="Store Country" name="Store_Country" value="<%=(RSCustomer.Fields.Item("Store_Country").Value)%>">
            </fieldset>
            <fieldset class="form-group col-md-6 col-sm-6 col-xs-12">
                <label for="Store_Postcode">Store Postcode</label>
                <input type="text" class="form-control" id="Store_Postcode" placeholder="Store Postcode" name="Store_Postcode" value="<%=(RSCustomer.Fields.Item("Store_Postcode").Value)%>" >
            </fieldset>
            <fieldset class="form-group col-md-6 col-sm-6 col-xs-12">
                <label for="contact">Contact</label>
                <input type="text" class="form-control" id="contact" placeholder="Contact Person" name="contact" value="<%=(RSCustomer.Fields.Item("contact").Value)%>" >
            </fieldset>
            <fieldset class="form-group col-md-6 col-sm-6 col-xs-12"">
                <label for="email">Email address</label>
                <input type="email" class="form-control" id="email" placeholder="Enter email" name="email" value="<%=(RSCustomer.Fields.Item("email").Value)%>" >
            </fieldset>
            <fieldset class="form-group col-md-6 col-sm-6 col-xs-12">
                <label for="User">User</label>
                <input type="text" class="form-control" id="User" value="<%=(RSCustomer.Fields.Item("userid").Value)%>" readonly>
            </fieldset>
            <fieldset class="form-group col-md-6 col-sm-6 col-xs-12"">
                <label for="passwd">Password</label>
                <input type="password" class="form-control" id="passwd" placeholder="Password" name="passwd" value="<%=(RSCustomer.Fields.Item("passwd").Value)%>" >
            </fieldset>
            <fieldset class="form-group col-md-12 col-sm-12 col-xs-12  text-center" >
                <!-- <label for="send"></label> -->
                <input id="send" name="send" type="submit" class="btn btn-filters" value="Update record" />
            </fieldset>

            <input type="hidden" name="MM_update" value="UpdateCustomer">
            <input type="hidden" name="MM_recordId" value="<%= RSCustomer.Fields.Item("userid").Value %>">
        </form>
    </div>
    <div class="container" style="padding: 0">
        <div class="divider" style="margin: 0 0 5rem 0"></div>
    </div>
    <div class="container ">
          
        <!-- =================== FORM ADDRESS ===========================-->        <% 
        Dim customer_ID 
        customer_ID = RSCustomer.Fields.Item("Customer_ID").Value
        While ((Repeat1__numRows <> 0) AND (NOT RSCustomer.EOF))             %>
      

            <form ACTION="<%=MM_editAction%>" method="POST" name="UpdateAddress" >
                <fieldset class="form-group col-md-6 col-sm-6 col-xs-12">
                    <label for="Delivery_Name">Delivery Name</label>
                    <input type="text" class="form-control" id="Delivery_Name" placeholder="Delivery Name" name="Delivery_Name" value="<%=(RSCustomer.Fields.Item("Delivery_Name").Value)%>" >
                </fieldset>
                <fieldset class="form-group col-md-6 col-sm-6 col-xs-12">
                    <label for="Delivery_Contact">Delivery Contact</label>
                    <input type="text" class="form-control" id="Delivery_Contact" placeholder="Delivery Contact" name="Delivery_Contact" value="<%=(RSCustomer.Fields.Item("Delivery_Contact").Value)%>" >
                </fieldset>
                <fieldset class="form-group col-md-6 col-sm-6 col-xs-12">
                    <label for="Delivery_Address">Delivery Address</label>
                    <input type="text" class="form-control" id="Delivery_Address" placeholder="Delivery Address" name="Delivery_Address" value="<%=(RSCustomer.Fields.Item("Delivery_Address").Value)%>" >
                </fieldset>
                <fieldset class="form-group col-md-6 col-sm-6 col-xs-12">
                    <label for="Delivery_Suburb">Delivery Suburb</label>
                    <input type="text" class="form-control" id="Delivery_Suburb" placeholder="Delivery Suburb" name="Delivery_Suburb" value="<%=(RSCustomer.Fields.Item("Delivery_Suburb").Value)%>" >
                </fieldset>
                <fieldset class="form-group col-md-6 col-sm-6 col-xs-12">
                    <label for="Delivery_State">Delivery State</label>
                    <input type="text" class="form-control" id="Delivery_State" placeholder="Delivery State" name="Delivery_State" value="<%=(RSCustomer.Fields.Item("Delivery_State").Value)%>" >
                </fieldset>
                <fieldset class="form-group col-md-6 col-sm-6 col-xs-12">
                    <label for="Delivery_Country">Delivery Country</label>
                    <input type="text" class="form-control" id="Delivery_Country" placeholder="Delivery Country" name="Delivery_Country" value="<%=(RSCustomer.Fields.Item("Delivery_Country").Value)%>" >
                </fieldset>
                <fieldset class="form-group col-md-6 col-sm-6 col-xs-12">
                    <label for="Delivery_Postcode">Delivery Postcode</label>
                    <input type="text" class="form-control" id="Delivery_Postcode" placeholder="Delivery Postcode" name="Delivery_Postcode" value="<%=(RSCustomer.Fields.Item("Delivery_Postcode").Value)%>" >
                </fieldset>
                <fieldset class="form-group col-md-6 col-sm-6 col-xs-12">
                    <label for="Delivery_Phone">Delivery Phone</label>
                    <input type="text" class="form-control" id="Delivery_Phone" placeholder="Delivery Phone" name="Delivery_Phone" value="<%=(RSCustomer.Fields.Item("Delivery_Phone").Value)%>" >
                </fieldset>
                <fieldset class="form-group col-md-12 col-sm-12 col-xs-12  text-center" >
                    <input id="send" name="send" type="submit" class="btn btn-filters" value="Update Address" />
                </fieldset>

                <input type="hidden" name="MM_update" value="UpdateAddress">
                <input type="hidden" name="Customer_ID" value="<%= customer_ID %>">
                <input type="hidden" name="MM_recordId" value="<%= RSCustomer.Fields.Item("Address_ID").Value %>">
            </form>         <% 
            Repeat1__index=Repeat1__index+1
            Repeat1__numRows=Repeat1__numRows-1
            RSCustomer.MoveNext()
        Wend        %>
    </div>
    <div class="container" style="padding: 0">
        <div class="divider" style="margin: 0 0 5rem 0"></div>
    </div>
    <div class="container ">
        <form name="form1" ACTION="<%=MM_editAction%>" method="POST" >
            <fieldset class="form-group col-md-6 col-sm-6 col-xs-12">
                <label for="Delivery_Name">Delivery Name</label>
                <input type="text" class="form-control" id="Delivery_Name" placeholder="Delivery Name" name="Delivery_Name" value="" >
                <!-- <input type="text" class="form-control" id="Delivery_Contact" placeholder="Delivery Contact" name="Delivery_Contact" value="" > -->
            </fieldset>
            <fieldset class="form-group col-md-6 col-sm-6 col-xs-12">
                <label for="Delivery_Address">Delivery Address</label>
                <input type="text" class="form-control" id="Delivery_Address" placeholder="Delivery Address" name="Delivery_Address" value="" >
            </fieldset>
            <fieldset class="form-group col-md-6 col-sm-6 col-xs-12">
                <label for="Delivery_Suburb">Delivery Suburb</label>
                <input type="text" class="form-control" id="Delivery_Suburb" placeholder="Delivery Suburb" name="Delivery_Suburb" value="" >
            </fieldset>
            <fieldset class="form-group col-md-6 col-sm-6 col-xs-12">
                <label for="Delivery_State">Delivery State</label>
                <input type="text" class="form-control" id="Delivery_State" placeholder="Delivery State" name="Delivery_State" value="" >
            </fieldset>
            <fieldset class="form-group col-md-6 col-sm-6 col-xs-12">
                <label for="Delivery_Country">Delivery Country</label>
                <input type="text" class="form-control" id="Delivery_Country" placeholder="Delivery Country" name="Delivery_Country" value="" >
            </fieldset>
            <fieldset class="form-group col-md-6 col-sm-6 col-xs-12">
                <label for="Delivery_Postcode">Delivery Postcode</label>
                <input type="text" class="form-control" id="Delivery_Postcode" placeholder="Delivery Postcode" name="Delivery_Postcode" value="" >
            </fieldset>
            <fieldset class="form-group col-md-12 col-sm-12 col-xs-12 text-center">
                <input id="send" type="submit" class="btn btn-filters" value="New Address" />
            </fieldset>
            <input type="hidden" name="Customer_ID" value="<%= customer_ID %>">
            <input type="hidden" name="MM_insert" value="NewAddress">
        </form>
    </div>
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