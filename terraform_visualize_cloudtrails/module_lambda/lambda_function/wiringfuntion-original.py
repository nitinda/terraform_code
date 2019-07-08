import boto3
import uuid
import json
import os


def handler(event, context):
  print(event)
  try:
    cognito_idp = boto3.client('cognito-idp')
    aes = boto3.client('es')

    if event['RequestType'] == 'Create':
      print('Create Event')
      response = cognito_idp.create_user_pool_domain(Domain='ctlab-{}'.format(str(uuid.uuid1())[:8]), UserPoolId=os.environ['COGNITOUSERPOOL'])
      
      print('Response for creating the Cognito Domain: {}'.format(response))
      response = cognito_idp.admin_create_user(UserPoolId=os.environ['COGNITOUSERPOOL'],Username='kibana',TemporaryPassword='Abcd1234!')

      print('Response for adding the Cognito user: {}'.format(response))

    if event['RequestType'] == 'Delete':
      print('Delete event')
      user_pool_info = cognito_idp.describe_user_pool(UserPoolId=os.environ['COGNITOUSERPOOL'])

      print('User pool info {}'.format(user_pool_info))
      user_pool_info = user_pool_info.get('UserPool', None)
      
      print('User pool info[UserPool] {}'.format(user_pool_info))
      
      if user_pool_info:
        domain_name = user_pool_info.get('Domain', None)
        print('User pool domain {}'.format(domain_name))
        if len(domain_name) > 0:
          response = cognito_idp.delete_user_pool_domain(Domain=domain_name,UserPoolId=os.environ['COGNITOUSERPOOL'])
          
          print('Response for removing the Cognito domain: {}'.format(response))
  except Exception as e:
    print('Wiring function exception! {}'.format(e))
    return False 
  return True