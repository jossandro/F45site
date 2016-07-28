<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="restrict.asp" -->

<!--#include file="../Connections/dbConnect.asp" -->
<%
Dim RSProduct__MMColParam
RSProduct__MMColParam = "1"
If (Request.QueryString("Category") <> "") Then 
  RSProduct__MMColParam = Request.QueryString("Category")
End If
%>

<!-- =========  FILTERS CONTROLER ================ -->
<%
Function NewDict() 
    Set NewDict = Server.CreateObject("Scripting.Dictionary")
End Function

Function Count(ary)
    If IsArray(ary) Then
        Count = UBound(ary) - LBound(ary) + 1
    Else
        Count = vbEmpty
    End If
End Function

Function ParseStrUrl(params, fieldName) 
    Dim strColors, objColors
    Set objColors = NewDict()
    strColors = "AND ( " + fieldName + " LIKE '%"
    For Each color In params
        if not objColors.Exists(color) and len(color) > 0 then
            if strColors <> "AND ( " + fieldName + " LIKE '%" then
                strColors = strColors & "%' OR " + fieldName + " LIKE '%" & color     
            else
                strColors = strColors & color
            end if
            objColors.add color, NewDict()
        end if
    Next
    strColors = strColors & "%')"
    ParseStrUrl = strColors
End Function

Function ParseObjUrl(params) 
    Dim objColors
    Set objColors = NewDict()
    For Each color In params
        if(not objColors.Exists(color)) then
            objColors.add color, NewDict()
        end if
    Next
    set ParseObjUrl = objColors
End Function

Dim colorsStr, sizesStr
colorsStr = ParseStrUrl(Request("color"),"p.Colour")
set colorsObj = ParseObjUrl(Request("color"))
sizesStr = ParseStrUrl(Request("size"),"p.Sizes")
set sizesObj = ParseObjUrl(Request("size"))

%>
<!-- =========  END filters controler ================ -->


<%
Dim RSProduct
Dim RSProduct_numRows
Dim RSProduct_qtd
Dim nPageCount
Dim nPage
Dim strProductSelect
Dim filterColorOpen
Dim filterSizeOpen
Dim filterColorIsOpen
Dim filterSizeIsOpen

filterColorOpen = ""
filterSizeOpen = ""
filterColorIsOpen = "false"
filterSizeIsOpen = "false"

Set RSProduct = Server.CreateObject("ADODB.Recordset")
RSProduct.ActiveConnection = MM_dbConnect_STRING
'RSProduct.Source = "SELECT * FROM extend_products WHERE Cat_ID = " + Replace(RSProduct__MMColParam, "'", "''") + " ORDER BY listp, Description ASC"

strProductSelect = "SELECT ep.*, p.lgimage FROM extend_products ep INNER JOIN products p ON p.ID = ep.ID "
strProductSelect = strProductSelect & " WHERE ep.Cat_ID = " + Replace(RSProduct__MMColParam, "'", "''") + " "
if colorsObj.Count > 0 then
    strProductSelect = strProductSelect & colorsStr
    filterColorOpen = " in"
    filterColorIsOpen = "true"
end if
if sizesObj.Count > 0 then
    strProductSelect = strProductSelect & sizesStr
    filterSizeOpen = " in"
    filterSizeIsOpen = "true"
end if
strProductSelect = strProductSelect & " ORDER BY listp, Description ASC "
'RSProduct.Source = "SELECT ep.*, p.lgimage FROM extend_products ep INNER JOIN products p ON p.ID = ep.ID WHERE ep.Cat_ID = " + Replace(RSProduct__MMColParam, "'", "''") + " ORDER BY listp, Description ASC"
RSProduct.Source = strProductSelect
RSProduct.CursorLocation = 3
'response.Write strProductSelect
RSProduct.Open()

RSProduct_qtd = RSProduct.RecordCount
RSProduct_numRows = 0

' Set the page size of the recordset
RSProduct.PageSize = 8   ' nItemsPerPage
' Get the number of pages
nPageCount = RSProduct.PageCount

nPage = CLng(Request.QueryString("page"))
If nPage < 1 Or nPage > nPageCount Then
    nPage = 1
End If

%>
<%
Dim Repeat1__numRows
Repeat1__numRows = -1
Dim Repeat1__index
Repeat1__index = 0
RSProduct_numRows = RSProduct_numRows + Repeat1__numRows
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



'=========== Joey's selects and objects =======================

Set RSColor = Server.CreateObject("ADODB.Recordset")
RSColor.ActiveConnection = MM_dbConnect_STRING
RSColor.Source = "SELECT DISTINCT p.Colour FROM extend_products ep INNER JOIN products p ON p.ID = ep.ID WHERE ep.Cat_ID = " + Replace(RSProduct__MMColParam, "'", "''") + " ORDER BY p.Colour"
RSColor.CursorType = 0
RSColor.CursorLocation = 2
RSColor.LockType = 1
RSColor.Open()

