module "eks" {
    source  = "terraform-aws-modules/eks/aws"
    version = "~> 19.0"
    cluster_name = "SkogarmaorDiploma"
    cluster_version = "1.25"

    cluster_endpoint_public_access  = true

    vpc_id = module.myapp-vpc.vpc_id
    subnet_ids = module.myapp-vpc.private_subnets

    cluster_encryption_config = {}

    tags = {
        environment = "development"
        application = "SkogarmaorDiploma"
    }

    eks_managed_node_groups = {
        dev = {
            min_size = 1
            max_size = 3
            desired_size = 2

            instance_types = ["t3.small"]
        }
    }
}