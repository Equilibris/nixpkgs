import boto3, configparser, sys, os

# Filenames
home_dir = os.path.expanduser("~")
credentials_filename = home_dir+'/.aws/credentials'
powercatch_config_filename = home_dir+'/.aws/powercatch-config'

# Credentials config file
credentials_config = configparser.ConfigParser()
credentials_config.read(credentials_filename)

# Powercatch config file
powercatch_config = configparser.ConfigParser()
powercatch_config.read(powercatch_config_filename)


def mfa_login():
	mfa_code = input('Enter the MFA code: ')
	sts_client = boto3.client('sts') 
	
	mfa_credentials = sts_client.get_session_token(
		DurationSeconds=43200, 	# 12 hour token duration - maximum is 36 hours 
		SerialNumber=powercatch_config['mfa']['mfa_device_id'],
		TokenCode=mfa_code	
		)

	update_credentials_with(mfa_credentials, 'mfa')


def assume_role(environment):
	mfa_session = boto3.session.Session(profile_name='mfa')
	sts_client = mfa_session.client('sts')
	
	assume_role_credentials = sts_client.assume_role(
		DurationSeconds = 3600,  # 1 hour token duration
		RoleArn = powercatch_config[environment]['role_arn'],
		RoleSessionName = environment
	)

	update_credentials_with(assume_role_credentials, environment)
		

def update_credentials_with(new_credentials, credential_key):
	if(not credentials_config.has_section(credential_key)): 
		credentials_config.add_section(credential_key)

	credentials_config[credential_key]['aws_access_key_id'] = new_credentials['Credentials']['AccessKeyId']
	credentials_config[credential_key]['aws_secret_access_key'] = new_credentials['Credentials']['SecretAccessKey']
	credentials_config[credential_key]['aws_session_token'] = new_credentials['Credentials']['SessionToken']

	credentials_config_output = open(credentials_filename,'w')
	credentials_config.write(credentials_config_output)



if __name__ == "__main__":
	# Accepted arguments:
	#	mfa-login 	: Performs mfa login and updates mfa credentials
	#	assume-role : Assumes role using stored mfa credentials. Environment must be specified, e.g.
	#				  python3 aws-cli-helper.py assume-role powercatch-dev	
	if(len(sys.argv) == 2 and sys.argv[1] == "mfa-login"):
		mfa_login()
	elif(len(sys.argv) == 3 and sys.argv[1] == "assume-role"):
		assume_role(environment = sys.argv[2])
	else:
		print("Invalid arguments")	
	
		
	
	
