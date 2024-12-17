$gcp_project_id = "sandbox-422716"
# Deploy Functions
function Translate-Parameter {
    [OutputType([string])]
    param (
        [string]$genericParameter,
        [string]$cloud
    )

    # Import the CSV data
    $csvPath = "parameters_mapping_vpc.csv"
    $csvData = Import-Csv -Path $csvPath

    # Find the matching row by filtering the GenericParameter column
    $match = $csvData | Where-Object { $_.GenericParameter -eq $genericParameter }

    # Check if a match was found and output results
    switch ($cloud) {
        "aws" { return $match.AWSParameter }
        "gcp" { return $match.GCPParameter }
        "az" { return $match.AzureParameter }
    }
}
function DeployTerraform {
    param (
        [string]$cloud,
        [string]$resource
    )

    terraform -chdir="../terraform/${cloud}/${resource}" init
    terraform -chdir="../terraform/${cloud}/${resource}" plan
    terraform -chdir="../terraform/${cloud}/${resource}" apply --auto-approve
}

function DeployVPC {
    param (
        [string]$cloud,
        [string]$vpc_cidr,
        [string]$vpc_network_name,
        [string]$region
    )

    $region = Translate-Parameter $region $cloud
    # $region = "US E"
    # $cloud = "gcp"
    # $vpc_cidr = "10.0.0.0/16"
    # $vpc_network_name = "test-vpc"
    $resource_group_name = "test-rg"
    $az_subscription_id = "cb4f4e34-6ecb-4e0a-a378-dd7de502d12e"

    $network_obj = [PSCustomObject]@{
        resource            = "network"
        cloud               = $cloud
        vpc_network_name    = $vpc_network_name
        vpc_cidr            = $vpc_cidr
        region              = $region
        gcp_project_id      = $gcp_project_id
        resource_group_name = $resource_group_name
        az_subscription_id  = $az_subscription_id
    }

    $json_string = $network_obj | ConvertTo-Json -Compress
    $temp_file = "temp.json"
    Set-Content -Path $temp_file -Value $json_string
    python render_template_vpc.py $temp_file
    # python render_template_vpc.py "'$network_obj'"
    DeployTerraform $cloud "network"


    # $network_obj = $network_obj | ConvertTo-Json -Compress
    # $network_obj = $network_obj -replace '"', '\"\"'
    # python render_template_vpc.py "'$network_obj'"
    # DeployTerraform $cloud $resource
}


# Login Functions
function gcloudLogin {
    gcloud auth login

    $gcp_project_id = Read-Host "Project ID"
    gcloud config set project $gcp_project_id
    
    DisplayMenu
    break
}

function azureLogin {
    az login

    $subscription = Read-Host "Subscription ID or name"
    az account set --subscription $subscription

    $resource_group = Read-Host "Resource Group"

    DisplayMenu
    break
}

# Menus
function DeployVpcMenu {
    # Clear-Host
    if ($flag_fill_params) {
        $vpc_network_name = Read-Host "Virtual Network Name"

        $region = Read-Host "Region"
        
        $vpc_cidr = Read-Host "Virtual Network CIDR Range"
        
        $flag_fill_params = $false
    }
    # Clear-Host
    Write-Host 
    @"
+===============================================+
|               CHOOSE YOUR CLOUD               |
+===============================================+
|                                               |
|    1) DEPLOY AWS                              |
|    2) DEPLOY GOOGLE CLOUD                     |
|    3) DEPLOY AZURE                            |
|                                               |
|    4) MAIN MENU                               |
+===============================================+
"@

    [string]$cloud,
    [string]$vpc_cidr,
    [string]$vpc_network_name,
    [string]$region

    $MENU = Read-Host "OPTION"
    Switch ($MENU) {
        1 {
            DeployVpc "aws" $vpc_cidr $vpc_network_name $region
            DeployVpcMenu
        }
        2 {
            DeployVpc "gcp" $vpc_cidr $vpc_network_name $region
            DeployVpcMenu
        }
        3 {
            DeployVpc "az" $vpc_cidr $vpc_network_name $region
            DeployVpcMenu
        }
        4 {
            DisplayMenu
        }
        default {
            #DEFAULT OPTION
            Write-Host "Option not available"
            DisplayMenu
        }
    }
}

# function FunctionName {
#     param (
#         OptionalParameters
#     )
# }

function LoginMenu {
    # Clear-Host
    Write-Host 
    @"
+===============================================+
|                ACCOUNT DETAILS                |
+===============================================+
|                                               |
|    1) AWS                                     |
|    2) GOOGLE CLOUD                            |
|    3) AZURE                                   |
|                                               |
|    4) MAIN MENU                               |
+===============================================+
"@
    
    $MENU = Read-Host "OPTION"
    Switch ($MENU) {
        1 {
            awsLogin
            DisplayMenu
        }
        2 {
            gcloudLogin
            DisplayMenu
        }
        3 {
            azureLogin
            DisplayMenu
        }
        4 {
            DisplayMenu
        }
        default {
            #DEFAULT OPTION
            Write-Host "Option not available"
            DisplayMenu
        }
    }
}

function DeployResourcesMenu {
    # Clear-Host
    Write-Host 
    @"
+===============================================+
|                CHOOSE RESOURCE                | 
+===============================================+
|                                               |
|    1) VIRTUAL NETWORK                         |
|    2) MySQL DATABASE                          |
|    3) VIRTUAL MACHINE                         |
|                                               |
|    4) MAIN MENU                               |
+===============================================+
"@
    
    $MENU = Read-Host "OPTION"
    Switch ($MENU) {
        1 {
            DeployVpcMenu
        }
        2 {
            $flag_fill_params = $true
            DeployResourcesMenu
        }
        3 {
            DeployVirtualMachine
            DisplayMenu
        }
        4 {
            DisplayMenu
        }
        default {
            #DEFAULT OPTION
            Write-Host "Option not available"
            DisplayMenu
        }
    }
    
}

function DisplayMenu {
    # Clear-Host
    Write-Host 
    @"
+===============================================+
|                   MAIN MENU                   | 
+===============================================+
|                                               |
|    1) ACCESS CLOUDS                           |
|    2) DEPLOY RESOURCES                        |
|    3) EXIT                                    |
|                                               |
+===============================================+
"@
    
    $MENU = Read-Host "OPTION"
    Switch ($MENU) {
        1 {
            LoginMenu
        }
        2 {
            $flag_fill_params = $true
            DeployResourcesMenu
        }
        3 {
            Write-Host "Bye"
            Break
        }
        default {
            #DEFAULT OPTION
            Write-Host "Option not available"
            DisplayMenu
        }
    }
}

function DisplayResources {
    # Clear-Host
    Write-Host 
    @"
+===============================================+
|                   RESOURCES                   | 
+===============================================+
|                                               |
|    1) VIRTUAL NETWORK                         |
|    2) MYSQL DATABASE                          |
|    3) VIRTUAL MACHINE                         |
|                                               |
|    4) MAIN MENU                               |
+===============================================+
"@
    
    $MENU = Read-Host "OPTION"
    Switch ($MENU) {
        1 {
            DeployVPC
        }
        2 {
            DeployMySql
        }
        3 {
            DeployVirtualMachine
        }
        4 {
            DeployVirtualMachine
            DisplayMenu
        }
        default {
            #DEFAULT OPTION
            Write-Host "Option not available"
            DisplayMenu
        }
    }
}
# DeployVPC
DisplayMenu