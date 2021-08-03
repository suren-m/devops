// common
prefix = "azbase"
# subsequent resources after base
env_prefix = "azenv" 
loc = {
  short = "uks"
  long  = "uk south"
}


// networking
vnet_addr_space = ["10.0.0.0/16"]
vnet_subnets = [
  {
    name        = "default"
    cidr        = ["10.0.0.0/24"]
    default_nsg = true
  },
  {
    name        = "vm"
    cidr        = ["10.0.1.0/24"]
    default_nsg = true
  },
  {
    name        = "GatewaySubnet"
    cidr        = ["10.0.2.0/24"]
    default_nsg = false
  },
  {
    name        = "AzureBastionSubnet"
    cidr        = ["10.0.3.0/24"]
    default_nsg = false
  },
  {
    name        = "storage"
    cidr        = ["10.0.5.0/24"]
    default_nsg = true
  },
  {
    name        = "aks"
    cidr        = ["10.0.16.0/20"]
    default_nsg = false
  },
  {
    name        = "aks-2"
    cidr        = ["10.0.32.0/20"]
    default_nsg = false
  },
  {
    name        = "k8s-iaas"
    cidr        = ["10.0.48.0/20"]
    default_nsg = true
  },
  {
    name        = "sub-64"
    cidr        = ["10.0.64.0/26"]
    default_nsg = false
  },
  {
    name        = "sub-64-2"
    cidr        = ["10.0.65.0/26"]
    default_nsg = false
  },
  {
    name        = "sub-128"
    cidr        = ["10.0.66.0/25"]
    default_nsg = false
  },
  {
    name        = "sub-128-2"
    cidr        = ["10.0.67.0/25"]
    default_nsg = false
  },
  {
    name        = "sub-256"
    cidr        = ["10.0.68.0/24"]
    default_nsg = false
  },
  {
    name        = "sub-256-2"
    cidr        = ["10.0.69.0/24"]
    default_nsg = false
  },
  {
    name        = "sub-512"
    cidr        = ["10.0.70.0/23"]
    default_nsg = false
  },
  {
    name        = "sub-1024"
    cidr        = ["10.0.72.0/22"]
    default_nsg = false
  },
  {
    name        = "sub-1024-2"
    cidr        = ["10.0.76.0/22"]
    default_nsg = false
  },
  {
    name        = "sub-4094"
    cidr        = ["10.0.80.0/20"]
    default_nsg = false
  },
  {
    name        = "sub-4094-2"
    cidr        = ["10.0.96.0/20"]
    default_nsg = false
  },
  {
    name        = "sub-4094-3"
    cidr        = ["10.0.112.0/20"]
    default_nsg = false
  },
  {
    name        = "sub-4094-4"
    cidr        = ["10.0.128.0/20"]
    default_nsg = false
  },
  {
    name        = "spark-pub"
    cidr        = ["10.0.200.0/23"]
    default_nsg = false
  },
  {
    name        = "spark-pvt"
    cidr        = ["10.0.202.0/23"]
    default_nsg = false
  },
  {
    name        = "spark-pub2"
    cidr        = ["10.0.204.0/23"]
    default_nsg = false
  },
  {
    name        = "spark-pvt2"
    cidr        = ["10.0.206.0/23"]
    default_nsg = false
  }
]
