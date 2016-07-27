<%
Dim RSCat__MMColParam
RSCat__MMColParam = "1"
If (Session("client_ID") <> "") Then 
  RSCat__MMColParam = Session("client_ID")
End If
%>
<%
Dim RSCat
Dim RSCat_numRows

Set RSCat = Server.CreateObject("ADODB.Recordset")
RSCat.ActiveConnection = MM_dbConnect_STRING
RSCat.Source = "SELECT * FROM category WHERE client_ID = " + Replace(RSCat__MMColParam, "'", "''") + " and Level = 0  ORDER BY description ASC"
RSCat.CursorType = 0
RSCat.CursorLocation = 2
RSCat.LockType = 1
RSCat.Open()

RSCat_numRows = 0
%>
<%
Dim Repeat5__numRows
Dim Repeat5__index

Repeat5__numRows = -1
Repeat5__index = 0
RSCat_numRows = RSCat_numRows + Repeat5__numRows
%>
<%
Dim RSClient1
Dim RSClient1_numRows

Set RSClient1 = Server.CreateObject("ADODB.Recordset")
RSClient1.ActiveConnection = MM_dbConnect_STRING
RSClient1.Source = "SELECT * FROM client WHERE client_ID = " + Replace(RSCat__MMColParam, "'", "''") + ""
RSClient1.CursorType = 0
RSClient1.CursorLocation = 2
RSClient1.LockType = 1
RSClient1.Open()

RSClient1_numRows = 0
%>
