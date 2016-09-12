<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="restrict.asp" -->
<!--#include file="./Connections/dbConnect.asp" -->
<% Session("Order_ID") = Request.QueryString("OrderID") %>
<% Session("Order_Date") = Request.QueryString("OrderDate")%>

<!--#
' These Functions to be moved into a separate Module 
 -->

<SCRIPT RUNAT=SERVER LANGUAGE=VBSCRIPT NAME="UC_CART">

function DoNumber(str,nDigitsAfterDecimal,nLeadingDigit,nUseParensForNeg,nGroupDigits)
    DoNumber = FormatNumber(str,nDigitsAfterDecimal,nLeadingDigit,nUseParensForNeg,nGroupDigits)
End Function

function DoCurrency(str,nDigitsAfterDecimal,nLeadingDigit,nUseParensForNeg,nGroupDigits)
    DoCurrency = FormatCurrency(str,nDigitsAfterDecimal,nLeadingDigit,nUseParensForNeg,nGroupDigits)
End Function

</SCRIPT>
<%
Function DateString(DateVal, Abbreviate)
Dim intDate, strDay, strMonth, strYear

    intDate  = Day(DateVal)
    strYear  = Year(DateVal)
    
    if Abbreviate Then
        strMonth = MonthName(Month(DateVal), True)
        DateString = intDate & " " & MonthName(Month(DateVal), True) & " " & strYear
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

        DateString  = strDay & " " & intDate & suffix & " " & strMonth & ", " & strYear
    End If
End Function
%>

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
' Define Table Variables
Dim TableRows, TableIndex, RowTotal, OrderTotal
TableRows = -1
TableIndex = 0
RowTotal = 0
OrderTotal = 0

%>
<%
RsProds_numRows = RsProds_numRows + Repeat1__numRows
%>

<%
Dim RsOrderHistory__Param
RsOrderHistory__Param = "1"
 if (Request.QueryString("OrderID") <> "") then RsOrderHistory__Param = Request.QueryString("OrderID")
%>
<%
set RsOrderHistory = Server.CreateObject("ADODB.Recordset")
RsOrderHistory.ActiveConnection = MM_dbConnect_String
RsOrderHistory.Source = "SELECT * FROM OrderDetails WHERE OrderID = '" + RsOrderHistory__Param +"'"
RsOrderHistory.CursorType = 0
RsOrderHistory.CursorLocation = 2
RsOrderHistory.LockType = 3
RsOrderHistory.Open()
RsOrderHistory_numRows = 0
%>
<%
Dim RSOrder__Param
RSOrder__Param = "1"
 if (Request.QueryString("OrderID") <> "") then RSOrder__Param = Request.QueryString("OrderID")
%>
<%
set RSOrder = Server.CreateObject("ADODB.Recordset")
RSOrder.ActiveConnection = MM_dbConnect_String
RSOrder.Source = "SELECT * FROM Orders WHERE OrderID = '" + RSOrder__Param +"'"
RSOrder.CursorType = 0
RSOrder.CursorLocation = 2
RSOrder.LockType = 3
RSOrder.Open()
RSOrder_numRows = 0
%>
<%
Dim Contact
If RSOrder.Fields.Item("OrderAddressFlag").Value = 1 Then
      set RSAddress = Server.CreateObject("ADODB.Recordset")
      RSAddress.ActiveConnection = MM_dbConnect_String
      RSAddress.Source = "SELECT * FROM OrderAddress WHERE ID = " + RSOrder__Param +""
      RSAddress.CursorType = 0
      RSAddress.CursorLocation = 2
      RSAddress.LockType = 3
      RSAddress.Open()
      RSAddress_numRows = 0
      Contact = RSAddress.Fields.Item("Delivery_Contact").Value
Else
  If RSOrder.Fields.Item("Address").Value <>"" Then
        set RSAddress = Server.CreateObject("ADODB.Recordset")
        RSAddress.ActiveConnection = MM_dbConnect_String
        RSAddress.Source = "SELECT * FROM Address WHERE ID = " + RSOrder.Fields.Item("Address").Value +""
        RSAddress.CursorType = 0
        RSAddress.CursorLocation = 2
        RSAddress.LockType = 3
        RSAddress.Open()
        RSAddress_numRows = 0
        Contact = RSAddress.Fields.Item("Delivery_Contact").Value
 Else
  
      set RSAddress = Server.CreateObject("ADODB.Recordset")
      RSAddress.ActiveConnection = MM_dbConnect_String
      RSAddress.Source = "SELECT * FROM customer_address WHERE userid = '" + Session("MM_Username") +"'"
      RSAddress.CursorType = 0
      RSAddress.CursorLocation = 2
      RSAddress.LockType = 3
      RSAddress.Open()
      RSAddress_numRows = 0
      Contact = RSAddress.Fields.Item("contact").Value
 End If
 
