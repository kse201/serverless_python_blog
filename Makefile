download_dynamodb:
	wget https://s3.ap-northeast-1.amazonaws.com/dynamodb-local-tokyo/dynamodb_local_latest.tar.gz
	tar xzvf dynamodb_local_latest.tar.gz

dynamodb_local:
	java -Djava.libary.path='./DynamoDBLocal_lib' -jar DynamoDBLocal.jar -sharedDb

init_db:
	python manage.py init_db

server:
	python server.py

iam:
	terraform apply

init_db_prod: iam
	SERVERLESS_BLOG_CONFIG=production \
						   SERVERLESS_AWS_ACCESS_KEY_ID=`terraform output -json | jq -r ".id.value"` \
						   SERVERLESS_AWS_SECRET_KEY=`terraform output -json | jq -r ".secret.value"` \
						   python manage.py init_db
