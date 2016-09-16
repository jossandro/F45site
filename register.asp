<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="./Connections/dbConnect.asp" -->

<% 
  Dim HTML
  HTML = ""
  Message = ""
  FormErrors = ""
%>

<%
  ' check if the user id already exists
  Dim RSCustomer__MMColParam
  RSCustomer__MMColParam = "1"
  If (Request.Form("userid") <> "") Then 
    RSCustomer__MMColParam = Request.Form("userid")
    Message = "Please enter an unique user id and password <br>"
  End If
%>

<%
  lblResult = ""
  lblColor = ""
  sCust_Name = ""
  snew_account =  ""
  sAccount =  ""
  sPhone =  ""
  sFax =  ""
  sStore_Address =  ""
  sStore_Suburb =  ""
  sStore_State =  ""
  sStore_Country =  ""
  sStore_Postcode =  ""
  sDelivery_Address =  ""
  sDelivery_Suburb =  ""
  sDelivery_State =  ""
  sDelivery_Country =  ""
  sDelivery_Postcode =  ""
  scontact =  ""
  semail =  ""
  suserid =  ""
  spasswd =  ""
  spasswd1 =  ""
  stxtCaptcha =  ""
       
  If (CStr(Request("MM_insert")) = "form1") Then
   
       sCust_Name =  Request.Form("Cust_Name")
       snew_account =  Request.Form("new_Account")
       sAccount =  Request.Form("Account")
       sPhone =  Request.Form("Phone")
       sFax =  Request.Form("Fax")
       sStore_Address =  Request.Form("Store_Address")
       sStore_Suburb =  Request.Form("Store_Suburb")
       sStore_State =  Request.Form("Store_State")
       sStore_Country =  Request.Form("Store_Country")
       sStore_Postcode =  Request.Form("Store_Postcode")
       sDelivery_Address =  Request.Form("Delivery_Address")
       sDelivery_Suburb =  Request.Form("Delivery_Suburb")
       sDelivery_State =  Request.Form("Delivery_State")
       sDelivery_Country =  Request.Form("Delivery_Country")
       sDelivery_Postcode =  Request.Form("Delivery_Postcode")
       scontact =  Request.Form("contact")
       semail =  Request.Form("email")
       suserid =  Request.Form("userid")
       spasswd =  Request.Form("passwd")
       spasswd1 =  Request.Form("passwd1")
       stxtCaptcha =  Request.Form("txtCaptcha")
       
      'Check for CAPTCHA
      if IsEmpty(Session("ASPCAPTCHA")) or Trim(Session("ASPCAPTCHA")) = "" then
          lblResult = "CAPTCHA test has expired."
          lblColor = "red"
      else
          Dim TestValue : TestValue = Trim(Request.Form("txtCaptcha"))
          '//Uppercase fix for turkish charset//
          TestValue = Replace(TestValue, "i", "I", 1, -1, 1)
          TestValue = Replace(TestValue, "I", "I", 1, -1, 1)
          TestValue = Replace(TestValue, "i", "I", 1, -1, 1)
          '////////////////////
          TestValue = UCase(TestValue)
          
          if StrComp(TestValue, Trim(Session("ASPCAPTCHA")), 1) = 0 then
              lblResult = ""
              lblColor = ""
          else
              lblResult = "CAPTCHA entered incorrectly"
              lblColor = "red"
          end if

          '//IMPORTANT: You must remove session value for security after the CAPTCHA test//
          Session("ASPCAPTCHA") = vbNullString
          Session.Contents.Remove("ASPCAPTCHA")
          '////////////////////
      end if
      
      if (lblResult <> "") then 
         FormErrors  = FormErrors & lblResult & "<br>"
      end if
  end if
%>


<% 
  Dim RSEmail
  Dim RSEmail_numRows
  Set RSEmail = Server.CreateObject("ADODB.Recordset")
  RSEmail.ActiveConnection = MM_dbConnect_STRING
  RSEmail.Source = "SELECT * FROM email"
  RSEmail.CursorType = 0
  RSEmail.CursorLocation = 2
  RSEmail.LockType = 1
  RSEmail.Open()
  RSEmail_numRows = 0
%>

