<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="restrict.asp" -->
<!--#include file="process_order_functions.asp" -->
<!--#include file="../Connections/dbConnect.asp" -->
<%
  Response.Buffer = True
  Response.ExpiresAbsolute = Now() - 1
  Response.Expires = -6000
  Response.CacheControl = "no-cache"
%>
<%
get_order_id()

UC_updateAction = CStr(Request("URL"))



' Delete item
If (Request("code") <> "") Then 
    delete_item((Request("code")))
End If
%>

<% 

%> 

<%
Dim RSAddress__MMColParam
RSAddress__MMColParam = "1"
If (Session("MM_Username") <> "") Then 
  RSAddress__MMColParam = Session("MM_Username")
End If
%><%
Dim RSAddress
Dim RSAddress_cmd
Dim RSAddress_numRows

Set RSAddress_cmd = Server.CreateObject ("ADODB.Command")
RSAddress_cmd.ActiveConnection = MM_dbConnect_STRING
RSAddress_cmd.CommandText = "SELECT Customer_ID as customers_ID, Client_ID, Cust_Name, Account, Phone, Fax, Store_Address, Store_Suburb, Store_State, Store_Country, Store_Postcode, contact, email, userid, passwd, enable, Address_ID, Delivery_Contact, Delivery_Address, Delivery_Suburb, Delivery_State, Delivery_Country, Delivery_Postcode, Delivery_Phone, Delivery_Name FROM customer_address WHERE [userid] = ? ORDER BY Address_ID ASC" 
RSAddress_cmd.Prepared = true
RSAddress_cmd.Parameters.Append RSAddress_cmd.CreateParameter("param1", 200, 1, 50, RSAddress__MMColParam) ' adVarChar

Set RSAddress = RSAddress_cmd.Execute
RSAddress_numRows = 0
%>
<%
Dim Repeat1__numRows
Dim Repeat1__index

Repeat1__numRows = -1
Repeat1__index = 0
RSAddress_numRows = RSAddress_numRows + Repeat1__numRows
%>


<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->

<!--#include file="header_menu.asp" -->
<% 
Dim str_Promo_StartDate
Dim str_Promo_EndDate
Dim str_Promo_Disc
str_Promo_Disc = RSClient1.Fields.Item("Promo_Disc").Value

        promo_applied = false
        Promo_StartDate = RSClient1.Fields.Item("Promo_StartDate").Value
         Promo_EndDate = RSClient1.Fields.Item("Promo_EndDate").Value
        
       If str_Promo_Disc <> "" then
          str_Promo_Disc = ""  ' clear value just in case date is not valid
          If (Promo_StartDate <> "") and (Promo_StartDate <> "          ") then 
            str_Promo_StartDate = split(Promo_StartDate, "-")
            Promo_StartDate = str_Promo_StartDate(1) & "/" & str_Promo_StartDate(0) & "/" & str_Promo_StartDate(2) 
          
            If (Promo_EndDate <> "") and (Promo_EndDate <> "          ") then 
                str_Promo_EndDate =  split(RSClient1.Fields.Item("Promo_EndDate").Value,"-" )
                Promo_EndDate = str_Promo_EndDate(1) & "/" & str_Promo_EndDate(0) & "/" & str_Promo_EndDate(2) 
         
'       response.Write(" Promo_StartDate " + Promo_StartDate)
'       response.Write(" Promo_EndDate " + Promo_EndDate)
                If (Isdate(Promo_StartDate)) then
                    '(Isdate(RSClient1.Fields.Item("Promo_EndDate").Value)) then
                    '   response.Write(" is date " )
                    Promo_EndData = CDate(Promo_EndDate)
                    current_date = CDate(FormatDateTime(now(),2))
                    'response.Write(current_date)
                    If (CDate(Promo_StartDate) <= current_date) and (CDate(Promo_EndDate) >= current_date) Then
                        '       response.Write(" within date " )

                        str_Promo_Disc = RSClient1.Fields.Item("Promo_Disc").Value  ' set it up
                        Promo_Disc = Cint(RSClient1.Fields.Item("Promo_Disc").Value)
                        promo_applied = true ' promotion code can be applied.
                    End If
                End If
            End If
            
          End If
        End If
 %>

