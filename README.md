# Welcome to Napa

To create a check in:
curl -X POST -d user="Rose Tyler" -d business="Starbucks" http://localhost:9393/check_ins

To retrieve all check ins:
curl -X GET http://localhost:9393/check_ins

To retrieve the first check in:
curl -X GET http://localhost:9393/check_ins/1

To update a check in:
curl -X PUT -d business="Intelligentsia" http://localhost:9393/check_ins/1