<% 
  Dim RSGet_client
  Set RSGet_client = Server.CreateObject("ADODB.Recordset")
  RSGet_client.ActiveConnection = MM_dbConnect_STRING
  RSGet_client.Source = "SELECT * FROM client "
  RSGet_client.CursorType = 0
  RSGet_client.CursorLocation = 2
  RSGet_client.LockType = 1
  RSGet_client.Open()

  Dim Repeat1__numRows
  Dim Repeat1__index

  Repeat1__numRows = -1
  Repeat1__index = 0
  RSGet_client_numRows = RSGet_client_numRows + Repeat1__numRows
%>

<%
  Dim RSCustomer
  Dim RSCustomer_numRows

  Set RSCustomer = Server.CreateObject("ADODB.Recordset")
  RSCustomer.ActiveConnection = MM_dbConnect_STRING
  RSCustomer.Source = "SELECT * FROM Customers WHERE userid = '" + Replace(RSCustomer__MMColParam, "'", "''") + "'"
  RSCustomer.CursorType = 0
  RSCustomer.CursorLocation = 2
  RSCustomer.LockType = 1
  RSCustomer.Open()

  RSCustomer_numRows = 0
%>

<% 
  If (Not RSCustomer.EOF) Then 
     FormErrors  = FormErrors &  Message
  else 
    ' no customer with userid
    ' *** Edit Operations: declare variables    
    Dim MM_editAction
    Dim MM_abortEdit
    Dim MM_editQuery
    Dim MM_editCmd
    
    Dim MM_editConnection
    Dim MM_editTable
    Dim MM_editRedirectUrl
    Dim MM_editColumn
    Dim MM_recordId
    
    Dim MM_fieldsStr
    Dim MM_columnsStr
    Dim MM_fields
    Dim MM_columns
    Dim MM_typeArray
    Dim MM_formVal
    Dim MM_delim
    Dim MM_altVal
    Dim MM_emptyVal
    Dim MM_i
    
    MM_editAction = CStr(Request.ServerVariables("SCRIPT_NAME"))
    If (Request.QueryString <> "") Then
      MM_editAction = MM_editAction & "?" & Server.HTMLEncode(Request.QueryString)
    End If
    
    ' boolean to abort record edit
    MM_abortEdit = false
    
    ' query string to execute
    MM_editQuery = ""
  %>
  
  <%
    ' *** Insert Record: set variables
    
    If (CStr(Request("MM_insert")) = "form1") Then
    
      MM_editConnection = MM_dbConnect_STRING
      MM_editTable = "Customers"
      MM_editRedirectUrl = "register1.asp"
      MM_fieldsStr  = "Client_ID|value|Cust_Name|value|Account|value|Phone|value|Fax|value|Store_Address|value|Store_Suburb|value|Store_State|value|Store_Country|value|Store_Postcode|value|Delivery_Address|value|Delivery_Suburb|value|Delivery_State|value|Delivery_Country|value|Delivery_Postcode|value|contact|value|email|value|userid|value|passwd|value|payment|value|enable|value|online|value"
      MM_columnsStr = "Client_ID|none,none,NULL|Cust_Name|',none,''|Account|',none,''|Phone|',none,''|Fax|',none,''|Store_Address|',none,''|Store_Suburb|',none,''|Store_State|',none,''|Store_Country|',none,''|Store_Postcode|',none,''|Delivery_Address|',none,''|Delivery_Suburb|',none,''|Delivery_State|',none,''|Delivery_Country|',none,''|Delivery_Postcode|',none,''|contact|',none,''|email|',none,''|userid|',none,''|passwd|',none,''|payment|none,none,1|enable|none,none,1|online|none,none,1"
    
      ' create the MM_fields and MM_columns arrays
      MM_fields = Split(MM_fieldsStr, "|")
      MM_columns = Split(MM_columnsStr, "|")
      
      ' set the form values
      For MM_i = LBound(MM_fields) To UBound(MM_fields) Step 2
        MM_fields(MM_i+1) = CStr(Request.Form(MM_fields(MM_i)))
        If (MM_fields(MM_i) <> "Client_ID") Then ' ignore the client id field in the email
            HTML =   HTML & "<TR><TD align=right>" & MM_fields(MM_i) & "</td><td>" & CStr(Request.Form(MM_fields(MM_i))) & "</td></tr>"
        End If
      Next
    
      ' append the query string to the redirect URL
      If (MM_editRedirectUrl <> "" And Request.QueryString <> "") Then
        If (InStr(1, MM_editRedirectUrl, "?", vbTextCompare) = 0 And Request.QueryString <> "") Then
          MM_editRedirectUrl = MM_editRedirectUrl & "?" & Request.QueryString
        Else
          MM_editRedirectUrl = MM_editRedirectUrl & "&" & Request.QueryString
        End If
      End If
    
    End If
  %>