Set RSSize = Server.CreateObject("ADODB.Recordset")
RSSize.ActiveConnection = MM_dbConnect_STRING
RSSize.Source = "SELECT DISTINCT p.Sizes FROM extend_products ep INNER JOIN products p ON p.ID = ep.ID WHERE ep.Cat_ID = " + Replace(RSProduct__MMColParam, "'", "''") + " ORDER BY p.Sizes"
RSSize.CursorType = 0
RSSize.CursorLocation = 2
RSSize.LockType = 1
RSSize.Open()
Dim SizeTempArray 
Dim SizeArray(100)
Dim position 
position = 0
While (NOT RSSize.EOF)                
    SizeTempArray = split(RSSize.Fields.Item("Sizes").Value, ",")
    for each size in SizeTempArray
        if(not in_array(size, SizeArray)) then
            SizeArray(position) = size 
            position = position + 1
        end if    
    next
    RSSize.MoveNext()
Wend


Set RSCategory = Server.CreateObject("ADODB.Recordset")
RSCategory.ActiveConnection = MM_dbConnect_STRING
RSCategory.Source = "SELECT * from category where Cat_ID = " + Replace(RSProduct__MMColParam, "'", "''") 
RSCategory.CursorType = 0
RSCategory.CursorLocation = 2
RSCategory.LockType = 1
RSCategory.Open()



Function in_array(element, arr)
  in_array = False
  For i=0 To Ubound(arr)
     If Trim(arr(i)) = Trim(element) Then
        in_array = True
        Exit Function      
     End If
  Next
End Function
%>



<!DOCTYPE html>
<!--[if lt IE 7]>      <html class="no-js lt-ie9 lt-ie8 lt-ie7"> <![endif]-->
<!--[if IE 7]>         <html class="no-js lt-ie9 lt-ie8"> <![endif]-->
<!--[if IE 8]>         <html class="no-js lt-ie9"> <![endif]-->
<!--[if gt IE 8]><!--> <html class="no-js"> <!--<![endif]-->

<!--#include file="header_menu.asp" -->

