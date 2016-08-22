<% 
Function get_db_fields()
	set RsCust = Server.CreateObject("ADODB.Recordset")
	RsCust.ActiveConnection = MM_dbConnect_String
	RsCust.Source = "SELECT * FROM customers WHERE userid = '" + Replace(RsCust__MMColParam, "'", "''") + "'"
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
	RSAddress.Source = "SELECT * FROM Address WHERE ID = " + Request.Form("Address") + ""
	RSAddress.CursorType = 0
	RSAddress.CursorLocation = 2
	RSAddress.LockType = 1
	RSAddress.Open()
	
	RSAddress_numRows = 0

End function


Function send_email()
	
	
	'  Response.Redirect(UC_redirectPage)
	UC_redirectPage = UC_redirectPage + "?message=" + Server.URLEncode(message)
	
End Function %>

<%
Function get_order()
  'check if do before
  RSOrders__MMColParam = "1"
  If (Request.Form("refnumber") <> "") Then 
	RSOrders__MMColParam = Request.Form("refnumber")
  End If

  
  Set RSOrders = Server.CreateObject("ADODB.Recordset")
  RSOrders.ActiveConnection = MM_dbConnect_STRING
  RSOrders.Source = "SELECT * FROM Orders WHERE OrderID = '" + Replace(RSOrders__MMColParam, "'", "''") + "'"
  RSOrders.CursorType = 0
  RSOrders.CursorLocation = 2
  RSOrders.LockType = 1
  RSOrders.Open()
  
  RSOrders_numRows = 0

  If (NOT RSOrders.EOF) Then  ' error has occured eg user hit page refresh.
		  RSOrders.Close()
		  Set RSOrders = Nothing
		  Response.Redirect("cancelOrder.asp")
  End If	
  
  RSOrders.Close()
  Set RSOrders = Nothing
End Function
 %>
 
<%  
Function insert_record()
  MM_editConnection = MM_dbConnect_String
  MM_editTable = "Orders"
  MM_editRedirectUrl = ""
  
  ' clear address to indicate new address table used
  
  MM_fieldsStr  = "user|value|refnumber|value|customerid|value|ordstatus|value|Comment|value|Address|value|centreid|value|purchase_order|value|building|value|employee|value|Total|value|Delivery|value|promo_disc|value|allowance|value|Pickup|value"
  MM_columnsStr = "UserID|',none,''|OrderID|',none,''|Customer_ID|none,none,NULL|Status|',none,''|Comment|',none,''|Address|',none,''|Centre_ID|none,none,NULL|purchase_order|',none,''|building|',none,''|employee|',none,''|Total|',none,''|Delivery|',none,''|promo_disc|',none,''|Allowance|',none,''|Pickup|none,1,0"

  ' create the MM_fields and MM_columns arrays
  MM_fields = Split(MM_fieldsStr, "|")
  MM_columns = Split(MM_columnsStr, "|")
  
  ' set the form values
  For i = LBound(MM_fields) To UBound(MM_fields) Step 2
    MM_fields(i+1) = CStr(Request.Form(MM_fields(i)))
  Next
  'MM_fields(9) = 0  ' indicates to use the AddressOrder table