<!--  ========= PUT EMAIL CODE HERE ====================== -->


 <%
    ' *** Insert Record: construct a sql insert statement and execute it
    
    Dim MM_tableValues
    Dim MM_dbValues
    
    If (CStr(Request("MM_insert")) <> "") Then
        ' create the sql insert statement
        MM_tableValues = ""
        MM_dbValues = ""
        
        For MM_i = LBound(MM_fields) To UBound(MM_fields) Step 2
            MM_formVal = MM_fields(MM_i+1)
            MM_typeArray = Split(MM_columns(MM_i+1),",")
            MM_delim = MM_typeArray(0)
            If (MM_delim = "none") Then MM_delim = ""
            MM_altVal = MM_typeArray(1)
            If (MM_altVal = "none") Then MM_altVal = ""
            MM_emptyVal = MM_typeArray(2)
            If (MM_emptyVal = "none") Then MM_emptyVal = ""
            If (MM_formVal = "") Then
                MM_formVal = MM_emptyVal
            Else
                If (MM_altVal <> "") Then
                  MM_formVal = MM_altVal
                ElseIf (MM_delim = "'") Then  ' escape quotes
                  MM_formVal = "'" & Replace(MM_formVal,"'","''") & "'"
                Else
                  MM_formVal = MM_delim + MM_formVal + MM_delim
                End If
            End If
            If (MM_i <> LBound(MM_fields)) Then
                MM_tableValues = MM_tableValues & ","
                MM_dbValues = MM_dbValues & ","
            End If
            MM_tableValues = MM_tableValues & MM_columns(MM_i)
            MM_dbValues = MM_dbValues & MM_formVal
        Next
        
        MM_editQuery = "insert into " & MM_editTable & " (" & MM_tableValues & ") values (" & MM_dbValues & ")"

        response.write(MM_editQuery)
      
        If (Not MM_abortEdit) Then
            ' execute the insert
            Set MM_editCmd = Server.CreateObject("ADODB.Command")
            MM_editCmd.ActiveConnection = MM_editConnection
            MM_editCmd.CommandText = MM_editQuery
            MM_editCmd.Execute
            MM_editCmd.ActiveConnection.Close
            ' now get the last record set
            Dim RSCustomer1
            Dim RSCustomer1_cmd
            Dim RSCustomer1_numRows
            RSCustomer__MMColParam = Request.Form("userid")
            Set RSCustomer1_cmd = Server.CreateObject ("ADODB.Command")
            RSCustomer1_cmd.ActiveConnection = MM_dbConnect_STRING
            RSCustomer1_cmd.CommandText = "SELECT * FROM customers WHERE userid = ?" 
            RSCustomer1_cmd.Prepared = true
            RSCustomer1_cmd.Parameters.Append RSCustomer1_cmd.CreateParameter("param1", 200, 1, 50, RSCustomer__MMColParam) ' adVarChar
            Set RSCustomer1 = RSCustomer1_cmd.Execute
            Set MM_editCmd = Server.CreateObject ("ADODB.Command")
            MM_editCmd.ActiveConnection = MM_dbConnect_STRING
            MM_editCmd.CommandText = "INSERT INTO Address (Delivery_Contact,Delivery_Address, Delivery_Suburb, Delivery_State, Delivery_Country, Delivery_Postcode,Customer_ID) VALUES (?, ?, ?, ?, ?, ?, ?)" 
            MM_editCmd.Prepared = true
            MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param1", 202, 1, 255, Request.Form("contact")) ' adVarWChar
            MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param2", 202, 1, 255, Request.Form("Delivery_Address")) ' adVarWChar
            MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param3", 202, 1, 255, Request.Form("Delivery_Suburb")) ' adVarWChar
            MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param4", 202, 1, 255, Request.Form("Delivery_State")) ' adVarWChar
            MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param5", 202, 1, 255, Request.Form("Delivery_Country")) ' adVarWChar
            MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param6", 202, 1, 255, Request.Form("Delivery_Postcode")) ' adVarWChar
            MM_editCmd.Parameters.Append MM_editCmd.CreateParameter("param7", 202, 1, 255, RSCustomer1.Fields.Item("ID").Value) ' adVarWChar
            MM_editCmd.Execute
            MM_editCmd.ActiveConnection.Close
        
            If (MM_editRedirectUrl <> "") Then
                Response.Redirect(MM_editRedirectUrl)
            End If
        End If
    End If
  %>
  
