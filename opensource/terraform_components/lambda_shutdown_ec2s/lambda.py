import boto3
def lambda_handler(event, context):
    ec2 = boto3.resource('ec2')
    client = boto3.client('ec2', region_name='us-east-1')
    for instance in ec2.instances.all():
        client.stop_instances(InstanceIds=instance.id)
        print('stopped : ' + str(instance.id))