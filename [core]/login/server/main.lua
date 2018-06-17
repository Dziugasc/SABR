-------------------------------  # C R O W N ---------------------------------
function login(username, password, checksave)
	if not (username == "") then
		if not (password == "") then
			local account = getAccount(username, password)
			if (account ~= false) then
				displayServerMessageLogin(source, "Successfully logged in", "confirm")
				logIn(source, account, password)
				triggerClientEvent(source, "removeLogin", getRootElement())
				if checksave == true then
					triggerClientEvent(source, "saveLoginToXML", getRootElement(), username, password)
				else
					triggerClientEvent(source, "resetSaveXML", getRootElement(), username, password)
				end
			else
				displayServerMessageLogin(source, "Incorrect username or password", "warning")--Incorrect username or password
			end
		else
			displayServerMessageLogin(source, "Type your password", "warning")---type your password
		end
	else
		displayServerMessageLogin(source, "Enter your username", "warning")--type username
	end
end
addEvent("login", true)
addEventHandler("login", getRootElement(), login)

function registrar(username, password)
	if not (username == "") then
		if not (password == "") then
			local account = getAccount(username, password)
			if (account == false) then
				local accountAdded = addAccount(tostring(username), tostring(password))
				if (accountAdded) then
					displayServerMessageLogin(source, "Login: "..username.."  |  password: "..password.."", "confirm")
				else
					displayServerMessageLogin(source, "Error, please try again", "warning")--Error, please try again
				end
			else
				displayServerMessageLogin(source, "This username already exists", "warning")--This username already exists
			end
		else
			displayServerMessageLogin(source, "type your password", "warning")--type your password
		end
	else
		displayServerMessageLogin(source, "Enter your username", "warning")--type username
	end
end
addEvent("registrar", true)
addEventHandler("registrar", getRootElement(), registrar)

function displayServerMessageLogin(source, message, type)
	triggerClientEvent(source, "servermessagesLogin", getRootElement(), message, type)
end
-------------------------------  # C R O W N ---------------------------------