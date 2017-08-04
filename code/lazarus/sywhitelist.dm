// Как это работает: надо лишь в нужном месте добавить проверку if(insywl(src.ckey)), и она будет проверять есть ли сикей в базе.
/*Схема базы whitelist:

| ckey |

:^)
*/
/client/verb/add_to_sywhitelist(syckey as text)
	set category = "Admin"
	set name = "Add to Syndicate Whitelist"
	if(access_sywhitelist())
		add_to_sywhitelist_DB(syckey)
	else
		return

/client/proc/add_to_sywhitelist_DB(syckeyDB)
	if(access_sywhitelist())
		var/datum/DBQuery/query_sywhitelist_insert = SSdbcore.NewQuery("INSERT INTO whitelist (ckey) VALUES ('[syckeyDB]')")
		query_sywhitelist_insert.Execute()
	else
		return

/client/verb/delete_from_sywhitelist(syckey as text)
	set category = "Admin"
	set name = "Delete from Syndicate Whitelist"
	if(access_sywhitelist())
		delete_from_sywhitelist_DB(syckey)
	else
		return

/client/proc/delete_from_sywhitelist_DB(syckeyDB)
	if(access_sywhitelist())
		var/datum/DBQuery/query_sywhitelist_delete = SSdbcore.NewQuery("DELETE FROM whitelist WHERE ckey == [syckeyDB]")
		query_sywhitelist_delete.Execute()
	else
		return

/client/verb/show_sywhitelist()
	set category = "Admin"
	set name = "Show Syndicate Whitelist"
	var/datum/DBQuery/query_sywhitelist_show = SSdbcore.NewQuery("SELECT ckey FROM whitelist")
	query_sywhitelist_show.Execute()
	var/dat = "<h1>Syndicate Members</h1><hr>"
	dat += {"<!DOCTYPE html>
	<html>
	<head>
	<style>
	body {
		background: #111;
		color: #ccc;
		font-family: sans-serif;
		font-size: 8pt;
	}
	table {
		background: #222;
		width: 570px;
	}
	tr {
		background: #1a1a1a;
	}
	td {
		padding: 3px 10px
	}
	</style>
	</head>
	<table align="center" width="600">"}
	dat += "<tr><td>ckey</td></tr>"
	while(query_sywhitelist_show.NextRow())
		dat += "<tr><td>[query_sywhitelist_show.item[1]]</td></tr>"
	dat += "</table>"
	var/datum/browser/popup_sywhitelist = new(usr, sanitize_russian("Syndicate Whitelist"), sanitize_russian("Syndicate Whitelist"), 600, 800)
	popup_sywhitelist.set_content(sanitize_russian(dat))
	popup_sywhitelist.open()
/proc/insywl(syckey)
	var/ckey
	var/datum/DBQuery/query_sywhitelist_check = SSdbcore.NewQuery("SELECT * FROM whitelist WHERE (ckey = '[syckey]')")
	query_sywhitelist_check.Execute()
	while(query_sywhitelist_check.NextRow())
		ckey = query_sywhitelist_check.item[1]
	if(ckey == syckey)
		return 1
	else
		return 0

/proc/access_sywhitelist()
	if(usr.ckey == "neincat" || usr.ckey == "redknighthero" || usr.ckey == "executivecancer" || usr.ckey == "cryptman")
		return 1
	else
		return 0