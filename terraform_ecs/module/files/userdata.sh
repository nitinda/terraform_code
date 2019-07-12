#!/bin/bash
echo ECS_CLUSTER=${ECS_CLUSTER_NAME} >> /etc/ecs/ecs.config
echo ECS_BACKEND_HOST= >> /etc/ecs/ecs.config
echo ECS_LOGLEVEL=debug >> /etc/ecs/ecs.config
cat /etc/ecs/ecs.config

sudo yum install -y nfs-utils

# Updating the ECS agent
# yum update -y ecs-init

# Use this command if you want to support EBS as well as EFS
# docker plugin install --alias cloudstor:aws --grantall-permissions docker4x/cloudstor:18.06.1-ce-aws1 CLOUD_PLATFORM=AWS EFS_ID_REGULAR=${EFS_ID_REGULAR} AWS_REGION=eu-central-1 EFS_SUPPORTED=1 DEBUG=1

# Use this command if you only want to support EBS
docker plugin install --alias cloudstor:aws --grant-all-permissions docker4x/cloudstor:18.06.1-ce-aws1 CLOUD_PLATFORM=AWS AWS_REGION=eu-central-1 EFS_SUPPORTED=0 DEBUG=1

# Install SSM Agent
yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm

# Restart ECS
# systemctl restart ecs