<% End If %>
 
<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->

<!--#include file="header_menu.asp" -->


<script type="text/JavaScript">
  <!--
  function fValidateSelect(oItem,iDefault,szDesc)
  {
    if(oItem.selectedIndex == iDefault)
    { 
       if(szDesc!="")
       {
        alert(szDesc);
        oItem.focus();
       }
       return false;   
    }
    else
    {
       return true;
    }
  } 
  
  function fValidateLength(oItem,szDesc) 
  {
     if(oItem.value.length == 0)
     {
        alert("Please enter a valid " + szDesc);
        oItem.focus();
        return false;
     }
     else
     {
        return true;
     }
  }


  function MM_findObj(n, d) { //v4.01
    var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
      d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
    if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
    for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
    if(!x && d.getElementById) x=d.getElementById(n); return x;
  }
  
  
  function MM_validateForm() { //v4.0
    var i,p,q,nm,test,num,min,max,errors='',args=MM_validateForm.arguments;
    for (i=0; i<(args.length-2); i+=3) { 
      test=args[i+2]; 
      val=MM_findObj(args[i]);
      if (val) { 
          nm=val.name; 
          if ((val=val.value)!="") {
              if (test.indexOf('isEmail')!=-1) { 
                  p=val.indexOf('@');
                  if (p<1 || p==(val.length-1)) errors+='- '+nm+' must contain an e-mail address.\n';
              } 
              else if (test!='R') { 
                  num = parseFloat(val);
                  if (isNaN(val)) errors+='- '+nm+' must contain a number.\n';
                  if (test.indexOf('inRange') != -1) { 
                      p=test.indexOf(':');
                      min=test.substring(p-1,p); max=test.substring(p+1);
                      if (num<min || max<num) errors+='- '+nm+' must contain a number between '+min+' and '+max+'.\n';
                  } 
              } 
          } 
          else if (test.charAt(0) == 'R') errors += '- '+nm+' is required.\n'; 
      }
    } 
    if (errors) alert('The following error(s) occurred:\n'+errors);
    else{
        if(document.form1.new_account.checked == true)
        { 
          if(!fValidateLength(document.form1.Account,"Account / Client ID"))
              return false;
        }
      
      if (document.form1.passwd.value != document.form1.passwd1.value){
          alert('Error entering password');
          errors = "password error";
      }
    }
    document.MM_returnValue = (errors == '');
  }
  
  function delivery()
  {
      if (document.form1.copy.checked == true)
      {
          document.form1.Delivery_Address.value = document.form1.Store_Address.value;
          document.form1.Delivery_Suburb.value = document.form1.Store_Suburb.value;
          document.form1.Delivery_Country.value = document.form1.Store_Country.value;
          document.form1.Delivery_State.value = document.form1.Store_State.value;
          document.form1.Delivery_Postcode.value = document.form1.Store_Postcode.value;
      }
  }

  function RefreshImage(valImageId) {
      var objImage = document.getElementById(valImageId)
      if (objImage == undefined) {
          return;
      }
      var now = new Date();
      objImage.src = objImage.src.split('?')[0] + '?x=' + now.toUTCString();
  }
  

//-->
</script>

