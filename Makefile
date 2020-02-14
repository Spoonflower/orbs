orb=new
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
