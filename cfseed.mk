# Need include environment settings. ex) include environ/$(environ).mk

######## MUST SETTINGS ########
STACK ?= CFSeed
S3_BUCKET_NAME ?= CFSeed
S3_BUCKET_PATH ?= $(environ)
REGION ?= us-east-1
###############################

ENVIRON ?= environ
TEMPLATES ?= templates
PARAMETERS ?= parameters

S3_BUCKET ?= s3://$(S3_BUCKET_NAME)
S3_TEMPLATE_URI ?= $(S3_BUCKET)/$(S3_BUCKET_PATH)/$(TEMPLATES)
S3_TEMPLATE_URL ?= https://s3.amazonaws.com/$(S3_BUCKET_NAME)/$(S3_BUCKET_PATH)/$(TEMPLATES)
TEMPLATE_DIR ?= $(CURDIR)/$(TEMPLATES)

ROOT_TEMPLATE_URL ?= $(S3_TEMPLATE_URL)/up.yml
STOP_TEMPLATE_URL ?= $(S3_TEMPLATE_URL)/down.yml
CHANGE_SET_NAME ?= commit-`git show --quiet --pretty=format:"%H"`
CAPABILITIES_OPTION ?= --capabilities CAPABILITY_NAMED_IAM

CLOUDFORMATION ?= aws cloudformation --region $(REGION)
S3_UPLOAD_TEMPLATES ?= aws s3 sync $(TEMPLATE_DIR)/ $(S3_TEMPLATE_URI) --acl authenticated-read


.DEFAULT_GOAL := help


.PHONY: bucket
bucket:

	aws s3 mb $(S3_BUCKET) --region $(REGION)



.PHONY: sync
sync:

	$(S3_UPLOAD_TEMPLATES)



.PHONY: stack
stack:
	@# Create a stack.

	$(CLOUDFORMATION) create-stack --stack-name $(STACK) --template-url $(ROOT_TEMPLATE_URL) $(CAPABILITIES_OPTION)



.PHONY: status
status:
	@## [query=QUERY]
	@# Display status of the stack.

	@$(CLOUDFORMATION) describe-stack-events --stack-name $(STACK)



.PHONY: resources
resources:
	@## [query=QUERY]
	@# Display resources of the stack.

	@$(CLOUDFORMATION) describe-stack-resources --stack-name $(STACK)



.PHONY: change-set
change-set:
	@# Create a change set.

	$(S3_UPLOAD_TEMPLATES)
	aws cloudformation --region $(REGION) create-change-set --stack-name $(STACK) \
		--template-url $(ROOT_TEMPLATE_URL)  \
		--change-set-name $(CHANGE_SET_NAME)



.PHONY: change-set-list
change-set-list:
	@# List change sets

	aws cloudformation --region $(REGION) list-change-sets --stack-name $(STACK)


.PHONY: change-set-show
change-set-show:
	@# Desplay the change set.


	aws cloudformation --region $(REGION) describe-change-set --stack-name $(STACK) \
		--change-set-name $(CHANGE_SET_NAME)


.PHONY: change-set-clear
change-set-clear:
	@# Clear the change set.


	aws cloudformation --region $(REGION) delete-change-set --stack-name $(STACK) \
		--change-set-name $(CHANGE_SET_NAME)


.PHONY: apply
apply:

	aws cloudformation --region $(REGION) execute-change-set --stack-name $(STACK) \
		--change-set-name $(CHANGE_SET_NAME)


.PHONY: up
up:

	$(S3_UPLOAD_TEMPLATES)
	aws cloudformation --region $(REGION) update-stack --stack-name $(STACK) \
		--template-url $(ROOT_TEMPLATE_URL)



.PHONY: down
down:

	$(S3_UPLOAD_TEMPLATES)
	aws cloudformation --region $(REGION) update-stack --stack-name $(STACK) --template-url $(STOP_TEMPLATE_URL)


.PHONY: balse
balse:
	@# Delete stack and configurations

	aws cloudformation delete-stack --stack-name $(STACK)
	aws s3 rm $(S3_TEMPLATE_URI) --recursive
	aws s3 rb $(S3_BUCKET)



.PHONY: help
help:
	@# Display usage.

	@unmake $(MAKEFILE_LIST)
