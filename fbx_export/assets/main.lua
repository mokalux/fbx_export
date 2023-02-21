-- background
application:setBackgroundColor(0x777777)

function getFolderPathAndFileName(xmodelpath)
	local xpathlength = xmodelpath:len()
	local tmpfolder = xmodelpath:match("(.*[/\\])")
	local tmpfolderlength = tmpfolder:len()
	local xfinalfolder = tmpfolder:sub(1, tmpfolderlength-1)
	local xfinalfilewithext = xmodelpath:sub(-(xpathlength-tmpfolderlength))

	return xfinalfolder, xfinalfilewithext
end

function fbxToJson()
	-- don't forget to install vcruntimex86: https://www.microsoft.com/en-gb/download/details.aspx?id=48145
	local fbxconvexepath = application:getNativePath("fbx_conv/fbx-conv.exe")
	print("fbxconvexepath", fbxconvexepath) -- OK
	-- "/" -- for Qt, "\\" for win32
	local initpath = "c:\\"
	local path = application:get("openFileDialog", ".fbx FILE TO CONVERT", initpath, "Fbx (*.fbx)") -- title, path, extensions
	if path ~= nil then
		local finalfolder, finalfilewithext = getFolderPathAndFileName(path)
		local fbx = finalfilewithext
		local json = fbx:gsub(".fbx", ".json")
		local cmd =
			"start "..fbxconvexepath.." -f -v -o G3DJ "..
			"\""..finalfolder.."\\"..fbx.."\""..
			" "..
			"\""..finalfolder.."\\"..json.."\""
		print("cmd", cmd) -- OK
		os.execute(cmd) -- ERROR IF APP IS PUT IN A PATH WHICH HAS SPACE IN IT
--		os.execute("\""..cmd.."\"") -- ERROR IF APP IS PUT IN A PATH WHICH HAS SPACE IN IT
	end
end

-- some buttons
local btnopenimgfolder = ButtonTextP9UDDT.new({ text="open pictures folder", textscalex=3 })
local btnfbxtojson = ButtonTextP9UDDT.new({ text="convert fbx to json", textscalex=3 })
btnopenimgfolder:setPosition(200, 128)
btnfbxtojson:setPosition(200, 256)
-- order
stage:addChild(btnopenimgfolder)
stage:addChild(btnfbxtojson)
-- listeners
btnopenimgfolder:addEventListener("clicked", function()
	local function myfunc()
		os.execute("start "..application:get("directory", "pictures"))
	end
	Core.asyncCall(myfunc)
end)
btnfbxtojson:addEventListener("clicked", function()
--	Core.asyncCall(fbxToJson)
	fbxToJson()
end)