<section id="fh5co-login-section" class="section">
    <div class="container">
        <h3>New Customer Registration</h3>
        
                <!-- <%=MM_editAction%>   -->
                <form action="register.asp" method="POST" name="form1" onSubmit="MM_validateForm('Cust_Name','','R','Account','','R','Phone','','R','Store_Address','','R','Store_Suburb','','R','Store_State','','R','Store_Postcode','','R','Delivery_Address','','R','Delivery_Suburb','','R','Delivery_State','','R','Delivery_Postcode','','R','email','','RisEmail','userid','','R','passwd','','R','passwd1','','R');return document.MM_returnValue" >

                <input name="Client_ID" type="hidden" value="111">

                    <fieldset class="form-group  col-md-12 col-sm-12 col-xs-12">
                        <label for="Cust_Name">Name</label>
                        <input type="text" class="form-control" name="Cust_Name" id="Cust_Name" value='<%=sCust_Name%>' placeholder="Customer Name" required>
                        <!-- <small class="text-muted">We'll never share your email with anyone else.</small> -->
                    </fieldset>
                    
                    <fieldset class="form-group col-md-6 col-sm-6 col-xs-12">
                        <label for="Phone">Phone</label>
                        <input type="text" class="form-control" id="Phone" placeholder="Phone" name="Phone" value="<%=sPhone%>">
                    </fieldset>
                    <fieldset class="form-group col-md-6 col-sm-6 col-xs-12">
                        <label for="Fax">Fax</label>
                        <input type="text" class="form-control" id="Fax" placeholder="Fax" name="Fax" value="<%=sFax%>">
                    </fieldset>
                    <fieldset class="form-group col-md-12 col-sm-12 col-xs-12">
                        <label for="Store_Address">Address</label>
                        <input type="text" class="form-control" id="Store_Address" placeholder="Store Address" name="Store_Address" value="<%=sStore_Address%>">
                    </fieldset>
                    <fieldset class="form-group col-md-6 col-sm-6 col-xs-12">
                        <label for="Store_Suburb">Suburb</label>
                        <input type="text" class="form-control" id="Store_Suburb" placeholder="Store Suburb" name="Store_Suburb" value="<%=sStore_Suburb%>">
                    </fieldset>
                    <fieldset class="form-group col-md-6 col-sm-6 col-xs-12">
                        <label for="Store_State">State</label>
                        <input type="text" class="form-control" id="Store_State" placeholder="Store State" name="Store_State" value="<%=sStore_State%>">
                    </fieldset>
                    <fieldset class="form-group col-md-6 col-sm-6 col-xs-12">
                        <label for="Store_Country">Country</label>
                        <input type="text" class="form-control" id="Store_Country" placeholder="Store Country" name="Store_Country" value="<%=sStore_Country%>">
                    </fieldset>
                    <fieldset class="form-group col-md-6 col-sm-6 col-xs-12">
                        <label for="Store_Postcode">Postcode</label>
                        <input type="text" class="form-control" id="Store_Postcode" placeholder="Store Postcode" name="Store_Postcode" value="<%=sStore_Postcode%>" >
                    </fieldset>

                    <fieldset class="form-group col-md-12 col-sm-12 col-xs-12 form-check">
                        <label for="copy" class="form-check-label"> Delivery Address 
                            <p class="form-control-static" style="margin-left: 30px;">
                                <input class="form-check-input" type="checkbox" name="copy" id="copy" value="1" onClick="delivery()">
                                Same as main address  
                            </p>
                        </label> 
                    </fieldset>
                    <fieldset class="form-group col-md-12 col-sm-12 col-xs-12">
                        <label for="Store_Address">Delivery Address</label>
                        <input type="text" class="form-control" id="Delivery_Address" placeholder="Delivery Address" name="Delivery_Address" value="<%=sDelivery_Address%>">
                    </fieldset>
                    <fieldset class="form-group col-md-6 col-sm-6 col-xs-12">
                        <label for="Store_Suburb">Delivery Suburb</label>
                        <input type="text" class="form-control" id="Delivery_Suburb" placeholder="Delivery Suburb" name="Delivery_Suburb" value="<%=sDelivery_Suburb%>">
                    </fieldset>
                    <fieldset class="form-group col-md-6 col-sm-6 col-xs-12">
                        <label for="Store_State">Delivery State</label>
                        <input type="text" class="form-control" id="Delivery_State" placeholder="Delivery State" name="Delivery_State" value="<%=sDelivery_State%>">
                    </fieldset>
                    <fieldset class="form-group col-md-6 col-sm-6 col-xs-12">
                        <label for="Store_Country">Delivery Country</label>
                        <input type="text" class="form-control" id="Delivery_Country" placeholder="Delivery Country" name="Delivery_Country" value="<%=sDelivery_Country%>">
                    </fieldset>
                    <fieldset class="form-group col-md-6 col-sm-6 col-xs-12">
                        <label for="Store_Postcode">Delivery Postcode</label>
                        <input type="text" class="form-control" id="Delivery_Postcode" placeholder="Delivery Postcode" name="Delivery_Postcode" value="<%=sDelivery_Postcode%>" >
                    </fieldset>
                    <fieldset class="form-group col-md-12 col-sm-12 col-xs-12 form-check">
                        <label for="franchise" class="form-check-label"> Franchise
                            <p class="form-control-static" style="margin-left: 30px;">
                                <input class="form-check-input" type="checkbox" name="franchisee" id="franchisee" value="1" >
                                Are you a F45 franchisee?
                            </p>
                        </label> 
                    </fieldset>

                    <fieldset id="fieldsetContact" class="form-group col-md-12 col-sm-12 col-xs-12" style="display:none;">
                        <label for="contact">Contact</label>
                        <input type="text" class="form-control" id="contact" placeholder="Contact Person" name="contact" value="<%=scontact%>" >
                    </fieldset>
                    <fieldset class="form-group col-md-6 col-sm-6 col-xs-12"">
                        <label for="email">Email address</label>
                        <input type="email" class="form-control" id="email" placeholder="Enter email" name="email" value="<%=semail%>" >
                    </fieldset>
                    <fieldset class="form-group col-md-6 col-sm-6 col-xs-12">
                        <label for="User">User Id</label>
                        <input type="text" class="form-control" id="userid" name="userid" value="<%=suserid%>" >
                    </fieldset>
                    <fieldset class="form-group col-md-6 col-sm-6 col-xs-12"">
                        <label for="passwd">Password</label>
                        <input type="password" class="form-control" id="passwd" placeholder="Password" name="passwd" value="<%=sPasswd%>" >
                    </fieldset>
                    <fieldset class="form-group col-md-6 col-sm-6 col-xs-12"">
                        <label for="passwd">Verify Password</label>
                        <input type="password" class="form-control" id="passwd1" placeholder="Verify Password" name="passwd1" value="<%=sPasswd1%>" >
                    </fieldset>

                    <fieldset class="form-group col-md-12 col-sm-12 col-xs-12"">
                        <label >
                            <img src="captcha.asp" id="imgCaptcha"  />
                            <small class="text-muted"><a href="javascript:void(0);" onClick="RefreshImage('imgCaptcha');">Get a new challenge</a></small>
                            <small class="text-muted"><span style="color: <%=lblColor%>; font-weight: bold;"><%=lblResult%></span></small>
                        </label>
                    </fieldset>
                    <fieldset class="form-group col-md-6 col-sm-6 col-xs-12">
                        <label for="contact">CAPTCHA check</label>
                        <input type="text" class="form-control" id="txtCaptcha" placeholder="CAPTCHA check" name="txtCaptcha" style="border-color: <%=lblColor%>" value="" >
                        <small class="text-muted">Enter the charaters as they appear in the image above.</small>
                    </fieldset>

                    <fieldset class="form-group col-md-12 col-sm-12 col-xs-12  text-center" >
                        <!-- <label for="send"></label> -->
                        <input id="send" name="send" type="submit" class="btn btn-filters" value="Register" />
                    </fieldset>

                    <input type="hidden" name="MM_insert" value="form1">
                    <!-- <input name="send" type="submit" class="btn btn-filters" value="Submit" />
                    <input type="button" name="send" value="Register" onclick="location.href='register.asp';" class="btn btn-filters" /> -->
                </form>

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