' *** Insert Record: construct a sql insert statement and execute it

  ' create the sql insert statement
  MM_tableValues = ""
  MM_dbValues = ""
  For i = LBound(MM_fields) To UBound(MM_fields) Step 2
    FormVal = MM_fields(i+1)
    MM_typeArray = Split(MM_columns(i+1),",")
    Delim = MM_typeArray(0)
    If (Delim = "none") Then Delim = ""
    AltVal = MM_typeArray(1)
    If (AltVal = "none") Then AltVal = ""
    EmptyVal = MM_typeArray(2)
    If (EmptyVal = "none") Then EmptyVal = ""
    If (FormVal = "") Then
      FormVal = EmptyVal
    Else
      If (AltVal <> "") Then
        FormVal = AltVal
      ElseIf (Delim = "'") Then  ' escape quotes
        FormVal = "'" & Replace(FormVal,"'","''") & "'"
      Else
        FormVal = Delim + FormVal + Delim
      End If
    End If
    If (i <> LBound(MM_fields)) Then
      MM_tableValues = MM_tableValues & ","
      MM_dbValues = MM_dbValues & ","
    End if
    MM_tableValues = MM_tableValues & MM_columns(i)
    MM_dbValues = MM_dbValues & FormVal
  Next
  MM_editQuery = "insert into " & MM_editTable & " (" & MM_tableValues & ") values (" & MM_dbValues & ")"

  If (Not MM_abortEdit) Then
    ' execute the insert
    Set MM_editCmd = Server.CreateObject("ADODB.Command")
    MM_editCmd.ActiveConnection = MM_editConnection
    MM_editCmd.CommandText = MM_editQuery
    MM_editCmd.Execute
    MM_editCmd.ActiveConnection.Close

  End If
  
  ' load address 
  
  if Request.Form("Address") <> 0 Then
  	Set RSAddress = Server.CreateObject("ADODB.Recordset")
	RSAddress.ActiveConnection = MM_dbConnect_STRING
	RSAddress.Source = "SELECT * FROM Address WHERE ID = " + Request.Form("Address") + ""
	RSAddress.CursorType = 0
	RSAddress.CursorLocation = 2
	RSAddress.LockType = 1
	RSAddress.Open()
	
	RSAddress_numRows = 0


   MM_editConnection = MM_dbConnect_String
  MM_editTable = "OrderAddress"
  MM_editRedirectUrl = ""
  MM_fieldsStr  = "Customer_ID|" & RSAddress.Fields.Item("Customer_ID").Value & "|Delivery_Name|" & RSAddress.Fields.Item("Delivery_Name").Value & "|Delivery_Address|" & RSAddress.Fields.Item("Delivery_Address").Value & "|Delivery_Suburb|" & RSAddress.Fields.Item("Delivery_Suburb").Value & "|Delivery_State|" & RSAddress.Fields.Item("Delivery_State").Value & "|Delivery_Country|" & RSAddress.Fields.Item("Delivery_Country").Value & "|Delivery_Postcode|" & RSAddress.Fields.Item("Delivery_Postcode").Value & "|Delivery_Phone|" & RSAddress.Fields.Item("Delivery_Phone").Value & "|Delivery_Contact|" & RSAddress.Fields.Item("Delivery_Contact").Value & "|ID|" & Request.Form("refnumber") & ""
  MM_columnsStr = "Customer_ID|',none,''|Delivery_Name|',none,''|Delivery_Address|',none,''|Delivery_Suburb|',none,''|Delivery_State|',none,''|Delivery_Country|',none,''|Delivery_Postcode|',none,''|Delivery_Phone|',none,''|Delivery_Contact|',none,''|ID|',none,''"

  ' create the MM_fields and MM_columns arrays
  MM_fields = Split(MM_fieldsStr, "|")
  MM_columns = Split(MM_columnsStr, "|")
  

' *** Insert Record: construct a sql insert statement and execute it

  ' create the sql insert statement
  MM_tableValues = ""
  MM_dbValues = ""
  For i = LBound(MM_fields) To UBound(MM_fields) Step 2
    FormVal = MM_fields(i+1)
    MM_typeArray = Split(MM_columns(i+1),",")
    Delim = MM_typeArray(0)
    If (Delim = "none") Then Delim = ""
    AltVal = MM_typeArray(1)
    If (AltVal = "none") Then AltVal = ""
    EmptyVal = MM_typeArray(2)
    If (EmptyVal = "none") Then EmptyVal = ""
    If (FormVal = "") Then
      FormVal = EmptyVal
    Else
      If (AltVal <> "") Then
        FormVal = AltVal
      ElseIf (Delim = "'") Then  ' escape quotes
        FormVal = "'" & Replace(FormVal,"'","''") & "'"
      Else
        FormVal = Delim + FormVal + Delim
      End If
    End If
    If (i <> LBound(MM_fields)) Then
      MM_tableValues = MM_tableValues & ","
      MM_dbValues = MM_dbValues & ","
    End if
    MM_tableValues = MM_tableValues & MM_columns(i)
    MM_dbValues = MM_dbValues & FormVal
  Next
  MM_editQuery = "insert into " & MM_editTable & " (" & MM_tableValues & ") values (" & MM_dbValues & ")"

  If (Not MM_abortEdit) Then
    ' execute the insert
    Set MM_editCmd = Server.CreateObject("ADODB.Command")
    MM_editCmd.ActiveConnection = MM_editConnection
    MM_editCmd.CommandText = MM_editQuery
    MM_editCmd.Execute
    MM_editCmd.ActiveConnection.Close

  End If 
  
	RSAddress.Close()
	Set RSAddress = Nothing
  End If 
