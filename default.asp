<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="restrict.asp" -->

<!--#include file="./Connections/dbConnect.asp" -->

<!--#include file="menu_top_db.asp" -->

<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->

<!--#include file="header_menu.asp" -->

<section class="owl-carousel owl-carousel1 owl-carousel-fullwidth fh5co-light-arrow animate-box" data-animate-effect="fadeIn">
    <!-- <div class="item"><a href="images/under-armour.jpg" class="image-popup"><img src="images/under-armour.jpg" alt="image"></a></div>
    <div class="item"><a href="images/nike-just-do-it.jpg" class="image-popup"><img src="images/nike-just-do-it.jpg" alt="image"></a></div> -->
    <div class="item"><a href="images/gym1.png" class="image-popup"><img src="images/gym1.png" alt="image"></a></div>
    <div class="item"><a href="images/guys2.png" class="image-popup"><img src="images/guys2.png" alt="image"></a></div>
    <div class="item"><a href="images/pic3.png" class="image-popup"><img src="images/pic3.png" alt="image"></a></div>
</section>


<section id="fh5co-products-section" class="section">
    <div class="container">
        <div class="row">
            <div class="col-md-12 text-center">
                <h2>Top Products</h2>
            </div>
            <!-- <div class="col-md-6 col-md-offset-3 text-center">
                <a class="btn btn-filters" href="#">Best Sellers</a>
                <a class="btn btn-filters" href="#">New Arrivals</a>
                <a class="btn btn-filters" href="#">Featured</a>
            </div> -->
        </div>
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
    Dim product_sql
    If Not MM_grantAccess Then
        product_sql = "SELECT TOP 12 ep.*, p.lgimage FROM extend_products ep INNER JOIN products p ON p.ID = ep.ID INNER JOIN category c ON ep.Cat_ID = c.Cat_ID WHERE c.client_ID = 111 ORDER BY NEWID() "
    else
        product_sql = "SELECT TOP 12 ep.*, p.lgimage FROM extend_products ep INNER JOIN products p ON p.ID = ep.ID INNER JOIN category c ON ep.Cat_ID = c.Cat_ID WHERE c.client_ID = "&Session("client_ID")&" ORDER BY NEWID() "
    end if

    Set RSProduct = Server.CreateObject("ADODB.Recordset")
    RSProduct.ActiveConnection = MM_dbConnect_STRING
    'RSProduct.Source = "SELECT * FROM extend_products WHERE Cat_ID = " + Replace(RSProduct__MMColParam, "'", "''") + " ORDER BY listp, Description ASC"
    'RSProduct.Source = "SELECT top 12 * FROM products "            ' WHERE ep.Cat_ID = 300"
    RSProduct.Source =  product_sql  
    RSProduct.CursorType = 0
    RSProduct.CursorLocation = 2
    RSProduct.LockType = 1
    RSProduct.Open()

    RSProduct_numRows = 0
    %>

    <div class="container padding-top-60">
        <div class="row">   <% 
            While (NOT RSProduct.EOF)
                Cat_title = RSProduct.Fields.Item("Description").value       
                dim prodName
                If RSProduct.Fields.Item("Custom").Value <> "" Then 
                    prodName = trim(RSProduct.Fields.Item("Custom").Value)
                End If
                If RSProduct.Fields.Item("Custom_desc").Value <> "" Then 
                    prodName = prodName & trim(RSProduct.Fields.Item("Custom_desc").Value)
                End If
                if len(prodName) > 22 Then
                    prodName = left(prodName, 20) & "..."
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
                <div class="products col-md-3 ">        <!--   animate-box -->
                    <!-- <span class="featured sale"><small>Sale</small></span> -->
                    <%
                    If MM_grantAccess Then              %>
                        <a href="order.asp?ID=<%= RSProduct.Fields.Item("ID").Value %>&dept=<%= dept %>">
                    <% else %>
                        <a href="login.asp">
                    <% end if   %>
                        <figure>
                            <img class="img-responsive" src="http://www.josephdahdah.com.au/databases/images/<%=(RSProduct.Fields.Item("lgimage").Value)%>" alt="">
                        </figure>
                        <%
                        dim prodFirstName
                        prodFirstName = (ucase(left(Cat_title,1)) & lcase(mid(Cat_title,2)))
                        if len(prodFirstName) > 16 Then
                            prodFirstName = left(prodFirstName, 14) & "..."
                        end if
                        %>
                        <p class="item-name"><%=prodFirstName%></p>
                        <p class="item-category"><small><%=prodName%></small></p>
                        <p class="item-price"><%=FormatCurrency((RSProduct.Fields.Item("PriceInc").Value), 2, -2, -2, -2)%></p>
                    <%
                   If MM_grantAccess or true Then              %>
                    </a>
                <% end If       %>
                </div>      <%
                RSProduct.MoveNext()
            Wend
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
                        <form action="https://f45traininghq.createsend.com/t/t/s/ntydik/" method="post" id="subForm">
                            <input id="fieldbydtdt" name="cm-f-bydtdt" type="hidden" value="f45web">
                            <div class="col-md-12">
                                <span class="icon-envelope"></span><input name="cm-ntydik-ntydik" type="email" class="email-newsletter col-md-10" placeholder="Email">
                                <input type="submit" class="btn btn-newsletter col-md-2" value="Send">
                            </div>
                        </form>

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