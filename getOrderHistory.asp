<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="restrict.asp" -->
<!--#include file="./Connections/dbConnect.asp" -->

<%
Function DateStringUK(DateVal, Abbreviate)
Dim intDate, intMonth, strDay, strMonth, strYear

    intDate  = Day(DateVal)
    intMonth = Month(DateVal)
    strYear  = Year(DateVal)
    
    if Abbreviate Then
        strMonth = MonthName(Month(DateVal), True)
        DateStringUK = intDate & "/" & intMonth & "/" & strYear
    Else
        strMonth = MonthName(Month(DateVal))
        strDay   = WeekDayName(WeekDay(DateVal), False, vbSunday)

        Dim suffix
        suffix   = "th"
        Select Case intDate
            case 1,21,31 : suffix = "st"
            case 2,22    : suffix = "nd"
            case 3,23    : suffix = "rd"
        End Select

        DateStringUK  = strDay & " " & intDate & suffix & " " & strMonth & ", " & strYear
    End If
End Function
%>

<%
Dim OrderHistorySummary__Param
OrderHistorySummary__Param = Session("svuser")
set OrderHistorySummary = Server.CreateObject("ADODB.Recordset")
OrderHistorySummary.ActiveConnection = MM_dbConnect_String
OrderHistorySummary.Source = "SELECT * FROM Orders WHERE UserID = '" + OrderHistorySummary__Param + "' ORDER BY (OrderID * 1) DESC"
OrderHistorySummary.CursorType = 0
OrderHistorySummary.CursorLocation = 2
OrderHistorySummary.LockType = 3
OrderHistorySummary.Open()
OrderHistorySummary_numRows = 0
%>
<%
Dim TableRows, TableIndex
TableRows = -1
TableIndex = 0

%>
<%
RsProds_numRows = RsProds_numRows + Repeat1__numRows
%>
<%
' *** Go To Record and Move To Record: create strings for maintaining URL and Form parameters

' create the list of parameters which should not be maintained
MM_removeList = "&index="
If (MM_paramName <> "") Then MM_removeList = MM_removeList & "&" & MM_paramName & "="
MM_keepURL="":MM_keepForm="":MM_keepBoth="":MM_keepNone=""

' add the URL parameters to the MM_keepURL string
For Each Item In Request.QueryString
  NextItem = "&" & Item & "="
  If (InStr(1,MM_removeList,NextItem,1) = 0) Then
    MM_keepURL = MM_keepURL & NextItem & Server.URLencode(Request.QueryString(Item))
  End If
Next

' add the Form variables to the MM_keepForm string
For Each Item In Request.Form
  NextItem = "&" & Item & "="
  If (InStr(1,MM_removeList,NextItem,1) = 0) Then
    MM_keepForm = MM_keepForm & NextItem & Server.URLencode(Request.Form(Item))
  End If
Next

' create the Form + URL string and remove the intial '&' from each of the strings
MM_keepBoth = MM_keepURL & MM_keepForm
if (MM_keepBoth <> "") Then MM_keepBoth = Right(MM_keepBoth, Len(MM_keepBoth) - 1)
if (MM_keepURL <> "")  Then MM_keepURL  = Right(MM_keepURL, Len(MM_keepURL) - 1)
if (MM_keepForm <> "") Then MM_keepForm = Right(MM_keepForm, Len(MM_keepForm) - 1)

' a utility function used for adding additional parameters to these strings
Function MM_joinChar(firstItem)
  If (firstItem <> "") Then
    MM_joinChar = "&"
  Else
    MM_joinChar = ""
  End If
End Function
%>

<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->

<!--#include file="header_menu.asp" -->
<script language="javascript">

function orderHistory() 
{
  location.href = "orderhistory.asp"
}

</script>

<section id="fh5co-product-section" class="section">
    <div class="container">
        <div class="col-md-12 ">
            <h1>Order History</h1>
            <p>Click on an Order Number below</p>
        </div>
    </div>
    <div class="container">
        <table class="table">
            <thead>
                <tr>
                  <th>#</th>
                  <th>Order Number:</th>
                  <th>Date Ordered:</th>
                </tr>
            </thead>
            <tbody>
                <%While ((TableRows <> 0) AND (NOT OrderHistorySummary.EOF))%>
                  <tr>
                    <th scope="row"><%=TableIndex+1%></th>
                    <td>
                      <a href="orderhistory.asp?<%= MM_keepNone & MM_joinChar(MM_keepNone) & "OrderID=" & OrderHistorySummary.Fields.Item("OrderID").Value %>">
                        <%=(OrderHistorySummary.Fields.Item("OrderID").Value)%>
                      </a>
                    </td>
                    <td>
                      <%= DateStringUK((OrderHistorySummary.Fields.Item("datestamp").Value),True)%>
                    </td>
                  </tr><% 
                  TableIndex=TableIndex+1
                  TableRows=TableRows-1
                  OrderHistorySummary.MoveNext()
                Wend             %>
            </tbody>
        </table>
    </div>

</section>

<!--#include file="footer.asp" -->

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
