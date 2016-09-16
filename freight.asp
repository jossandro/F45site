<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="restrict.asp" -->
<!--#include file="./Connections/dbConnect.asp" -->

<%
Dim RSClient__MMColParam
RSClient__MMColParam = "111"
If (Session("client_ID") <> "") Then 
  RSClient__MMColParam = Session("client_ID")
End If
%>
<%
Dim RSClient
Dim RSClient_numRows

Set RSClient = Server.CreateObject("ADODB.Recordset")
RSClient.ActiveConnection = MM_dbConnect_STRING
RSClient.Source = "SELECT freight FROM client WHERE client_ID = " + Replace(RSClient__MMColParam, "'", "''") + ""
RSClient.CursorType = 0
RSClient.CursorLocation = 2
RSClient.LockType = 1
RSClient.Open()

RSClient_numRows = 0
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
            <h2>Freight</h2>

            <p>
                <% 
                Dim page_text
                DIM i 
                Dim p_description

                page_text = (RSClient.Fields.Item("freight").Value)
                if page_text <> ""  then 
                    p_description = Split(page_text,vbCr,-1,0)
                    i= 0
                    Do While i<=UBound(p_description)
                        response.Write(p_description(i) + "<br>")
                        i=i+1
                    Loop
                End if 
                %>
            </p>
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