End Function

Function save_to_database()


  	UC_orderId     =  Session("orderid") 
  	MM_editConnection = MM_dbConnect_String
  	MM_editTable = "OrderDetails"

	newarray = arraySort( buildarray(), 9, false )

	For j = 0 to UBound(newarray,2) - 1

  
		 MM_columnsStr = "Quantity|',none,''|PriceInc|',none,''|Prod_Code|',none,''|Sizes|',none,''|Description|',none,''|Custom|',none,''|Colour|',none,''|smimage|',none,''|NamePrinted|',none,''|PackSize|',none,''|ProdID|',none,''"
	  
		' create the MM_fields and MM_columns arrays
		  MM_columns = Split(MM_columnsStr, "|")
		
	  ' *** Insert Record: construct a sql insert statement and execute it
	  
		' create the sql insert statement
		  MM_tableValues = ""
		  MM_dbValues = ""
		  For i = 0 To (UBound(newarray,1)-1) Step 1
		'  	response.Write("j =" & j & " i =" & i & "<br>")
			
			FormVal = newarray(i,j)
		'	response.Write("FormVal =" & FormVal & "<br>")
			MM_typeArray = Split(MM_columns((i*2)+1),",")
			Delim = MM_typeArray(0)
			If (Delim = "none") Then Delim = ""
			AltVal = MM_typeArray(1)
			If (AltVal = "none") Then AltVal = ""
			EmptyVal = MM_typeArray(2)
			If (EmptyVal = "none") Then EmptyVal = ""
			If (FormVal = "") Then
			  FormVal = EmptyVal
			Else
			  If (AltVal <> "") Then
				FormVal = AltVal
			  ElseIf (Delim = "'") Then  ' escape quotes
				FormVal = "'" & Replace(FormVal,"'","''") & "'"
			  Else
				FormVal = Delim + FormVal + Delim
			  End If
			End If
			If (i <> 0) Then
			  MM_tableValues = MM_tableValues & ","
			  MM_dbValues = MM_dbValues & ","
			End if
			MM_tableValues = MM_tableValues & MM_columns(i*2)
			MM_dbValues = MM_dbValues & FormVal
			
			
		  Next
			'add the order id
			MM_tableValues = MM_tableValues & ",OrderID"
			MM_dbValues = MM_dbValues & "," & Session("orderid")
		'	response.Write("orderid->" + Session("orderid") + "<br>")
		  MM_editQuery = "insert into " & MM_editTable & " (" & MM_tableValues & ") values (" & MM_dbValues & ")"
		'response.Write(" " + MM_editQuery + "<br>")
		  If (Not MM_abortEdit) Then
			' execute the insert
			Set MM_editCmd = Server.CreateObject("ADODB.Command")
			MM_editCmd.ActiveConnection = MM_editConnection
			MM_editCmd.CommandText = MM_editQuery
			MM_editCmd.Execute
			MM_editCmd.ActiveConnection.Close
		
		  End If
	Next
End Function
 %>
 <% 
 Function get_delivery(total,postcode)
	get_delivery = 0
	If (Session("international") = 0) Then ' not international
		If (total < Cint(Session("delivery"))) Then
			If(postcode=9999) Then 
				get_delivery = 0
			elseif((postcode<2000) OR (postcode>2299))  Then
				get_delivery = Session("charge_all") ' includes GST
			else
				get_delivery = Session("charge")
			End if
		Else 
			If(postcode=9999) Then 
				get_delivery = 0
			elseif(postcode<2000) OR (postcode>2299)  Then
				get_delivery = Session("charge1_all") ' includes GST
			else
				get_delivery = Session("charge1")
			End if
		End if
	End If

 End function
 

