-----------------------------------------------------------
1. ) Créer un user
-----------------------------------------------------------

CREATE (Mahmut:User {id:'Mahmut', name:'Mahmut'})


-----------------------------------------------------------
2. ) Attribuer des preferences
-----------------------------------------------------------

MATCH (Mahmut:User),(m1:Movie)
WHERE Mahmut.name = "Mahmut" AND m1.title = "James Bond"
CREATE (Mahmut)-[r:LIKES]->(m1)
RETURN r;


Music:

MATCH (Mahmut:User),(m7:Music)
WHERE Mahmut.name = "Mahmut" AND m7.title = "Requiem"
CREATE (Mahmut)-[r:LIKES]->(m7)
RETURN r;

Livre:

MATCH (Mahmut:User),(b:Book)
WHERE Mahmut.name = "Mahmut" AND b.title = "Le Petit Prince"
CREATE (Mahmut)-[r:LIKES]->(b)
RETURN r;

Sport:

MATCH (Mahmut:User),(s:Sport)
WHERE Mahmut.name = "Mahmut" AND s.title = "Football"
CREATE (Mahmut)-[r:LIKES]->(s)
RETURN r;



-----------------------------------------------------------
3. ) Creer 2 messages avec un autre utilsateur existant (envoi, reception) BODY "texte"
-----------------------------------------------------------


CREATE (msg1:Message {id:70, body:'texte'}) ,
(msg2:Message {id:71, body:'Hello world'})
RETURN msg1, msg2;


MATCH (Aline:User),(m:Message), (Marc:User), (m2:Message)
WHERE Aline.name = "Aline" AND m.id = 70 AND Marc.name = "Marc" AND m2.id = 71
CREATE (Aline)-[r:SENT]->(m)<-[z:REPLY_TO]-(m2)<-[y:SENT]-(Marc)
RETURN r,z,y;


4. ) Identifier le leader d opinion principale




API REST:


POST http://localhost:7474/db/data/cypher
Accept: application/json; charset=UTF-8
Content-Type: application/json


{
  "query" : "START n=node(*) MATCH (u:User)-[r:SENT]->(m:Message)
RETURN u, r, count(r)
ORDER BY count(r)
LIMIT 10",
  "params" : {
    "startName" : "I",
    "name" : "you"
  }
}



a) Nombre de relation follows

MATCH (u:User)-[r:FOLLOWS]->(z:User)
WITH u, count(z) as nbrfol, collect(z) as users
RETURN u,nbrfol,users
ORDER by nbrfol DESC limit 1; -- si on souhaite le MAX de message envoyé par une personne

--> Le nombre de FOLLOWS MAX = 4 par Charle

b) Nombre de message créé par un utilsateur

MATCH (u:User)-[r:SENT]->(z:Message)
WITH u, count(z) as nbrmes, collect(z) as messages
RETURN u,nbrmes,messages;
ORDER BY nbrmes DESC LIMIT 1; --Si on veut la personne qui a le plus de  messages envoyés


--> RESULTAT MAX ELINE = 22 mesages envoyés


c) nbr de forward max

MATCH (u:Message)<-[r:FORWARD]-(z:Message)
WITH u, count(z) as nbrfor, collect(z) as messages
RETURN u,nbrfor,messages

--> RESULTAT MAX forword message 10 forwardé 3 fois et envoyé par ELISE


a) API REST 

POST http://localhost:7474/db/data/cypher
Accept: application/json; charset=UTF-8
Content-Type: application/json
{
  "query" : "MATCH (u:User)-[r:FOLLOWS]->(z:User)
WITH u, count(z) as nbrfol, collect(z) as users
RETURN u,nbrfol,users",
}

b) API REST


POST http://localhost:7474/db/data/cypher
Accept: application/json; charset=UTF-8
Content-Type: application/json
{
  "query" : "MATCH (u:User)-[r:SENT]->(z:Message)
WITH u, count(z) as nbrmes, collect(z) as messages
RETURN u,nbrmes,messages;
ORDER BY nbrmes DESC LIMIT 1",
}

c) API REST 

POST http://localhost:7474/db/data/cypher
Accept: application/json; charset=UTF-8
Content-Type: application/json
{
  "query" : "MATCH (u:Message)<-[r:FORWARD]-(z:Message)
WITH u, count(z) as nbrfor, collect(z) as messages
RETURN u,nbrfor,messages",
}

-- Elise est le leader de l opinion principale. Son message a été forwardé 3 fois.
-- Marc est lui aussi un leader du fait qu'il a le plus  d'abonnés.



5) Identifier 2 utilisaeur Points communs, creer relation know

	MATCH (p:User)-[l:LIKES]->(z)<-(p)
	WITH u, count(z) as nbrlikes, collect(z) as item
	RETURN u,nbrlikes,item
	
	
	-- Olivier et Laura
	
MATCH (Olivier:User),(Laura:User)
WHERE Olivier.name = "Olivier" AND Laura.name = "Laura"
CREATE (Mahmut)<-[r:KNOWS]->(LAURA)
RETURN r;
	