<section id="fh5co-product-section" class="section">



    <!-- <div class="container">
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
    </div> -->
    <div class="container">
        <form name="form2" action="<%= UC_updateAction %>" method="post">
            <input type="hidden" value="" name="postcode" />
            <input type="hidden" value="" name="address" />
        </form>

        <form action="disclaimer.asp" method="post" name="form1" <% 
            If (validate)  Then %> 
            onSubmit="MM_validateForm(<%= validate_string %>);return document.MM_returnValue" 
            <% End If %> >
        <div class="panel panel-default panel-order">
            <div class="panel-heading">
                <div class="row">
                    <div class="col-md-1 col-sm-2 col-xs-12 order-img">  </div>
                    <div class="col-md-2 col-sm-2 col-xs-5 order-item">Product</div>
                    <div class="col-md-1 col-sm-2 col-xs-0 order-item">Code </div>
                    <div class="col-md-2 col-sm-2 col-xs-0 order-item">Custom</div>
                    <div class="col-md-1 col-sm-2 col-xs-0 order-item">Colour</div>
                    <div class="col-md-1 col-sm-2 col-xs-0 order-item">Size</div>
                    <div class="col-md-1 col-sm-2 col-xs-2 order-item">Qty  </div>
                    <div class="col-md-1 col-sm-2 col-xs-0 order-item">Price</div>
                    <div class="col-md-1 col-sm-2 col-xs-3 order-item">Total </div>
                    <div class="col-md-1 col-sm-2 col-xs-2 order-item">    </div>
                </div> 
            </div>
            <div class="panel-body" >   <% 
                Dim last_image
                Dim Delivery
                Dim total_items
                Dim price
                Dim qty
                Delivery = 0
                total_items = 0
                last_image = ""
                
                newarray = arraySort( buildarray(), 9, false )
                For j = 0 to UBound(newarray,2) -1       %>
                    <div class="row">
                        <div class="col-md-1 col-sm-2 col-xs-12 order-img"> <% ' image
                          If (last_image <> newarray(7,j)) Then 
                              last_image = newarray(7,j) %>
                              <img class="img-responsive center-block" src="../databases/images/<%= newarray(7,j) %>">    <% 
                          End If  %>
                            
                        </div>
                        <div class="col-md-2 col-sm-2 col-xs-5 order-item">
                            <p>
                                <b><%= newarray(4,j)  %>&nbsp;</b>
                                <% 'NamePrinted 
                                If (newarray(8,j)<>"") Then %>        &nbsp;
                                Name Printed: <%= newarray(8,j) %>
                                <% End If %>
                            </p>
                        </div>
                        <div class="col-md-1 col-sm-2 col-xs-0 order-item">
                            <p><%=newarray(2,j) %></p> 
                        </div>
                        <div class="col-md-2 col-sm-2 col-xs-0 order-item">
                            <p><%=newarray(5,j)%></p>
                        </div>
                        <div class="col-md-1 col-sm-2 col-xs-0 order-item">
                            <p><%=newarray(6,j) %></p>
                        </div>
                        <div class="col-md-1 col-sm-2 col-xs-0 order-item">
                            <p><%= newarray(3,j) %></p>
                        </div>  <%      
                        price = newarray(1,j)
                        qty = newarray(0,j)
                        total_items = total_items + (price*qty)   %> 
                        <div class="col-md-1 col-sm-2 col-xs-2 order-item">
                            <p><%=qty %></p>
                        </div>
                        <div class="col-md-1 col-sm-2 col-xs-0 order-item">
                            <p><%= FormatCurrency(price, 2, -2, -2, -2)  %></p>
                        </div>
                        <div class="col-md-1 col-sm-2 col-xs-3 order-item">
                            <p><%= FormatCurrency(price*qty, 2, -2, -2, -2) %></p>
                        </div>
                        <div class="col-md-1 col-sm-2 col-xs-2 order-item">
                            <a href="view_order.asp?code=<%= newarray(10,j) %><%= newarray(3,j) %><%= newarray(6,j) %><%= newarray(8,j) %>">
                                <img src="images/delete.svg" class="img-item-icon" alt="Delete Item" />
                            </a>
                        </div>
                    </div>        
                    <div class="container display-mobile" style="padding: 0">
                        <div class="divider" style="margin: 5px 0 5rem 0"></div>
                    </div>
                <% Next  %>
            </div>
            <div class="panel-footer">
                <%  
                If (Request("postcode") <> "") Then     
                    Session("postcode") = Request("postcode")
                    Delivery = get_delivery(total_items,Request("postcode"))
                Else 
                    If (Len(RSAddress.Fields.Item("Delivery_Postcode").Value) ) <> 4 Then
                        Session("postcode") = "4000"
                    else 
                        Session("postcode") = RSAddress.Fields.Item("Delivery_Postcode").Value
                    End If
                    Delivery = get_delivery(total_items,Session("postcode"))
                End If      %>
                <div class="row">      <% 
                    If promo_applied Then 
                        Promo_Disc = total_items * ( Promo_Disc / 100)    %>
                        <div class="col-sm-12 ">
                            <p class="pull-right">Promotional Discount Amount : <%= Promo_Disc %></p>
                        </div>      <% 
                        total_items = total_items - Promo_Disc
                    End If      %>
                    <div class="col-sm-12 ">
                        <p class="pull-right"> Delivery Cost (inc GST): <%= FormatCurrency(Delivery, 2, -2, -2, -2) %> </p>
                    </div>
                    <div class="col-sm-12 ">
                        <% total_items = total_items  + Delivery %>
                        <p class="pull-right">Order Total (inc GST): <%= FormatCurrency(total_items, 2, -2, -2, -2) %></p>
                    </div>  <%   
                    If promo_applied Then     %>
                        <div class="col-sm-12 ">
                            <p class="pull-right">Promotion Ends <%= RSClient1.Fields.Item("Promo_EndDate").Value %></p>
                        </div>  <% 
                    End If %>
                </div>
            </div>        
        </div>      <% 
        Dim validate_string
        Dim validate
        '   Response.Write(RSClient1.Fields.Item("client").Value)
        '   Response.Write(" P " & RSClient1.Fields.Item("purchase_order").Value)   
        '   Response.Write("B " & RSClient1.Fields.Item("building").Value)  
        '   Response.Write(" E " & RSClient1.Fields.Item("employee").Value )

        validate = false
        validate_string = ""
        If (RSClient1.Fields.Item("purchase_order").Value) Then 
            validate_string = "'purchase_order','','R'"
            validate =  true
        '   Response.Write(" P " & RSClient1.Fields.Item("purchase_order").Value)
        End if
        If (RSClient1.Fields.Item("building").Value) Then 
            if (validate) then 
                validate_string = validate_string & ",'building','','R'"
            else 
                validate_string = "'building','','R'"
            End if
        '   Response.Write("B " & RSClient1.Fields.Item("building").Value)
            validate =  true
        End if
        If (RSClient1.Fields.Item("employee").Value) Then 
            if (validate) then 
                validate_string = validate_string & ",'employee','','R'"
            else 
                validate_string = "'employee','Employee Name ','R'"
            End if
        '   Response.Write(" E " & RSClient1.Fields.Item("employee").Value )
            validate =  true
        End if
        ' Response.Write(" V " & validate_string )
        %>  

        <div class="row">
            <div class="col-md-12 col-sm-12 col-xs-12">
                
                    
                    <table class="table">
                        <thead class="thead-default">
                            <tr>
                                <th colspan="3"><p>Select your Delivery Address</p></th>
                            </tr>
                        </thead>
                        <tbody>     <% 
                            While ((Repeat1__numRows <> 0) AND (NOT RSAddress.EOF)) 
                                get_email = RSAddress.Fields.Item("email").Value  
                                get_address_id = RSAddress.Fields.Item("Address_ID").Value      %>
                                <tr>
                                    <td><input name="Address" type="radio" value="<%=(Cstr(RSAddress.Fields.Item("Address_ID").Value))%>" 
                                        <% 
                                        If (Request("postcode") = "") Then 
                                            If (Repeat1__index = 0) Then 
                                                %>checked<% 
                                            End If 
                                        Elseif (Cstr(Request("address")) = Cstr(RSAddress.Fields.Item("Address_ID").Value)) Then
                                            %>checked<% 
                                        End If 
                                        %> title="" onClick="postcode_change('<%=(RSAddress.Fields.Item("Delivery_Postcode").Value)%>','<%= get_address_id %>')">
                                    </td>
                                    <td><p><%=(RSAddress.Fields.Item("Delivery_Name").Value)%> <%=(RSAddress.Fields.Item("Delivery_Contact").Value)%></p></td>
                                    <td><p><%
                                        if (len(trim(RSAddress.Fields.Item("Delivery_Address").Value)) > 1 ) then
                                            response.Write(RSAddress.Fields.Item("Delivery_Address").Value & "<br />")
                                        end if
                                        if (len(trim(RSAddress.Fields.Item("Delivery_Suburb").Value)) > 1 ) then
                                            response.Write(RSAddress.Fields.Item("Delivery_Suburb").Value & "<br />")
                                        end if
                                        if (len(trim(RSAddress.Fields.Item("Delivery_Postcode").Value)) > 1 ) then
                                            response.Write(RSAddress.Fields.Item("Delivery_Postcode").Value & "<br />")
                                        end if
                                        if (len(trim(RSAddress.Fields.Item("Delivery_State").Value)) > 1 ) then
                                            response.Write(RSAddress.Fields.Item("Delivery_State").Value & " " & RSAddress.Fields.Item("Delivery_Country").Value & "<br />")
                                        end if
                                        if (len(trim(RSAddress.Fields.Item("Delivery_phone").Value)) > 1 ) then
                                            response.Write(RSAddress.Fields.Item("Delivery_phone").Value & "<br />")
                                        end if
                                        %></p>
                                    </td>
                                </tr><% 
                                Repeat1__index=Repeat1__index+1
                                Repeat1__numRows=Repeat1__numRows-1
                                RSAddress.MoveNext()
                            Wend    %>

                            <tr>
                                <td>
                                    <input name="Address" type="radio" value="7610"     <% 
                                    If (Cstr(Request("postcode")) = "9999" ) Then
                                        %>checked<% 
                                        Pickup = 1
                                    End If %> 
                                    title=""  onClick="postcode_change('9999','7610')" >
                                </td>
                                <td><p>NEXT DAY PICK UP  </p></td>
                                <td><p>
                                    Please pickup from <br>
                                    260-266 Cleveland Street Surry Hills <br>
                                    (enter via Little Buckingham Street Loading Dock) <br>
                                    Mon to Friday 8.30am to 5:00 pm.</p>
                                </td>
                            </tr>
                           
                        </tbody>
                    </table>
                        

                    </table>
                    
                    <div class="form-group">
                        <label for="purchase_order">Cost Centre / Purchase Order </label>
                        <input type="text" name="purchase_order" class="form-control" id="purchase_order" placeholder="Cost Centre / Purchase Order">
                    </div>
                    <div class="form-group">
                        <label for="building">Site / Building Name <% If (RSClient1.Fields.Item("building").Value) Then  %>*<%  End if %></label>
                        <input name="building" class="form-control" type="text" id="building"  />
                    </div>
                    <div class="form-group">
                        <label for="employee">This order is for (Enter name) <% If (RSClient1.Fields.Item("employee").Value) Then %>*<%  End if %></label>
                        <input name="employee" class="form-control" type="text" id="employee"  />
                    </div>
                    <div class="form-group">
                        <label for="comment">
                                Comments or additional information such as <strong>Delivery Instructions</strong>.<br>
                                Include your <strong>Purchase order</strong> if required to be  included on the invoice.
                        </label>
                        <textarea name="Comment" id="comment" class="form-control" cols="30" rows="10"></textarea>
                    </div>
                    <div class="form-group">
                        Email Address:  <%= get_email %><br />
                        To add additional addresses or correct your email address see &quot;<a href="updatecustomerinfo.asp">Update Profile</a>&quot;.
                    </div>
                    <button type="submit" class="btn btn-filters">Process Order</button>
                    <!-- <button type="submit" class="btn btn-filters">Register</button> -->
            </div>
        </div>

        <!-- ======== C O P Y ==============        -->

        <input type="hidden" name="user" value="<%= Session("svuser") %>" />
        <input type="hidden" name="refnumber" value="<%= Session("orderid") %>" />
        <input type="hidden" name="total_items" value="<%=total_items%>" />
        <input type="hidden" name="Total" value="<%=total_items%>" />
        <input type="hidden" name="Delivery" value="<%=Delivery%>" />
        <input type="hidden" name="promo_disc" value="<%=str_Promo_Disc%>" />
        <input type="hidden" name="Pickup" value="<%= Pickup %>" />
          
        </form>




        <!-- ===== end copy ============= -->

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

</body>
</html>