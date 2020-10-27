orb=new
AWS_ACCOUNT_ID:=$(shell aws sts get-caller-identity | jq -r '.Account')

image:
	docker build -t spoonflower/circleci .

push:
	ecr-login
	docker tag spoonflower/circleci:latest $(AWS_ACCOUNT_ID).dkr.ecr.us-east-1.amazonaws.com/base/ci:latest
	docker push $(AWS_ACCOUNT_ID).dkr.ecr.us-east-1.amazonaws.com/base/ci:latest

new:	
	mkdir $(orb)
	cp new/orb.yml $(orb)/orb.yml
	circleci orb validate $(orb)/orb.yml
	circleci orb create spoonflower/$(orb)
	circleci orb publish $(orb)/orb.yml spoonflower/$(orb)@dev:first

test:
	circleci orb validate $(orb)/orb.yml

publish:
	circleci orb publish $(orb)/orb.yml spoonflower/$(orb)@dev:first

promote:
	circleci orb publish promote spoonflower/$(orb)@dev:first patch

.PHONY: new
