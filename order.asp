<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="restrict.asp" -->

<!--#include file="../Connections/dbConnect.asp" -->
<%
UC_editAction = CStr(Request("URL"))
If (Request.QueryString <> "") Then
  UC_editAction = UC_editAction & "?" & Request.QueryString
End If

%>

<%
Dim RSProduct__MMColParam
RSProduct__MMColParam = "1"
If (Request.QueryString("ID") <> "") Then 
  RSProduct__MMColParam = Request.QueryString("ID")
End If
%>
<%
Dim RSProduct
Dim RSProduct_numRows

Set RSProduct = Server.CreateObject("ADODB.Recordset")
RSProduct.ActiveConnection = MM_dbConnect_STRING
RSProduct.Source = "SELECT * FROM products WHERE ID = " + Replace(RSProduct__MMColParam, "'", "''") + ""
RSProduct.CursorType = 0
RSProduct.CursorLocation = 2
RSProduct.LockType = 1
RSProduct.Open()

RSProduct_numRows = 0
%>
<%
UC_OrderIdSessionVar = "orderid"
UC_OrderDetails = "orderid"
If Session(UC_OrderIdSessionVar)="" Then
  ' Get a unique OrderID number and save to session.
  UC_tableName = "UniqueOrderID"
  UC_fieldName = "NextOrderID"
  UC_sql = "select " & UC_fieldName & " from " &  UC_tableName
  tmp = "ADODB.Recordset"
  set UC_rsId = Server.CreateObject(tmp)
  UC_rsId.ActiveConnection = MM_dbConnect_String
  UC_rsId.Source = UC_sql
  UC_rsId.CursorType = 0    ' adOpenForwardOnly
  UC_rsId.CursorLocation = 2 ' adUseServer
  UC_rsId.LockType = 2 ' adLockPessimistic
  UC_rsId.Open
  Session(UC_OrderIdSessionVar) = UC_rsId.Fields(UC_fieldName).value
  UC_rsId.Fields(UC_fieldName).value = Session(UC_OrderIdSessionVar) + 1
  UC_rsId.Update
  UC_rsId.Close
  set UC_rsId = Nothing
End If
%>
<% 
DIM cart
Dim Message
Dim Qty
Dim item_number
item_number = ""
cart = ""
Message = ""
next_order = 1
If (request("UC_recordId") <> "" ) Then 
    
    If (Request.Cookies("order") <> "") then
        next_order = Request.Cookies("order") + 1
    End If  
    Response.Cookies("order") = next_order

Dim qtdUrl
qtdUrl = CLng(Request.Form("Quantity"))

  cart = cart & qtdUrl & "|"   ' 0
  Qty = qtdUrl
  Message = Request.Form("Description")
  cart = cart & Request.Form("PriceInc") & "|"  ' 1
  cart = cart & Request.Form("Prod_Code") & "|" '2
  cart = cart & Request.Form("Size") & "|" '3
  cart = cart & Request.Form("Description") & "|" '4
  cart = cart & Request.Form("Custom") & "|" '5
  cart = cart & Request.Form("Colour") & "|" '6
  cart = cart & Request.Form("image") & "|" '7
  cart = cart & Request.Form("NamePrinted") & "|" '8
  cart = cart & Request.Form("PackSize") & "|" '9
  cart = cart & Request.Form("UC_recordId") & "|" '10
  cart = cart & next_order  '11

  item_number = request("UC_recordId") & Request.Form("Size") & Request.Form("Colour") & Request.Form("NamePrinted")
    Response.Cookies("splat")(item_number) = cart
End If

%>

<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->


<!--#include file="header_menu.asp" -->
<style type="text/css">
.toast-center-center {
    top: 50%;
    right: auto;
    width: 100%;
}

</style>

