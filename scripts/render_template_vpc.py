import sys
import os
import json
from jinja2 import Environment, FileSystemLoader

def network_template(template_obj):
    vpc_network_name    = str(template_obj['vpc_network_name'])
    vpc_cidr            = str(template_obj['vpc_cidr'])
    region              = str(template_obj['region'].replace(" ", "-"))
    gcp_project_id      = str(template_obj['gcp_project_id'])
    cloud               = str(template_obj['cloud'])
    resource            = str(template_obj['resource'])
    resource_group_name = str(template_obj['resource_group_name'])
    az_subscription_id  = str(template_obj['az_subscription_id'])
    
    if (cloud == 'az'):
        region = region.replace("-", " ")
    
    print(f'{resource}_{cloud}.jinja')
    
    template = env.get_template(f'{resource}_{cloud}.jinja')
    
    return template.render(vpc_network_name=vpc_network_name, vpc_cidr=vpc_cidr, region=region, gcp_project_id=gcp_project_id, resource_group_name=resource_group_name, az_subscription_id=az_subscription_id)

json_file = sys.argv[1]
with open(json_file, 'r') as f:
    template_obj = f.read()
template_obj = json.loads(template_obj)

template_dir = os.path.abspath('../jinja')
env = Environment(loader=FileSystemLoader(template_dir))

match template_obj["resource"]:
        case "network":
            output = network_template(template_obj)

# Write the rendered content to a file
with open(os.path.abspath(f"../terraform/{template_obj['cloud']}/{template_obj['resource']}/terraform.tfvars"), "w") as f:
    f.write(output)

print(f"File generated: terraform/{template_obj['cloud']}/{template_obj['resource']}/terraform.tfvars")
