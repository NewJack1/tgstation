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