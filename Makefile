orb=new
orbVersion=$(shell cat $(orb)/latest.txt || echo "")
randomVersion=$(shell echo $$(( $$RANDOM )))
ver=0
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

validate:
	echo $(randomVersion)
	circleci orb validate $(orb)/orb$(orbVersion).yml

publish: validate
	circleci orb publish $(orb)/orb$(orbVersion).yml spoonflower/$(orb)@dev:v$(randomVersion)

promote:
	circleci orb publish promote spoonflower/$(orb)@dev:v$(ver) patch

.PHONY: new
