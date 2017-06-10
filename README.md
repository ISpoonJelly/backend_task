# The Stack
The stack consists of several docker containers as follows

* A web app built in rails that handles bugs and
consists of simple models that represents Bugs and
States(The state of the device the bug was created on).
* A Postgres database container.
* A RabbitMQ message queuing service container.
* An Elasticsearch container.

Communication between containers are done using container links.


# Running
To start the whole stack execute:
```
docker-compose up
```

# Testing

## Posting
For Testing the POST /bugs end point we can execute:
```
curl -X POST \
  http://localhost:3000/bugs/ \
  -H 'content-type: application/json' \
  -d '{
	"appToken": "[appToken]",
	"status": "[status]",
	"priority": "[priority]",
	"comment": "[comment]",
	"state": {
		"device": "[device_name]",
		"os": "[device_os]",
		"memory": "[device_memory]",
		"storage": "[device_storage]"
	}
}'

where [status] can be one of [fresh, in_progress, closed]
and [priority] can be one of [minor, major, critical]
```

## Getting
For Testing the GET /bugs end point we can either execute:
```
curl -X GET http://localhost:3000/bugs/
```
which will get a full list of bugs.

or we can execute:
```
curl -X GET http://localhost:3000/bugs/[bug_number]?appToken=[appToken]
```
which will get us a specific bug.

## Searching
We can invoke the searching end-point to search for a specific query, like:
```
curl -X GET http://localhost:3000/bugs/search?q=major
```
will return all the bugs with priority of 'major', or maybe some bug that has a comment
containing the word 'major'(case-insensitive).

We can also use the search end-point for multi term queries, like:
```
curl -X GET http://localhost:3000/bugs/search?q=fresh in_progress
```
will return all the bugs with status of either 'fresh' or 'in_progress'.
