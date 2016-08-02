
If InStr(1, Request.ServerVariables("url") &"?"& Request.QueryString, RSMenu.Fields.Item("linkurl").Value) > 0 then
                        end if  

Request.ServerVariables("url")