<section id="fh5co-products-section" class="section">

    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <h6>MEN /</h6>
            </div>
            <div class="col-md-6">
                <h6><%=RSProduct_qtd  %> ITENS</h6>
            </div>
        </div>
    </div>
    <div class="container" style="padding: 0">
        <div class="divider" style="margin: 0 0 5rem 0"></div>
    </div>
    <div class="container">
        <div class="row">
            <div class="col-md-2">
                <div class="row">
                    <div class="pull-left">
                       <h3><%=(RSCategory.Fields.Item("categorys").Value)%></h3>
                    </div>
                </div>
                <div class="row">
                    <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                        <!-- <div class="panel">
                            <div class="panel-heading" role="tab" id="headingOne">
                                <h4 class="panel-title">
                                    <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="false" aria-controls="collapseOne">
                                        Refine
                                        <span class="icon-plus pull-right"></span>
                                    </a>
                                </h4>
                            </div>
                            <div id="collapseOne" class="panel-collapse collapse " role="tabpanel" aria-labelledby="headingOne">
                                <div class="panel-body">
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" value="option1">
                                            All types
                                        </label>
                                    </div>
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" value="option1">
                                            Workouts
                                        </label>
                                    </div>
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" value="option1">
                                            Functional 45
                                        </label>
                                    </div>
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" value="option1">
                                            Playoffs
                                        </label>
                                    </div>
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" value="option1">
                                            Seasonal
                                        </label>
                                    </div>
                                    <div class="checkbox">
                                        <label>
                                            <input type="checkbox" value="option1">
                                            New Arrivals
                                        </label>
                                    </div>
                                </div>
                            </div>
                        </div> -->

                        <div class="panel">
                            <div class="panel-heading" role="tab" id="headingTwo">
                                <h4 class="panel-title">
                                    <a role="button" data-toggle="collapse" href="#collapseTwo" aria-expanded="<%=filterColorIsOpen%>" aria-controls="collapseTwo">
                                        Colour
                                        <!-- <span class="icon-plus pull-right"></span> -->
                                    </a>
                                </h4>
                            </div>
                            <div id="collapseTwo" class="panel-collapse collapse <%=filterColorOpen %>" role="tabpanel" aria-labelledby="headingTwo">
                                <div class="panel-body"> <%
                                While (NOT RSColor.EOF)                                %>
                                    <div class="checkbox">
                                        <label>     <%
                                            dim ch
                                            if colorsObj.exists(RSColor.Fields.Item("Colour").Value) then
                                                ch = " checked "
                                            Else
                                                ch = " "
                                            end if      %>
                                            <input type="checkbox" class="ckbcolor" value='<%=(RSColor.Fields.Item("Colour").Value)%>'   <%=ch%>  >
                                            <%=(RSColor.Fields.Item("Colour").Value)%>
                                        </label>
                                    </div>        <%
                                    RSColor.MoveNext()
                                Wend
                                %>
                                </div>
                            </div>
                        </div>

                        <div class="panel">
                            <div class="panel-heading" role="tab" id="headingThree">
                                <h4 class="panel-title">
                                    <a role="button" data-toggle="collapse" href="#collapseThree" aria-expanded="<%=filterSizeIsOpen%>" aria-controls="collapseThree">
                                        Size
                                        <!-- <span class="icon-plus pull-right"></span> -->
                                    </a>
                                </h4>
                            </div>
                            <div id="collapseThree" class="panel-collapse collapse <%=filterSizeOpen %>" role="tabpanel" aria-labelledby="headingThree">
                                <div class="panel-body">
                                <%
                                For i=0 To Ubound(SizeArray)
                                    if(len(SizeArray(i)) > 0 ) then    %>
                                    <div class="checkbox">
                                        <label>
                                            <%
                                            dim ch2
                                            if sizesObj.exists(SizeArray(i)) then
                                                ch2 = " checked "
                                            Else
                                                ch2 = " "
                                            end if
                                            %>
                                            <input type="checkbox" class="ckbsize" value='<%=SizeArray(i)%>'  <%=ch2%> >
                                            <%=SizeArray(i)%>
                                        </label>
                                    </div>
                                <%  end if
                                next
                                %>
                                </div>
                            </div>
                        </div>



                    </div>
                </div>
            </div>
            <div class="col-md-10">
                <!-- <div class="row">
                    <div class="pull-right">
                        <nav>
                            <ul class="pagination">
                                <li>
                                    <a href="#" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                                <li><a href="#">1</a></li>
                                <li><a href="#">2</a></li>
                                <li><a href="#">3</a></li>
                                <li><a href="#">4</a></li>
                                <li><a href="#">5</a></li>
                                <li>
                                    <a href="#" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </div> -->
                <div class="row">       <%
                    Dim col_count
                    col_count = 0 
                    
                    RSProduct.AbsolutePage = nPage
                    Do While Not ( RSProduct.Eof Or RSProduct.AbsolutePage <> nPage )
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
                            <figure >
                                <img class="img-responsive" style="max-width:100%;" src="../databases/images/<%=(RSProduct.Fields.Item("lgimage").Value)%>" alt="">
                            </figure>
                            <p class="item-name"><%=prodName%></p>
                            <p class="item-category"><small><%=(ucase(left(Cat_title,1)) & lcase(mid(Cat_title,2)))%></small></p>
                            <p class="item-price">$<%=(RSProduct.Fields.Item("PriceInc").Value)%> <span class="icon-star-half-empty pull-right"></span></p>
                            </a>
                        </div>      <%

                        RSProduct.MoveNext
                    Loop

                    %>
                </div>
            </div>
        </div>
        
        <div class="container">
            <div class="row">
                <div class="col-md-6 col-md-offset-3 text-center">      <%
                    Dim strPath
                    Dim strQueryString
                    Dim strFullUrl
                    Dim nextpaginactive
                    Dim prevpaginactive

                    strPath= Request.ServerVariables("SCRIPT_NAME") 
                    strQueryString= Request.ServerVariables("QUERY_STRING")

                    if(nPage < nPageCount) then
                        strNextPageUrl = "page="& nPage + 1
                    else
                        strNextPageUrl = "page="& nPage    
                        nextpaginactive = " paginactive"
                    end if
                    
                    if(nPage > 1) then
                        strPrevPageUrl = "page="& nPage - 1
                    else
                        strPrevPageUrl = "page="& nPage    
                        prevpaginactive = " paginactive"
                    end if
                    dim strfind
                    strfind = "page="& nPage
                    If Len(strQueryString) > 0 Then
                        if( Len(Request.QueryString("Page")) > 0 ) then
                            strNextUrl = strPath & "?" & replace(strQueryString, strfind, strNextPageUrl)
                            strPrevUrl = strPath & "?" & replace(strQueryString, strfind, strPrevPageUrl)
                        else
                            strNextUrl = strPath & "?" & strQueryString & "&" & strNextPageUrl
                            strPrevUrl = strPath & "?" & strQueryString & "&" & strPrevPageUrl
                        end if
                    else 
                       strNextUrl = strPath & "?" & strNextPageUrl
                       strPrevUrl = strPath & "?" & strPrevPageUrl
                    End If

                    %>
                    <!--                     
                    ' First page
                    Response.Write "<A HREF=""results.asp?Keyword=" & Keyword & "&Page=1"">First Page</A>"
                    ' Previous page:
                    Response.Write "<A HREF=""results.asp?Keyword=" & Keyword & "&Page=" & nPage - 1 & """>Prev. Page</A>"
                    ' Next page
                    Response.Write "<A HREF=""results.asp?Keyword=" & Keyword & "&Page=" & nPage + 1 & """>Next Page</A>"
                    ' Last page
                    Response.Write "<A HREF=""results.asp?Keyword=" & Keyword & "&Page=" & nPageCount & """>Last Page</A>"
                    ' 15th page:
                    Response.Write "<A HREF=""results.asp?Keyword=" & Keyword & "&Page=15"">15th Page</A>"
                     -->
                    <a class="btn btn-filters <%=prevpaginactive%>" href="<%=strPrevUrl %>">< PREV</a>
                    <a class="btn btn-filters <%=nextpaginactive%>" href="<%=strNextUrl %>">NEXT ></a>
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