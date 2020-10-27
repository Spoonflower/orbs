orb=new
AWS_ACCOUNT_ID:=$(shell aws sts get-caller-identity | jq -r '.Account')

image:
	docker build -t spoonflower/circleci docker

push:
	docker push spoonflower/circleci:latest

new:	
	mkdir $(orb)
	cp new/orb.yml $(orb)/orb.yml
	circleci orb validate $(orb)/orb.yml
	circleci orb create spoonflower/$(orb)
	circleci orb publish $(orb)/orb.yml spoonflower/$(orb)@dev:first

test:
	circleci orb validate $(orb)/orb.yml

publish:
	circleci orb publish $(orb)/orb2.yaml spoonflower/$(orb)@dev:first

promote:
	circleci orb publish promote spoonflower/$(orb)@dev:first patch

.PHONY: new
