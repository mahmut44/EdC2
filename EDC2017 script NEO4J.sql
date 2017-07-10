1. ) 

CREATE (Mahmut:User {id:'Mahmut', name:'Mahmut'})

2. ) Attribuer des preferences

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


3. ) Creer 2 messages avec un autre utilsateur existant (envoi, reception) BODY "texte"



CREATE (msg1:Message {id:70, body:'texte'}) ,
(msg2:Message {id:71, body:'Hello world'})
RETURN msg1, msg2;


MATCH (Aline:User),(m:Message), (Marc:User), (m2:Message)
WHERE Aline.name = "Aline" AND m.id = 70 AND Marc.name = "Marc" AND m2.id = 71
CREATE (Aline)-[r:SENT]->(m)<-[z:REPLY_TO]-(m2)<-[y:SENT]-(Marc)
RETURN r,z,y;