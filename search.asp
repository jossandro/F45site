<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="restrict.asp" -->

<!--#include file="../Connections/dbConnect.asp" -->

<!--#include file="menu_top_db.asp" -->
<!--#include file="search_functions.asp" -->

<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->

<!--#include file="header_menu.asp" -->


<section id="fh5co-products-section" class="section">

    <div class="container">
        <div class="row">
            <form method="post" >
            <div class="col-md-12 text-center">
                <span class="icon-search"></span>
                <input type="text" name="q" class="search-input" placeholder="Search">
                <input type="submit" class="btn btn-filters" value="Ok">
            </div>
            </form>
        </div>
    </div>
    <div class="container" style="padding: 0">
        <div class="divider" style="margin: 45px 0 5rem 0"></div>
    </div>

    <%
    Dim RSProduct__MMColParam
    RSProduct__MMColParam = "1"
    If (Request.QueryString("Category") <> "") Then 
      RSProduct__MMColParam = Request.QueryString("Category")
    End If
    %>
    <%
    Dim RSProduct
    Dim RSProduct_numRows

    Set RSProduct = Server.CreateObject("ADODB.Recordset")
    RSProduct.ActiveConnection = MM_dbConnect_STRING

    Dim query
    Dim sqlCode
    query = ""
    sqlCode = "SELECT TOP 12 ep.*, p.lgimage FROM extend_products ep INNER JOIN products p ON p.ID = ep.ID INNER JOIN category c ON ep.Cat_ID = c.Cat_ID WHERE c.client_ID = 99 ORDER BY NEWID() "
    'and CheckStringForSQL(Request.Form("q"))
    If (len(Request.Form("q")) > 2 ) Then 
      query = 
      query = Replace(Request.Form("q"),"'"," ")
      sqlCode = "SELECT ep.*, p.lgimage FROM extend_products ep INNER JOIN products p ON p.ID = ep.ID INNER JOIN category c ON ep.Cat_ID = c.Cat_ID WHERE c.client_ID = 99 AND (ep.expr1 like '%"+query+"%' OR ep.Description like '%"+query+"%' OR ep.custom like '%"+query+"%' OR ep.custom_desc like '%"+query+"%' ) ORDER BY listp, Custom ASC"
    End If

    RSProduct.Source = sqlCode

    RSProduct.CursorType = 0
    RSProduct.CursorLocation = 3
    RSProduct.LockType = 1
    RSProduct.Open()

    RSProduct_numRows = 0
    %>

    <div class="container padding-top-60">
        <div class="row">   <% 
        if RSProduct.RecordCount > 0 then
            While (NOT RSProduct.EOF)
                Cat_title = RSProduct.Fields.Item("Description").value       
                dim prodName
                If RSProduct.Fields.Item("Custom").Value <> "" Then 
                    prodName = trim(RSProduct.Fields.Item("Custom").Value)
                End If
                If RSProduct.Fields.Item("Custom_desc").Value <> "" Then 
                    prodName = prodName & trim(RSProduct.Fields.Item("Custom_desc").Value)
                End If
                if len(prodName) > 16 Then
                    prodName = left(prodName, 14) & "..."
                end if

                str = prodName
                str1 = ""
                arrStr = split(str," ")

                For i=0 to ubound(arrStr)
                    word = lcase(trim(arrStr(i)))
                    word = UCase(Left(word, 1)) &  Mid(word, 2)
                    str1 = str1 & word & " "
                next

                prodName = trim(str1)

                %>
                <div class="products col-md-3 animate-box">
                    <!-- <span class="featured sale"><small>Sale</small></span> -->
                    <a href="order.asp?ID=<%= RSProduct.Fields.Item("ID").Value %>&dept=<%= dept %>">
                        <figure>
                            <img class="img-responsive" src="../databases/images/<%=(RSProduct.Fields.Item("lgimage").Value)%>" alt="">
                        </figure>
                        <p class="item-name"><%=prodName%></p>
                        <p class="item-category"><small><%=(ucase(left(Cat_title,1)) & lcase(mid(Cat_title,2)))%></small></p>
                        <p class="item-price">$<%=(RSProduct.Fields.Item("PriceInc").Value)%></p>
                    </a>
                </div>      <%
                RSProduct.MoveNext()
            Wend
        else    %>
            <div class="col-md-12 ">
                <p>Your search for <%=query %> did not return any results.</p>
            </div>
        <%
        end if
            %>  
          
        </div>
    </div>

    <!-- <div class="container">
        <div class="row">
            <div class="col-md-6 col-md-offset-3 text-center">
                <a class="btn btn-filters" href="#">< PREV</a>
                <a class="btn btn-filters" href="#">NEXT ></a>
            </div>
        </div>
    </div> -->

</section><!-- end fh5co-intro-section -->


<section id="fh5co-essentials-section" class="section">
    <div class="container">
        <div class="col-md-12 text-center">
            <h2>Essentials</h2>
        </div>
        <div class="row">
            <div class="col-md-12">
                <div class="col-md-6 col-sm-6 animate-box essentials-box">
                    <div class="text-center">
                        <h1>Work basic Range</h1>
                    </div>
                </div>
                <div class="col-md-6 col-sm-6 animate-box essentials-box">
                    <div class="text-center">
                        <h1>Staff Uniform</h1>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section><!-- end fh5co-common-section -->


<section id="fh5co-newsletter-section">
    <div class="container">
        <div class="row">
            <div class="col-md-2 cols-sm-12">
                <h1>Newsletter</h1>
            </div>
            <div class="col-md-4 cols-sm-12">
                <!-- <p>If You Are Unable To Load Any Pages,</p>
                <p>Check Your Computer.</p> -->
            </div>
            <div class="col-md-6 cols-sm-12">
                <form action="">
                    <div class="row">
                        <div class="col-md-12">
                            <span class="icon-envelope"></span><input type="email" class="email-newsletter col-md-10" placeholder="Email">
                            <input type="submit" class="btn btn-newsletter col-md-2" value="Send">
                        </div>

                    </div>
                </form>
            </div>
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