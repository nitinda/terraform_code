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
      response = cognito_idp.admin_create_user(UserPoolId=os.environ['COGNITOUSERPOOL'],Username='kibana',TemporaryPassword='Abcd1234!')

      print('Response for adding the Cognito user: {}'.format(response))

    if event['RequestType'] == 'Delete':
      print('Delete event')
      user_pool_info = cognito_idp.describe_user_pool(UserPoolId=os.environ['COGNITOUSERPOOL'])

      print('User pool info {}'.format(user_pool_info))
      user_pool_info = user_pool_info.get('UserPool', None)
      
      print('User pool info[UserPool] {}'.format(user_pool_info))

      response = cognito_idp.admin_delete_user(UserPoolId=os.environ['COGNITOUSERPOOL'],Username='kibana')
      print('Response for removing user Cognito user: {}'.format(response))
  except Exception as e:
    print('Wiring function exception! {}'.format(e))
    return False 
  return True