Function buildarray()
 	Dim myarray()
	arraycount=0
	For Each strKeyname in Request.Cookies("splat") 
	  if Request.Cookies("splat")(strKeyname) <> "" then
	  	arraycount = arraycount + 1
	  end if
	Next 
	redim myarray(11,arraycount)

	i=0
 	For Each strKeyname in Request.Cookies("splat") 
	  if Request.Cookies("splat")(strKeyname) <> "" then

		cart_string= Request.Cookies("splat")(strKeyname)
		Cart_items=Split(cart_string,"|",-1,0)
 		myarray(0,i) = Cart_items(0)
 		myarray(1,i) = Cart_items(1)
 		myarray(2,i) = Cart_items(2)
 		myarray(3,i) = Cart_items(3)
 		myarray(4,i) = Cart_items(4)
 		myarray(5,i) = Cart_items(5)
 		myarray(6,i) = Cart_items(6)
 		myarray(7,i) = Cart_items(7)
 		myarray(8,i) = Cart_items(8)
 		myarray(9,i) = Cart_items(9)
 		myarray(10,i) = Cart_items(10)
 		myarray(11,i) = Cart_items(11)
		i=i+1
	  end if
	Next 

	buildarray =  myarray
End Function
 '==============================================
function arraySort( arToSort, sortBy, compareDates )
'==============================================

  Dim c, d, e, smallestValue, smallestIndex, tempValue
  

  For c = 0 To uBound( arToSort, 2 ) - 1
  
	smallestValue = arToSort( sortBy, c )
	smallestIndex = c
	
	For d = c + 1 To uBound( arToSort, 2 ) - 1 
	  if not compareDates then
		if strComp( arToSort( sortBy, d ), smallestValue ) < 0 Then
		  smallestValue = arToSort( sortBy, d )
		  smallestIndex = d
		End if
	  
	  else
		if not isDate( smallestValue ) then
		  arraySort = arraySort( arToSort, sortBy, false)
		  exit function
	  
		else
		  if dateDiff( "d", arToSort( sortBy, d ), smallestValue ) > 0 Then
			smallestValue = arToSort( sortBy, d )
			smallestIndex = d
		  End if
	  
		end if
	  
	  end if
	  
	Next
	
	if smallestIndex <> c Then 'swap
	  For e = 0 To uBound( arToSort, 1 )
		tempValue = arToSort( e, smallestIndex )
		arToSort( e, smallestIndex ) = arToSort( e, c )
		arToSort( e, c ) = tempValue
	  Next
	End if
  
  Next
  arraySort = arToSort

 End function
 
'==============================================
function delete_item( item_selected )
 	For Each strKeyname in Request.Cookies("splat") 
	  if Request.Cookies("splat")(strKeyname) <> "" then

		cart_string= Request.Cookies("splat")(strKeyname)
		Cart_items=Split(cart_string,"|",-1,0)
 		if item_selected = strKeyname then
			Response.Cookies("splat")(strKeyname) = ""
			exit for
	  	end if
	  end if
	Next 

 End function


function get_order_id()
UC_OrderIdSessionVar = "orderid"
UC_OrderDetails = "orderid"
If IsNumeric(Session(UC_OrderIdSessionVar)) Then
Else
  ' Get a unique OrderID number and save to session.
  UC_tableName = "UniqueOrderID"
  UC_fieldName = "NextOrderID"
  UC_sql = "select " & UC_fieldName & " from " &  UC_tableName
  tmp = "ADODB.Recordset"
  set UC_rsId = Server.CreateObject(tmp)
  UC_rsId.ActiveConnection = MM_dbConnect_String
  UC_rsId.Source = UC_sql
  UC_rsId.CursorType = 0	' adOpenForwardOnly
  UC_rsId.CursorLocation = 2 ' adUseServer
  UC_rsId.LockType = 2 ' adLockPessimistic
  UC_rsId.Open
  Session(UC_OrderIdSessionVar) = UC_rsId.Fields(UC_fieldName).value
  UC_rsId.Fields(UC_fieldName).value = Session(UC_OrderIdSessionVar) + 1
  UC_rsId.Update
  UC_rsId.Close
  set UC_rsId = Nothing
End If
 End function
  %>
