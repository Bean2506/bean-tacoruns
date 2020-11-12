ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('Reload_Tacoruns:add')
AddEventHandler('Reload_Tacoruns:add', function(type, amount, name)
	local xPlayer  = ESX.GetPlayerFromId(source)

	if type == 'money' then
		xPlayer.addMoney(amount)
		local society = (amount / 100)*15 
		TriggerEvent('esx_addonaccount:getSharedAccount', 'society_taco', function(account)
			account.addMoney(society)
		end)
	elseif type == 'item' then
		xPlayer.addInventoryItem(name, amount)
	end
end)

RegisterServerEvent('Reload_Tacoruns:remove')
AddEventHandler('Reload_Tacoruns:remove', function(type, amount, name)
	local xPlayer  = ESX.GetPlayerFromId(source)

	if type == 'money' then
		xPlayer.removeMoney(amount)
	elseif type == 'item' then
		xPlayer.removeInventoryItem(name, amount)
	end
end)

RegisterServerEvent('Reload_Tacoruns:check')
AddEventHandler('Reload_Tacoruns:check', function()
	local xPlayer  = ESX.GetPlayerFromId(source)
	local item = xPlayer.getInventoryItem(Config.Item).count
	local b = false
	if item > 0 then
		b = true
	end
	TriggerClientEvent('Reload_Tacoruns:check', b)
end)
ESX.RegisterServerCallback('Reload_Tacoruns:getPlayers', function(source,callback)
	local players = ESX.GetPlayers()
	callback(#players)
end)

RegisterServerEvent('Reload_Tacoruns:server')
AddEventHandler('Reload_Tacoruns:server', function()
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.get('money') >= Config.StartTaco then
		xPlayer.removeMoney(Config.StartTaco)
		
	else
		TriggerClientEvent('notification', xPlayer, 'You don\'t have enough money to start a run', 2)
	end
end)