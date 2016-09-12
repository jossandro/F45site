<%
' FileName="Connection_odbc_conn_dsn.htm"
' Type="ADO" 
' DesigntimeType="ADO"
' HTTP="false"
' Catalog=""
' Schema=""
Dim MM_dbConnect_STRING
    'MM_dbConnect_STRING = "dsn=jdmssql;uid=aztectec_jddbo;pwd=Garment1;Database=aztectec_jd"
'MM_dbConnect_STRING = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source="  & Server.Mappath("../databases/joseph.mdb")
'MM_dbConnect_STRING = "driver={SQL Server};Server=WIN-PCER735IH1O\SQLEXPRESS;Database=azjd;uid=f45user;pwd=user.918273"
'MM_dbConnect_STRING = "driver={SQL Server};Server=WIN-PCER735IH1O\SQLEXPRESS;Database=azjd;uid=aztectec_jddbo;pwd=Garment1"
MM_dbConnect_STRING = "driver={SQL Server};Server=WIN-PCER735IH1O\SQLEXPRESS;Database=jdf45;uid=aztectec_jddbo;pwd=Garment1"
'MM_dbConnect_STRING = "driver={SQL Server};Server=122.201.90.101\SQLSERVER;Database=aztectec_jdtest;uid=aztectec_jdtestdbo;pwd=Garment1"
'MM_dbConnect_STRING = "driver={SQL Server};Server=122.201.90.101\SQLSERVER;Database=aztectec_jd;uid=aztectec_jddbo;pwd=Garment1"
'MM_dbConnectSTRING = "Provider=SQLOLEDB;Network Library=DBMSSOCN;Data Source=122.201.90.101\SQLSERVER;Initial Catalog=aztectec_jd;User ID=aztectec_jddbo;Password=Garment1"
'MM_dbConnectSTRING = "Provider=SQLOLEDB;Network Library=DBMSSOCN;Data Source=WIN-PCER735IH1O\SQLEXPRESS;Initial Catalog=azjd;User ID=sa;Password=sadmin"

'MM_dbConnect_STRING = "Provider=SQLNCLI11;Server=WIN-PCER735IH1O\SQLEXPRESS;Database=azjd;uid=f45user;pwd=user.918273"
%>
