<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="../Connections/dbConnect.asp" -->

<%
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

' boolean to abort record edit
MM_abortEdit = false

' query string to execute
MM_editQuery = ""
%>
<%
Dim RSCustomer__MMColParam
Dim RSCustomer
Dim RSCustomer_numRows

Dim error_message
error_message = ""
' *** Update Record: set variables
If (CStr(Request("userid")) <> "") Then
	If check_record() then
		update_record()
		send_email()
		
	else 
		error_message = "There is a problem with the update<br> The User id is invalid<br>Can you retry from the email"
	end if

End If
'**************************************************************************
function update_record()

  MM_editConnection = MM_dbConnect_STRING
  MM_editTable = "Customers"
  MM_editColumn = "userid"
  MM_recordId = "'" + Request.Form("MM_recordId") + "'"
  MM_editRedirectUrl = ""
  MM_fieldsStr  = "verified|value"
  MM_columnsStr = "verified|none,none,NULL"

  ' create the MM_fields and MM_columns arrays
  MM_fields = Split(MM_fieldsStr, "|")
  MM_columns = Split(MM_columnsStr, "|")
  
  ' set the form values
  For MM_i = LBound(MM_fields) To UBound(MM_fields) Step 2
    MM_fields(MM_i+1) = CStr(Request.Form(MM_fields(MM_i)))
  Next

  ' append the query string to the redirect URL
  If (MM_editRedirectUrl <> "" And Request.QueryString <> "") Then
    If (InStr(1, MM_editRedirectUrl, "?", vbTextCompare) = 0 And Request.QueryString <> "") Then
      MM_editRedirectUrl = MM_editRedirectUrl & "?" & Request.QueryString
    Else
      MM_editRedirectUrl = MM_editRedirectUrl & "&" & Request.QueryString
    End If
  End If

' *** Update Record: construct a sql update statement and execute it


  ' create the sql update statement
  MM_editQuery = "update " & MM_editTable & " set "
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
      MM_editQuery = MM_editQuery & ","
    End If
    MM_editQuery = MM_editQuery & MM_columns(MM_i) & " = " & MM_formVal
  Next
  MM_editQuery = MM_editQuery & " where " & MM_editColumn & " = " & MM_recordId

  If (Not MM_abortEdit) Then
    ' execute the update
    Set MM_editCmd = Server.CreateObject("ADODB.Command")
    MM_editCmd.ActiveConnection = MM_editConnection
    MM_editCmd.CommandText = MM_editQuery
    MM_editCmd.Execute
    MM_editCmd.ActiveConnection.Close

  End If
End function
%>
<%
function check_record()
	Dim record_valid
  RSCustomer__MMColParam = Request.Form("userid")


	Set RSCustomer = Server.CreateObject("ADODB.Recordset")
	RSCustomer.ActiveConnection = MM_dbConnect_STRING
	sqlstring = "SELECT * FROM Customers WHERE userid = '" + Replace(RSCustomer__MMColParam, "'", "''") + "'"
	RSCustomer.Source = sqlstring
	RSCustomer.CursorType = 0
	RSCustomer.CursorLocation = 2
	RSCustomer.LockType = 1
	RSCustomer.Open()

	RSCustomer_numRows = 0
	
	If (NOT RSCustomer.EOF) Then 
		record_valid = true
	Else 
		record_valid = false
	End If
	check_record = record_valid
end function
%>

<%
function send_email()
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
Dim jmail
   Set jmail = Server.CreateObject("JMail.Message")
    jmail.Logging = true
	jmail.silent = true


   jmail.HTMLBody = "<HTML>"
	jmail.appendHTML "<HEAD>"
	jmail.appendHTML "<TITLE>Joseph Dahdah New customer registration</TITLE>"
	jmail.appendHTML "</HEAD>"
	jmail.appendHTML "<BODY >"
	jmail.appendHTML "<TABLE cellpadding=""10"">"
	jmail.appendHTML "<tr><td>"
	jmail.appendHTML "Welcome to the Joseph Dahdah online ordering system<br>"
	jmail.appendHTML  "Your account has been approved.<br>"
	jmail.appendHTML  "You can start now by entering your user name and password at <br>"
	jmail.appendHTML "<a href=""http://www.josephdahdah.com.au"" >www.josephdahdah.com.au</a><br>"
	jmail.appendHTML  "User name is " & (RSCustomer.Fields.Item("userid").Value) & "<br>"
	'jmail.appendHTML  "User Password is " & (RSCustomer.Fields.Item("passwd").Value) & "<br>"
	jmail.appendHTML "</td></tr>"
	jmail.appendHTML "</table></BODY>"
	jmail.appendHTML "</HTML>"
	jmail.AddRecipient (RSCustomer.Fields.Item("email").Value)
'	jmail.From = (RSEmail.Fields.Item("email_reg").Value)
		jmail.From = "jdweb@josephdahdah.com.au"
	jmail.Subject = "Welcome to Joseph Online Order System"
	'	Mail.HTMLBody  = HTML 
    jmail.MailServerUserName = "JDWeb"
    jmail.MailServerPassword = "Garment1"

	if  jmail.Send("mail.josephdahdah.com.au" ) then ' send email
 		 message = "Message sent succesfully!"
	elseif jmail.Send("mail.josephdahdah.com.au" ) then ' try again
		message = "<pre>" & jmail.log & "</pre>"
	end if

	RSEmail.Close()
	Set RSEmail = Nothing

end function
%>


<html>
<head>
<meta http-equiv="content-type" content="text/html;charset=iso-8859-1">

<title>Joseph Dahdah - Uniform Apparel Collection</title>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link href="../external.css" rel="stylesheet" type="text/css" media="all">
</head>
<body bgcolor="#333333" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table id="Table_01" width="750" align="center" height="585" border="0" cellpadding="0" cellspacing="0">
  <tr height="15">
    <td colspan="2" bgcolor="#333333" width="750" height="15"></td>
  </tr>
  <tr height="128">
    <td height="128" width="750" colspan="2"><img src="../images/temp_10.jpg" width="750" height="128"></td>
  </tr>
  <tr height="420">
    <td valign="top" width="177" height="420" class="menu_bg"><table id="Table_01" width="177" height="420" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td colspan="2"><img src="../images/spacer.gif" width="177" height="1" alt=""></td>
        </tr>
        <tr>
          <td width="1" valign="top"><img src="../images/spacer.gif" width="1" height="419" alt=""></td>
          <td valign="top" id="menu" width="176">
            <p>&nbsp;</p>
            <p>&nbsp;</p>
  <div id="submenu" > 

          <a href="../policy.html" >Dahdah Website </a>		   </div>          </td>
        </tr>
      </table></td>
    <td width="573" height="420" valign="top"><table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" height="420" bgcolor="white" >
        <tr>
          <td align="left" valign="top" id="main"><div id="admin"> 
<% If error_message <> "" Then %>
	<p><span class="heading3"><%= error_message %></span>  </p>
<% Else %>
      <p><span class="heading3">New customer enable to log on and email sent to</span>  </p>
      <p><% =(RSCustomer.Fields.Item("email").Value)%></p>
<%
RSCustomer.Close()
Set RSCustomer = Nothing
%>
<% End If %>       </div></td>
        </tr>
      </table></td>
  </tr>
  <tr height="1">
    <td colspan="2" width="750" height="1"><img src="../images/temp_07.jpg" width="750" height="1" alt=""></td>
  </tr>
  <tr height="26">
    <td colspan="2" width="750" height="26"><img src="../images/temp_08.jpg" width="750" height="26" alt=""></td>
  </tr>
</table>
</body>
</html>
