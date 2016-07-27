<%
  Dim str_enable
  Dim str_client_ID 
  Dim str_delivery
  Dim str_International
  Dim str_charge
  Dim str_charge_all

' *** Validate request to log in to this site.
MM_LoginAction = Request.ServerVariables("URL")
'If Request.QueryString<>"" Then MM_LoginAction = MM_LoginAction + "?" + Server.HTMLEncode(Request.QueryString)
MM_valUsername=CStr(Request.Form("UserID"))

If MM_valUsername <> "" Then
  MM_fldUserAuthorization=""
  MM_redirectLoginSuccess="default.asp"
  MM_redirectLoginFailed="login.asp"
  MM_flag="ADODB.Recordset"
  set MM_rsUser = Server.CreateObject(MM_flag)
  MM_rsUser.ActiveConnection = MM_dbConnect_STRING
  MM_rsUser.Source = "SELECT *"
  If MM_fldUserAuthorization <> "" Then MM_rsUser.Source = MM_rsUser.Source & "," & MM_fldUserAuthorization
  MM_rsUser.Source = MM_rsUser.Source & " FROM client_Customer WHERE userid='" & Replace(MM_valUsername,"'","''") &"' AND passwd='" & Replace(Request.Form("Password"),"'","''") & "'"
  MM_rsUser.CursorType = 0
  MM_rsUser.CursorLocation = 2
  MM_rsUser.LockType = 3
  MM_rsUser.Open
  

  If Not MM_rsUser.EOF Or Not MM_rsUser.BOF Then 

    str_client_ID = MM_rsUser.Fields.Item("Client_ID").Value
    str_delivery = MM_rsUser.Fields.Item("delivery").Value
    str_charge = MM_rsUser.Fields.Item("charge").Value
    str_charge_all = MM_rsUser.Fields.Item("charge_all").Value
    str_charge1 = MM_rsUser.Fields.Item("charge1").Value
    str_charge1_all = MM_rsUser.Fields.Item("charge1_all").Value
    str_enable = MM_rsUser.Fields.Item("enable").Value
    str_International = MM_rsUser.Fields.Item("International").Value
   
     ' username and password match - this is a valid user
	'check that the customer is enabled
	
	If (str_enable) Then ' it enable
    	Session("svUser") = MM_valUsername ' used by shopping cart software
		Session("MM_Username") = MM_valUsername
		Session("client_ID") = str_client_ID
		Session("delivery") = str_delivery
		
		if str_International Then
			Session("international")= 1
		Elseif MM_rsUser.Fields.Item("FreightByQuote").Value Then
			Session("international")= 1
		Else
			Session("international") = 0
		End If
		Session("charge") = str_charge
		Session("charge_all") = str_charge_all
		if (str_charge1 <> "") Then
			Session("charge1") = str_charge1
			Session("charge1_all") = str_charge1_all
		else
			Session("charge1") = 0
			Session("charge1_all") = 0
		End If	

    	If (MM_fldUserAuthorization <> "") Then
      		Session("MM_UserAuthorization") = CStr(MM_rsUser.Fields.Item(MM_fldUserAuthorization).Value)
    	Else
      		Session("MM_UserAuthorization") = ""
		End If
   	 	if CStr(Request.QueryString("accessdenied")) <> "" And false Then
      		MM_redirectLoginSuccess = Request.QueryString("accessdenied")
    	End If
    	MM_rsUser.Close

 	For Each strKeyname in Request.Cookies("splat") 
		if Request.Cookies("splat")(strKeyname) <> "" then
			Response.Cookies("splat")(strKeyname) = ""
		End If
	Next
	Session("orderid") = ""
    	Response.Redirect(MM_redirectLoginSuccess)
  	End If
  End If
  MM_rsUser.Close
  Response.Redirect(MM_redirectLoginFailed)
End If
%>
