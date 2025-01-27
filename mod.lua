function data()
return {
	info = {
		minorVersion = 0,
		severityAdd = "NONE",
		severityRemove = "WARNING",
		name = _("mod_name"),
		description = _("mod_desc"),
		authors = {
			{
				name = "ModWerkstatt",
				role = "CREATOR",
			},
		},
		tags = { "europe", "locomotive", "bundesbahn", "deutsche bahn", "electric", },
		minGameVersion = 0,
		dependencies = { },
		url = { "" },
        params = {
			{
				key = "br151_fake",
				name = _("br151_fake"),
				values = { "No", "Yes", },
				tooltip = _("option_fake_br151_desc"),
				defaultIndex = 0,
			},
			{
				key = "br151_vorspann",
				name = _("br151_vorspann"),
				values = { "No", "Yes", },
				tooltip = _("option_vorspann_br151_desc"),
				defaultIndex = 0,
			},
			{
				key = "br151_privatbahn",
				name = _("br151_privatbahn"),
				values = { "No", "Yes", },
				tooltip = _("option_privatbahn_br151_desc"),				
				defaultIndex = 1,
			},
        },
	},
	options = {
	},
	runFn = function (settings, modParams)
		
		local vorspannFilter = function(fileName, data)		
			if data.metadata.transportVehicle and data.metadata.br151 and data.metadata.br151.vorspann == true then				
				data.metadata.availability.yearFrom = 1
				data.metadata.availability.yearTo = 2
				--return false
			end	
			--return true
			return data
		end 
		
		local fakeFilter = function(fileName, data)		
			if data.metadata.transportVehicle and data.metadata.br151 and data.metadata.br151.fake == true then		
				data.metadata.availability.yearFrom = 1
				data.metadata.availability.yearTo = 2				
			end				
			return data
		end 
		
		local privatbahnFilter = function(fileName, data)		
			if data.metadata.transportVehicle and data.metadata.br151 and data.metadata.br151.privatbahn == true then			
				data.metadata.availability.yearFrom = 1
				data.metadata.availability.yearTo = 2				
			end				
			return data
		end 
		
		if modParams[getCurrentModId()] ~= nil then
			local params = modParams[getCurrentModId()]					
			if params["br151_vorspann"] == 0 then				
				--addFileFilter("model/transportVehicle", vorspannFilter)	
				addModifier("loadModel", vorspannFilter)
			end
			if params["br151_fake"] == 0 then				
				addModifier("loadModel", fakeFilter)
			end
			if params["br151_privatbahn"] == 0 then				
				addModifier("loadModel", privatbahnFilter)
			end
			
		else
			--addFileFilter("model/transportVehicle", vorspannFilter)			
			addModifier("loadModel", fakeFilter)
			addModifier("loadModel", privatbahnFilter)
		end			
	end
}
end