<section id="fh5co-product-section" class="section">



    <div class="container">
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
    </div>
    <div class="container">
        <div class="row">
            <div class="col-md-6 col-sm-6 col-xs-12">
                <div class="row">
                    <div class="product col-md-9 col-sm-9 col-xs-12 animate-box">
                        <figure>
                            <img class="img-responsive center-block" src='../databases/images/<%=(RSProduct.Fields.Item("lgimage").Value)%>' alt='<%=(RSProduct.Fields.Item("Description").Value)%>'>
                        </figure>
                    </div>
                </div>
            </div>

            <div class="col-md-4 col-md-offset-1 col-sm-6 col-xs-12">
                <div class="row">
                    <span class="featured"><small></small></span>
                    <p class="item-name"><a href="#"><%=(RSProduct.Fields.Item("Description").Value)%></a></p>
                    <p class="item-code"><small>Code: <%=(RSProduct.Fields.Item("Prod_Code").Value)%></small></p>
                    <p class="item-desctiption"> <small>   <% 
                    Dim product_text
                    DIM i 
                    Dim p_description

                    product_text = RSProduct.Fields.Item("comments").Value
                    if product_text <> ""  then 
                        p_description = Split(product_text,vbCr,-1,0)
                        i= 0
                        Do While i<=UBound(p_description)
                            if(len(trim(p_description(i))) > 1) then
                                response.Write(p_description(i) + "<br>")
                            end if
                        i=i+1
                        Loop
                    End if
                      %></small>
                    </p>   
                    <p class="item-price"><% If RSClient1.Fields.Item("International").Value Then %>US <% End If %></b> <%= FormatCurrency((RSProduct.Fields.Item("PriceInc").Value), 2, -2, -2, -2) %> </p>     <!--  <span class="icon-star-half-empty pull-right"></span> -->
                </div>
            <!-- </div>

            <div class="col-md-4 col-md-offset-1 col-sm-6 col-xs-12"> -->
                <div class="row">
                    <form class="form-horizontal" action="<%=UC_editAction%>" method="post" name="form1" onSubmit="MM_validateForm('quantity','','RisNum');return document.MM_returnValue" >
                        <div class="form-group">
                            <% 
                            strCol=RSProduct("Custom")
                            if not (IsNull(strCol) or strCol="") then %>
                                <label for="inputCustom" class="col-sm-4 control-label">Custom</label>
                                <div class="col-sm-8">
                                    <select class="form-control" id="inputCustom" name="Custom">    <%  
                                    myarray=split(strCol,",")
                                    for p=0 to ubound(myarray)
                                        response.write "<option>" & trim(myarray(p)) & "</option>" & vbcrlf
                                    next     %>
                                    </select>
                                </div>
                            <% End If %>
                            <label for="inputSize" class="col-sm-4 control-label">Size</label>
                            <div class="col-sm-8">
                                <select class="form-control" id="inputSize" name="Size">
                                    <% 
                                    strCol=RSProduct("Sizes")
                                    if not (IsNull(strCol) or strCol="") then
                                        myarray=split(strCol,",")
                                        for p=0 to ubound(myarray)
                                            response.write "<option>" & trim(myarray(p)) & "</option>" & vbcrlf
                                        next
                                    end if
                                    %>
                                </select>
                            </div>
                            <label for="inputColor" class="col-sm-4 control-label">Color</label>
                            <div class="col-sm-8">
                                <select class="form-control" id="inputColor" name="Colour">
                                    <% 
                                    strCol=RSProduct("Colour")
                                    if not (IsNull(strCol) or strCol="") then
                                        myarray=split(strCol,",")
                                        for p=0 to ubound(myarray)
                                            response.write "<option>" & trim(myarray(p)) & "</option>" & vbcrlf
                                        next
                                    end if
                                    %>
                                </select>
                            </div>

                            <label for="inputQuantity" class="col-sm-4 control-label">Quantity</label>
                            <div class="col-sm-8">
                                <!-- <textarea class="form-control" rows="3" id="inputQuantity"></textarea> -->
                                <input class="form-control" name="quantity" type="text" id="inputQuantity"  />
                            </div>
                            <% 
                            strCol=RSProduct("NamePrinted")
                            if  (strCol)  Then %>  
                                <label for="inputSize" class="col-sm-4 control-label">Name to be Printed:</label>
                                <div class="col-sm-8">
                                    <input class="form-control" type="text" name="NamePrinted"  >
                                </div>
                            <% End If %> 

                            <button type="submit" class="btn btn-filters">Submit</button>
                        </div>
                        <input type="hidden" name="PriceInc" value="<%= RSProduct.Fields.Item("PriceInc").Value %>">
                        <input type="hidden" name="PackSize" value="<%= RSProduct.Fields.Item("PackSize").Value %>">
                        <input type="hidden" name="Prod_Code" value="<%= RSProduct.Fields.Item("Prod_Code").Value %>">
                        <input type="hidden" name="Description" value="<%= RSProduct.Fields.Item("Description").Value %>">
                        <input type="hidden" name="UC_recordId" value="<%= RSProduct.Fields.Item("ID").Value %>">
                        <input type="hidden" name="image" value="<%= RSProduct.Fields.Item("smimage").Value %>">    
                    </form> 
                </div>
            </div>

        </div>
        <div class="row">
            <div class="com-md-12">
                 <% 
                    strCol  = RSClient1.Fields.Item("download_chart").Value  
                    if (strCol <> "") Then %>
                      <p class="item-size-chart"><small>Size Chart  <a href="../databases/downloads/<%= strCol %>" target="chart">click here</a></small></p>
                    <% End If %>
            </div>
        </div>

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

<script language="JavaScript" type="text/JavaScript">
<% If cart <> "" Then %>
    $(document).ready(function(){

        toastr.options = {
                "closeButton": true,
                "debug": false,
                "newestOnTop": false,
                "progressBar": false,
                "positionClass": "toast-top-full-width",
                "preventDuplicates": false,
                "onclick": null,
                "showDuration": "300",
                "hideDuration": "1000",
                "timeOut": "5000",
                "extendedTimeOut": "1000",
                "showEasing": "swing",
                "hideEasing": "linear",
                "showMethod": "fadeIn",
                "hideMethod": "fadeOut"
        }

        toastr.success("<%=Message %><br>Order added to Cart", "Process Order <%=Qty %>")
        //toastr.success('Have fun storming the castle!', 'Miracle Max Says');

    });
    
<% End If %>

</script> 

</body>
</html>