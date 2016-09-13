<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Test email</title>
<META NAME="description" CONTENT="">
<meta http-equiv="keywords" content=" ">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<META NAME="robots" CONTENT="INDEX,FOLLOW">
<META NAME="GOOGLEBOT" CONTENT="INDEX, FOLLOW">
<META NAME="revisit-after" CONTENT="7 Days">
<meta name="description" content="">
<meta name="keywords" content="">
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#669999" >
<% 
Dim HTML
if Request.Form("emailto") <> "" then

   Set jmail = Server.CreateObject("JMail.Message")
    jmail.Logging = true
	jmail.silent = true

'	Mail.Host = "localhost"
'	Mail.IsHTML = True
'	src_image = "NewImages/" + RSProduct.Fields.Item("largeImage").Value + ".jpg"

'	Mail.AttachURL src_image, "myImage.gif" 
'	Mail.AttachFile "NewImages/GFL/bs26-lg.jpg", "myImage.gif",1
   jmail.HTMLBody = "<HTML>"
  jmail.appendHTML "<HEAD>"
  jmail.appendHTML "<TITLE>Joseph Dahdah</TITLE>"
  jmail.appendHTML "</HEAD>"
  jmail.appendHTML "<BODY >"
  jmail.appendHTML "<TABLE cellpadding=""4"">"
  jmail.appendHTML "<TR><TD>"
  jmail.appendHTML now() & "</td></tr>"
  jmail.appendHTML "<TR><TD>"
  jmail.appendHTML Request.Form("body")
  jmail.appendHTML "<BR><BR></td></tr>"
  jmail.appendHTML "<TR><TD>From "
  jmail.appendHTML Request.Form("emailname")
  jmail.appendHTML "</TD></TR>"
  jmail.appendHTML "</table></BODY>"
  jmail.appendHTML "</HTML>"
	jmail.AddRecipient CStr(Request.Form("emailto"))
	jmail.From = Request.Form("emailfrom")
	jmail.Subject = "test"
'	Mail.HTMLBody  = HTML 
    jmail.MailServerUserName = "JDWeb"
    jmail.MailServerPassword = "Garment1"
 
	if  jmail.Send("mail.josephdahdah.com.au" ) then ' send email
 		 Response.write "Message sent succesfully!"
	elseif jmail.Send("mail.josephdahdah.com.au" ) then ' try again
 		Response.write  "Message sent succesfully second attempt!"
	else
 		Response.write   "<pre>" & jmail.log & "</pre>"
	end if
' if not jmail.Send("smtp-au.server-mail.com" ) then
' Response.write "<pre>" & jmail.log & "</pre>"
'else
' Response.write "Message sent succesfully!"
'end if
	
end if
%>

<form action="mr.asp" method="post" name="friend" >
<table class="normal" align="center" border="5" bordercolor="#6699cc" bgcolor="#FFFFFF" cellpadding="0" cellspacing="5">
<tr bordercolor="#FFFFFF">
      <td colspan="3"><h1>Email a Colleague</h1></td>
    </tr>
<tr bordercolor="#FFFFFF"><td height="20">&nbsp;</td></tr>
<tr bordercolor="#FFFFFF">
      <td>Colleague's Email Address: </td>
      <td><input name="emailto" type="text" size="50" value="jdweb@josephdahdah.com.au"></td></tr>
<tr bordercolor="#FFFFFF">
      <td>Your Name:</td>
      <td><input name="emailname" type="text" size="50" value="Mick"></td></tr>
<tr bordercolor="#FFFFFF">
      <td>Your Email Address:</td>
      <td><input name="emailfrom" type="text" size="50" value="jdweb@josephdahdah.com.au"></td></tr>
<tr bordercolor="#FFFFFF"><td>Message:</td><td><textarea name="body" cols="40" rows="5">test message</textarea></td></tr>
<tr bordercolor="#FFFFFF"><td></td><td><input name="submit" type="submit" value="SEND"></td></tr>
</table>
</form> 

</body>
</html>

