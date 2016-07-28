<% 
               
Function CheckStringForSQL(str) 
  On Error Resume Next 
  Dim BlackList
	BlackList = Array("=","#","$","%","^","&","*","|",";",_
	                  "<",">","'","""","(",")",_
	                  "--", "/*", "*/", "@@",_
	                  "cursor","exec","execute",_
	                  "nchar", "varchar", "nvarchar", "iframe"_
	                  )
	'Note: We can include following keyword to make a stronger scan but it will also 
	'protect users to input these words even those are valid input
	'  "!", "char", "alter", "begin", "cast", "create", 
	 
  Dim lstr 
  ' If the string is empty, return false that means pass
  If ( IsEmpty(str) ) Then
    CheckStringForSQL = false
    Exit Function
  ElseIf ( StrComp(str, "") = 0 ) Then
    CheckStringForSQL = false
    Exit Function
  End If
  
  lstr = LCase(str)
  ' Check if the string contains any patterns in our black list
  For Each s in BlackList
    If ( InStr (lstr, s) <> 0 ) Then
      CheckStringForSQL = true
      Exit Function
    End If
  Next
  CheckStringForSQL = false
End Function 
 
  %>