End If
%>
 
<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->

<!--#include file="header_menu.asp" -->


<section id="fh5co-product-section" class="section">
    <div class="container">
        <div class="col-md-12 ">
            <h1>Order History</h1>
            <p></p>
        </div>
    </div>
    <div class="container">
        
        <% If RsOrderHistory.EOF Then ' relog on session                  %>
            <div class="col-md-12"><p >No details of the order were saved. </p></div>
        <% Else     %>
            <div class="col-md-2 col-sm-2 col-xs-12"> <b>Order: </b> </div>
            <div class="col-md-10 col-sm-10 col-xs-12">WS <% = Session("Order_ID")%>  Ordered on: <%=DateStringUK((RSOrder.Fields.Item("datestamp").Value),True)%>  </div>
            <div class="col-md-2 col-sm-2 col-xs-12"> <b>Contact: </b> </div>
            <div class="col-md-10 col-sm-10 col-xs-12"> <%= Contact %> </div>
            <div class="col-md-2 col-sm-2 col-xs-12"> <b>Address: </b> </div>
            <div class="col-md-10 col-sm-10 col-xs-12"> 
                <%=(RSAddress.Fields.Item("Delivery_Address").Value)%>, <%=(RSAddress.Fields.Item("Delivery_Suburb").Value)%>, <%=(RSAddress.Fields.Item("Delivery_Postcode").Value)%><br />
                <%=(RSAddress.Fields.Item("Delivery_Country").Value)%>, <%=(RSAddress.Fields.Item("Delivery_State").Value)%> 
            </div>
            <div class="col-md-2 col-sm-2 col-xs-12"> <b>Amount: </b> </div>
            <div class="col-md-10 col-sm-10 col-xs-12"> Total $<%= RSOrder.Fields.Item("Total").Value %>  Delivery:  $<%= RSOrder.Fields.Item("Delivery").Value%>  </div>
            <div class="col-md-2 col-sm-2 col-xs-12"> <b>Comment: </b> </div>
            <div class="col-md-10 col-sm-10 col-xs-12"> <%= RSOrder.Fields.Item("Comment").Value %> &nbsp; </div>
            <div class="col-md-2 col-sm-2 col-xs-12"> <b>Status: </b> </div>
            <div class="col-md-10 col-sm-10 col-xs-12"> <%= RSOrder.Fields.Item("Status").Value %></div>
        <% End If   %> 
    </div>
    <div class="container">
        <div class="divider"></div>
    </div>
    <div class="container">
        <table class="table">
            <thead>
                <tr>
                  <th>Code</th>
                  <th>Custom</th>
                  <th>Colour</th>
                  <th>Size</th>
                  <th>Qty</th>
                  <th class="text-right">Price A$ </th>
                  <th class="text-right">Total A$ </th>
                </tr>
            </thead>
            <tbody>
                <% While ((TableRows <> 0 ) AND (NOT RsOrderHistory.EOF))%>  
                    <tr>     
                        <td colspan="7">
                            <%=(RsOrderHistory.Fields.Item("Description").Value)%>
                            <% If (RsOrderHistory.Fields.Item("NamePrinted").Value <> "") Then %>
                            &nbsp;&nbsp;&nbsp;<strong>Name Printed:</strong> <%=(RsOrderHistory.Fields.Item("NamePrinted").Value)%>
                            <% End If %>
                        </td>
                    </tr>
                    <tr> 
                        <td ><%=(RsOrderHistory.Fields.Item("Prod_Code").Value)%></td>
                        <td><%=(RsOrderHistory.Fields.Item("Custom").Value)%></td>
                        <td><%=(RsOrderHistory.Fields.Item("Colour").Value)%></td>
                        <td><%=(RsOrderHistory.Fields.Item("Sizes").Value)%></td>
                        <td><%=(RsOrderHistory.Fields.Item("Quantity").Value)%></td>
                        <td class="text-right"> 
                            <%=FormatCurrency((RsOrderHistory.Fields.Item("PriceInc").Value),2,-2,-2,-2)%>
                        </td>                        <% 
                        RowTotal=0
                        RowTotal=(FormatCurrency((RsOrderHistory.Fields.Item("PriceInc").Value)*(RsOrderHistory.Fields.Item("Quantity")),2,-2,-2,-2))
                        OrderTotal = OrderTotal+RowTotal       %>
                        <td class="text-right"><%=RowTotal%></td>
                    </tr>   <%
                    TableIndex=TableIndex+1
                    TableRows=TableRows-1
                    RsOrderHistory.MoveNext() 
                Wend%>
            </tbody>
        </table>
        <div class="col-md-12 col-sm-12 col-xs-12 text-right">
            <b>Order Total: <%=FormatCurrency((OrderTotal),2,-2,-2,-2)%> </b>
        </div>
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
