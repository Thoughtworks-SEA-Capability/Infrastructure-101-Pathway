# Week 3: AWS, Networking


## What will I learn?
- Cloud first networking concepts: 
How does user traffic reach my application
    - VPCs
    - Subnets, RouteTables 
    - InternetGateway, Nats

- High Availability and Scaling: 
How do I keep my application reachable during high load and disaster
    - Availability Zones
    - LoadBalancers
    - Autoscaling Groups

- Implementing a two-tiered AWS Cloud Architecture 
for my application with HA and  

## What should I learn on weekend?  
#### Networking
- AWS Networking 101: Relevant Section 0~12min. [Aws Network Fundamentals, Watch me upto minute 12](https://www.youtube.com/watch?v=hiKPPy584Mg)
- Creating most of the above on AWS Console: [Youtube link](https://www.youtube.com/watch?v=tD9vDv0uyI8)
- VPCs and Subnets: 
    - https://docs.aws.amazon.com/en_pv/vpc/latest/userguide/VPC_Subnets.html
- Route Tables: 
    - https://docs.aws.amazon.com/en_pv/vpc/latest/userguide/VPC_Route_Tables.html
- Internet Gateways: 
    - https://docs.aws.amazon.com/en_pv/vpc/latest/userguide/VPC_Internet_Gateway.html
- NAT Gateways: 
    - https://docs.aws.amazon.com/en_pv/vpc/latest/userguide/vpc-nat.html
    - https://docs.aws.amazon.com/en_pv/vpc/latest/userguide/vpc-nat-gateway.html
- Simple VPC with 1 Subnet: 
    - https://docs.aws.amazon.com/en_pv/vpc/latest/userguide/VPC_Scenario1.html
- VPC with Public and Private Subnet:
    - https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Scenario2.html 

#### Loadbalancer and Autoscaling groups Groups 

- Explanation and tutorial of Autoscaling group and Loadbalancer : [Youtube link](https://www.youtube.com/watch?v=-hFAWk6hyZA)
- Simple walk through of creating a LoadBalancer + Autoscaling group [Youtube Link](https://www.youtube.com/watch?v=wi0kTnFAbd0) 
- What is a loadblancer : https://docs.aws.amazon.com/elasticloadbalancing/latest/application/introduction.html  

## What will we do in Guild?
Create a two-tiered AWS Deployment with HA:

Reference: https://github.com/terraform-providers/terraform-provider-aws/tree/master/examples/two-tier

- Drawing exercise of the architecture 
- Create Terraform configuration files for a architecture with:
    - Public Subnet with IG and LB
    - Private Subnet with NAT 
    - Autoscaling group in Private Subnet with our application deployment
    - Loadbalancer in the Public Subnet pointing to our Autosclaing group
    - Across all 3 AZs
    - Profit

## What if I want to know more!? 
- Watch further into networking fundamentals: [Aws Network Fundamentals](https://www.youtube.com/watch?v=hiKPPy584Mg)
- Autoscaling policies :[AWS Dock](https://docs.aws.amazon.com/autoscaling/ec2/userguide/as-scaling-simple-step.html)


---

*Copyright (c) 2018 ThoughtWorks; for individual use for training purposes and not to be distributed or sublicensed without further authorisation by ThoughtWorks.*
