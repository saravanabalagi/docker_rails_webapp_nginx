from ruamel.yaml import YAML

yaml = YAML()
with open("config/database.yml", "r") as f:
    config = yaml.load(f.read())
    
config['default']['host'] = 'db'
config['default']['username'] = "<%= ENV['POSTGRES_USERNAME'] %>"
config['default']['password'] = "<%= ENV['POSTGRES_PASSWORD'] %>"

del config['production']['username']
del config['production']['password']
yaml.dump(config, open("config/database.yml", "w"))

print("Database config updated successfully!")
