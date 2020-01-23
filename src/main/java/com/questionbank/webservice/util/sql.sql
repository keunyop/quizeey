
-- Q1
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '1', 'When using consolidated billing there are two account types. What are they? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '1', '1', 'Main account and Sub account.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '1', '2', 'Paying account and Linked account', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '1', '3', 'Main account and Secondary account.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '1', '4', 'Parent account and Child account', 'N', now(), now());

-- Q2
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '2', 'You have an Amazon EC2 instance in a VPC that is in a stopped state. Which of the following actions can you perform on this instance? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '2', '1', 'Change security groups', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '2', '2', 'Disable detailed monitoring', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '2', '3', 'Attach to an Auto Scaling group', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '2', '4', 'Detach the network interface', 'N', now(), now());

-- Q3
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '3', 'A customer is running two Amazon EC2 instances, Server1 and Server2, in different subnets of the same VPC. Server1 can ping Server2, but Server2 cannot ping Server1.What could explain this behavior? Choose 2 answers ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '3', '1', 'The ingress rules for Server1''s security group do not allow ICMP traffic', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '3', '2', 'The ingress rules for Server2''s security group do not allow ICMP traffic', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '3', '3', 'The two servers are not located in the same Availability Zone', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '3', '4', 'There is no route from Server2 to Server1 defined in the route table', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '3', '5', 'The operating system firewall on Server1 is blocking traffic from Server2', 'N', now(), now());

-- Q4
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '4', 'Which of the following does AWS own under the shared security responsibility model? Choose 3 answers ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '4', '1', 'Patching of Amazon Elastic Compute Cloud hypervisors', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '4', '2', 'Decommissioning storage devices at end of life', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '4', '3', 'Encryption of traffic within a virtual private cloud', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '4', '4', 'Physical security of AWS data centers and facilities', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '4', '5', 'Logical security of customer SSH private key material', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '4', '6', 'Access control within a virtual private cloud', 'N', now(), now());

-- Q5
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '5', 'A workload in an Amazon VPC consist of a single web-server launched from a custom AMI. Session state is stored in database. How should the Solutions Architect modify this workload to be both highly available and scalable? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '5', '1', 'Create a launch configuration with a desired capacity of two web servers across multiple Availability Zones. Create an Auto Scaling group with the AMI ID of the web server image. Use Amazon Route S3 latency-based routing to balance traffic across the Auto Scaling group.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '5', '2', 'Create a launch configuration with the AMI ID of the web server image. Create an Auto Scalinggroup using the newly-created launch configuration, and a desired capacity of two web servers across multiple regions. Use an Application Load Balancer (ALB) to balance traffic across the Auto Scaling group', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '5', '3', 'Create a launch configuration with the AMI ID of the web server image. Create an Auto Scaling group using the newly-created launch configuration, and a desired capacity of two web servers across multiple Availability Zones. Use an ALB to balance traffic across the Auto Scaling group', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '5', '4', 'Create a launch configuration with the AMI ID of the web server image. Create an Auto Scaling group using the newly-created launch configuration, and a desired capacity of two web servers across multiple Availability Zones. Use Route 53 weighted routing to balance traffic across the Auto Scaling group', 'N', now(), now());

-- Q6
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '6', 'You are tasked with setting up a Linux bastion host for access to Amazon EC2 instances running in your VPC. Only clients connecting from the corporate external public IP address 72.34.51.100 should have SSH access to the host. Which option will meet the customer requirement? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '6', '1', 'Security Group Inbound Rule: Protocol - TCP. Port Range - 22, Source 72.34.51.100/32', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '6', '2', 'Security Group Inbound Rule: Protocol - UDP, Port Range - 22, Source 72.34.51.100/32', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '6', '3', 'Network ACL Inbound Rule: Protocol - UDP, Port Range - 22, Source 72.34.51.100/32', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '6', '4', 'Network ACL Inbound Rule: Protocol - TCP, Port Range-22, Source 72.34.51.100/0', 'N', now(), now());

-- Q7
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '7', 'A company has a popular multi-player mobile game hosted in its on-premises datacenter. The current infrastructure can no longer keep up with demand end the company is considering a move to the cloud. Which solution should a Solutions Architect recommend as me MOST scalable and cost- effective solution to meet these needs? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '7', '1', 'Amazon EC2 and an Application Load Balancer', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '7', '2', 'Amazon S3 and Amazon CloudFront', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '7', '3', 'Amazon EC2 and Amazon Elastic Transcoder', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '7', '4', 'AWS Lambda and Amazon API Gateway', 'N', now(), now());

-- Q8
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '8', 'A company wants to migrate a highly transactional database to AWS Requirements state that the database has more than 6 TB of data and will grow exponentially. Which solution should a Solutions Architect recommend? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '8', '1', 'Amazon Aurora', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '8', '2', 'Amazon Redshift', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '8', '3', 'Amazon DynamoDB', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '8', '4', 'Amazon RDS MySQL', 'N', now(), now());

-- Q9
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '9', 'You have been asked to design a NAT solution for your company''s VPC-based web application. Traffic from the privatesubnets varies throughout the day from 500 Mbps to spikes of 7 Gbps.What is the most cost-effective and scalable solution? ', '', '', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '9', '1', 'Create an Amazon EC2 NAT instance with a second elastic network (ENI) in a public subnet; route all private subnet Internet traffic through the NAT gateway.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '9', '2', 'Create an Auto Scaling group of Amazon EC2 NAT instances in a public subnet; route all private subnet Internet traffic through the NAT gateway', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '9', '3', 'Move the Internet gateway for the VPC to a public subnet; route all Internet traffic through the Internet gateway', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '9', '4', 'Create a NAT gateway in a public subnet; route all private subnet Internet Traffic through the NAT gateway', 'N', now(), now());

-- Q10
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '10', 'You have an environment that consists of a public subnet using Amazon VPC and 3 instances that are running in this subnet. These three instances can successfully communicate with other hosts on the internet. you launch a fourth instance in the same subnet, using the same AMI and security group configuration you used for the others, but find that this instance cannot be accessed from the internet. What should you do to enable internet access? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '10', '1', 'Configure a publically routable IP Address in the host OS of the fourth instance', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '10', '2', 'Deploy a NAT instance into the public subnet', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '10', '3', 'Modify the routing table for the public subnet', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '10', '4', 'Assign an elastic IP address to the fourth instance', 'Y', now(), now());

-- Q11
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '11', 'You have a content management system running on an Amazon EC2 instance that is approaching 100% CPU utilization. Which option will reduce load on the Amazon EC2 instance? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '11', '1', 'EC2Config service', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '11', '2', 'IAM roles', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '11', '3', 'User Data', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '11', '4', 'AWS Config', 'N', now(), now());

-- Q12
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '12', 'The new DB Instance that is created when you promote a Read Replica retains the backup window period. ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '12', '1', 'FALSE', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '12', '2', 'TRUE', 'Y', now(), now());

-- Q13
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '13', 'A customer needs corporate IT governance and cost oversight of all AWS resources consumed by its divisions. The divisions wants to maintain administrative control of the discrete AWS resources they consume and keep those resources separate from the resources of other divisions. Which of the following options, when used together, will support the autonomy/control of divisions while enabling corporate IT to maintain governance and oversight? Choose 2 answers ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '13', '1', 'Enable IAM cross-account access for all corporate IT administrators in each child account.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '13', '2', 'Create separate VPCs for each division within the corporate IT AWS account', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '13', '3', 'Use AWS Consolidated Billing and disable AWS root account access for the child accounts', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '13', '4', 'Use AWS Consolidated billing to link the divisions accounts to a parent corporate account', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '13', '5', 'Write all child AWS CloudTrail and Amazon CloudWatch logs to each child account''s Amazon S3 log bucket', 'N', now(), now());

-- Q14
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '14', 'What is the maximum response time for a Business level Premium Support case? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '14', '1', '10 minutes', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '14', '2', '120 seconds', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '14', '3', '12 hours', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '14', '4', '1 hour', 'Y', now(), now());

-- Q15
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '15', 'A stray Amazon EC2 r3.8xlarge instance is running in your AWS account. Before terminating it, you want to find the owner to confirm that it is not needed. Where can you find the identity that launched this instance? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '15', '1', 'CloudTrail logs', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '15', '2', 'VPC flow logs', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '15', '3', 'ELB access logs', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '15', '4', 'Operating system logs', 'N', now(), now());

-- Q16
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '16', 'Your company''s IT policies mandate that all critical data must be duplicated in two physical locations at least 100 miles apart. What storage option meets this requirement? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '16', '1', 'One Amazon S3 bucket', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '16', '2', 'Two Amazon S3 buckets in the same region', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '16', '3', 'One Amazon Glacier archive', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '16', '4', 'Two Amazon S3 buckets in different regions', 'N', now(), now());

-- Q17
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '17', 'When an EC2 EBSbackend (EBS root) instance is stopped. What happens to the data on any Ephemeral store volumes? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '17', '1', 'Data is automatically saved in an EBS volume', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '17', '2', 'Data will be deleted and will no longer be accessible', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '17', '3', 'Data is unavailable until the instance is restarted', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '17', '4', 'Data is automatically saved as an EBS snapshot', 'N', now(), now());

-- Q18
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '18', 'You have been asked to design a fault-tolerant and scalable web application across three availability zones. The presentation logic will reside on web servers behind an ELB classic load balancer, and the application logic will reside on a set of app servers behind a second load balancer. How should you use auto scaling groups? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '18', '1', 'Deploy two Auto Scaling groups: one for the web servers in all Availability zones and one for the app servers in all Availability zones', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '18', '2', 'Deploy three auto scaling groups: one for each Availability zone that includes both web and app servers', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '18', '3', 'Deploy six auto scaling groups: a web server group in each Availability zone and an app server group in each availability zone', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '18', '4', 'Deploy one auto scaling group that includes al the web and app servers across all availability zones', 'N', now(), now());

-- Q19
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '19', 'A Solutions Architect has a multi-layer application running in Amazon VPC. The application has an ELB Classic Load Balancer as the front end in a public subnet, and an Amazon EC2-based reverse proxy that performs content-based routing to two backend Amazon EC2 instances hosted in a private subnet. The Architect sees tremendous traffic growth and is concerned that the reverse proxy and current backend setup will be insufficient. Which actions should the Architect take to achieve a cost-effective solution that ensures the application automatically scales to meet traffic demand? (Select TWO) ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '19', '1', 'Replace the Amazon EC2 reverse proxy with an EL8 internal Classic Load Balancer', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '19', '2', 'Add Auto Scaling to the Amazon EC2 backend fleet', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '19', '3', 'Add Auto Scaling to the Amazon EC2 reverse proxy layer', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '19', '4', 'Use t2 burstable instance types for the backend fleet', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '19', '5', 'Replace both the frontend and reverse proxy layers with an ELB Application Load Balancer', 'N', now(), now());

-- Q20
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '20', 'You''ve been tasked with choosing a datastore to persist GPS coordinates for a new app. The service needs consistent, single-digit-millisecond latency at any scale. Which AWS service meets your requirements? ', '', '', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '20', '1', 'Amazon S3', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '20', '2', 'Amazon Redshift', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '20', '3', 'Amazon RDS', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '20', '4', 'Amazon DynamoDB', 'N', now(), now());

-- Q21
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '21', 'When using the following AWS services, which should be implemented in multiple Availability Zones for high availability solutions? Choose 2 answers ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '21', '1', 'Amazon Simple Storage Service', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '21', '2', 'Amazon Elastic Load Balancing', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '21', '3', 'Amazon Elastic Compute Cloud', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '21', '4', 'Amazon Simple Notification Service', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '21', '5', 'Amazon DynamoDB', 'N', now(), now());

-- Q22
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '22', 'A company has a workflow that sends video files from their onpremise system to AWS for Trans coding. They use EC2 worker instances that pull Trans coding jobs from SQS an appropriate service for this scenario? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '22', '1', 'SQS synchronously provides transcoding output', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '22', '2', 'SQS guarantees the order of the messages', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '22', '3', 'SQS checks the health of the worker instances', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '22', '4', 'SQS helps to facilitate horizontal scaling of encoding tasks', 'Y', now(), now());

-- Q23
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '23', 'You are migrating an existing enterprise application to AWS. It requires standard file system access from multiple instances. It also requires high storage throughput with consistently low latencies. You are looking for a storage solution that will grow and shrink capacity automatically. How can you accomplish this in AWS?', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '23', '1', 'Create an Amazon S3 bucket that the application can for its storage requirements', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '23', '2', 'Launch an Amazon Redshift cluster with dense storage nodes to use with the application', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '23', '3', 'Create an Amazon EFS file system and mount it on all of the application instances', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '23', '4', 'Launch an EBS-backed EC2 instance. Create and share an NFS amount with application', 'N', now(), now());

-- Q24
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '24', 'You are working with a customers who is using chef configuration management in their data center. Which service is designed to let the customer leverage existing chef recipes in AWS? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '24', '1', 'AWS CloudFormation', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '24', '2', 'AWS OpsWorks', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '24', '3', 'AWS Elastic Beanstalk', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '24', '4', 'Amazon Simple Workflow Service', 'N', now(), now());

-- Q25
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '25', 'The one-time payment for Reserved Instances is __________ refundable if the reservation is cancelled. ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '25', '1', 'in some circumstances', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '25', '2', 'never', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '25', '3', 'always', 'N', now(), now());

-- Q26
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '26', 'A customer needs to deploy a NoSQL-based datastore to Amazon EC2 instances. The NoSQL software has native replication for durability of the data store. Which of the following storage options is the most cost-effective and performs best for the data store? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '26', '1', 'Amazon EBS Magnetic volumes', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '26', '2', 'Amazon EBS provisioned IOPS volumes', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '26', '3', 'Amazon EBS general purpose SSD volumes', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '26', '4', 'SSD-based Amazon EC2 instance store volumes', 'N', now(), now());

-- Q27
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '27', 'You have decided to change the instance type for instances running in your application tier that is using Auto Scaling. In which area below would you change the instance type definition? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '27', '1', 'Auto Scaling tags', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '27', '2', 'Auto Scaling policy', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '27', '3', 'Auto Scaling group', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '27', '4', 'Auto Scaling launch configuration', 'Y', now(), now());

-- Q28
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '28', 'A Solutions Architect is designing an architecture for a mobile gaming application. The appiicaton is expected to be very popular. The Architect needs to prevent the Amazon ROS MySQL database from becoming a bottleneck due to frequently accessed queries. Which service or feature should the Architect add to prevent a bottleneck? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '28', '1', 'Multi-AZ feature on the RDS MySQL Database', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '28', '2', 'ELB Classic Load Balancer in front of the web application tier.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '28', '3', 'Amazon SQS in front of RDS MySQL Database', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '28', '4', 'Amazon ElastiCache in front of the RDS MySQL Database.', 'Y', now(), now());

-- Q29
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '29', 'How can an EBS volume that is currently attached to an EC2 instance be migrated from one Availability Zone to another? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '29', '1', 'Detach the volume and attach it to another EC2 instance in the other AZ', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '29', '2', 'Create a snopshot of the volume, and create a new volume from the snapshot in the other AZ', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '29', '3', 'Detach the volume, then use the ec2-migrate-volume command to move it to another AZ', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '29', '4', 'Simply create a new volume in the other AZ and specify the original volume as the source', 'N', now(), now());

-- Q30
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '30', 'Your Amazon VPC has a pubic subnet with a route that sends all internet traffic to the internet gateway. An Amazon EC2 instance in the Public subnet has an assigned private IP address. The instance belongs to a security group set to allow all outbound traffic. The instance cannot access the internet. Why could the internet be unreachable from this instance? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '30', '1', 'The instance "source/destination check" property must be enabled', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '30', '2', 'The instance security group must allow all inbound traffic', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '30', '3', 'The instance does not have a public IP address', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '30', '4', 'The internet gateway security group must allow all outbound traffic', 'N', now(), now());

-- Q31
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '31', 'Please select the Amazon EC2 resource which cannot be tagged. ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '31', '1', 'Elastic IP addresses', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '31', '2', 'images (AMIs, kernels, RAM disks)', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '31', '3', 'VPCs', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '31', '4', 'Amazon EBS volumes', 'N', now(), now());

-- Q32
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '32', 'A company is migrating its data center to AWS. As part of this migration, there is a three-tier web application that has strict data-at-rest encryption requirements. The customer deploys this application on Amazon EC2 using Amazon EBS, and now must provide encryption at-rest. How can this requirement be met without changing the application? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '32', '1', 'Use AWS Key Management Service and move the encrypted data to Amazon S3.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '32', '2', 'Use an application-specific encryption API with AWS server-side encryption', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '32', '3', 'Use encrypted EBS storage volumes with AWS-managed keys', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '32', '4', 'Use third-party tools to encrypt the EBS data volumes with Key Management Service Bring Your Own Keys.', 'N', now(), now());

-- Q33
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '33', 'You need a persistent and durable storage to trace call activity of an IVR (Interactive Voice Response) system. Call duration is mostly in the 2-3 minutes timeframe. Each traced call can be eitheractive or terminated. An external application needs to know each minute the list of currently active calls, which are usually a few calls/second. Put once per month there is a periodic peak up to 1000 calls/second for a few hours The system is open 24/7 and any downtime should be avoided. Historical data is periodically archived to files. Cost saving is a priority for this project. What database implementation would better fit this scenario, keeping costs as low as possible? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '33', '1', 'Use RDS Multi-AZ with a "CALLS" table and an Indexed "STATE* field that can be equal to ''ACTIVE" or -TERMINATED" In this way the SOL query Is optimized by the use of the Index.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '33', '2', 'Use RDS Multi-AZ with two tables, one for -Active calls" and one for -Terminated calls". In this way the "Active calls_ table is always small and effective to access.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '33', '3', 'Use DynamoDB with a "Calls" table and a Global Secondary Index on a "IsActive''" attribute that is present for active calls only In this way the Global Secondary index is sparse and more effective.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '33', '4', 'Use DynamoDB with a ''Calls" table and a Global secondary index on a ''State" attribute that can equal to "active" or "terminated" in this way the Global Secondary index can be used for all Items in the table.', 'N', now(), now());

-- Q34
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '34', 'Which of the following statements are true about Amazon Route 53 resource records? Choose 2 answers ', '', '', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '34', '1', 'An Alias record can map one DNS name to another Amazon Route 53 DNS name.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '34', '2', 'A CNAME record can be created for your zone apex.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '34', '3', 'An Amazon Route 53 CNAME record can point to any DNS record hosted anywhere.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '34', '4', 'TTL can be set for an Alias record in Amazon Route 53.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '34', '5', 'An Amazon Route 53 Alias record can point to any DNS record hosted anywhere.', 'N', now(), now());

-- Q35
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '35', 'Which aspects of Amazon EC2 security are the responsibility of AWS? Choose 2 answers ', '', '', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '35', '1', 'Virtualization Infrastructure', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '35', '2', 'Physical security of hardware', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '35', '3', 'Guest operating systems', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '35', '4', 'Application authentication', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '35', '5', 'VPC and security group configuration', 'N', now(), now());

-- Q36
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '36', 'Which services can invoke AWS lambda functions? Choose 2 answers ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '36', '1', 'Amazon SNS', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '36', '2', 'Amazon Reoute53', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '36', '3', 'Amazon Redshift', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '36', '4', 'Amazon DynamoDB', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '36', '5', 'Elastic Load Balancing', 'N', now(), now());

-- Q37
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '37', 'A company has an AWS account that contains three VPCs (Dev, Test, and Prod) in the same region. Test is peered to both prod and Dev. All VPCs have non-overlapping CIDR blocks. The company wants to push minor code releases from Dev to Prod to speed up time to market. Which of the following options helps the company accomplish this? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '37', '1', 'Create a new peering connection between Prod and Dev along with appropriate routes', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '37', '2', 'Create a new entry to Prod in the Dev route table using the peering connection as the target', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '37', '3', 'Attach a security gateway to Dev. Add a new entry in the Prod route table identifying the gateway as the target', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '37', '4', 'The VPCs have non-overlapping CIDR blocks in the same account. The route tables contain local routes for all VPCs', 'N', now(), now());

-- Q38
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '38', 'A client application requires operating system privileges on a relational database server. What is an appropriate configuration for a highly available database architecture? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '38', '1', 'A standalone Amazon EC2 instance', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '38', '2', 'Amazon RDS in a Multi-AZ configuration', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '38', '3', 'Amazon EC2 instances in a replication configuration utilizing a single Availability Zone', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '38', '4', 'Amazon EC2 instances in a replication configuration utilizing two different Availability Zones', 'N', now(), now());

-- Q39
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '39', 'Which of the following requires a custom Cloud Watch metric to monitor? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '39', '1', 'CPU utilization of an EC2 instance', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '39', '2', 'Memory utilization of an EC2 instance', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '39', '3', 'Disk usage activity of an EC2 instance', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '39', '4', 'Data transfer of an EC2 instance', 'N', now(), now());

-- Q40
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '40', 'You are using an m1.small EC2 instance with one 300GB EBS volume to host a relational database. You determined that write throughput to the database needs to be increased. Which of the following approaches can help achieve this? Choose 2 answers ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '40', '1', 'Add an EBS volume and place into RAID 5', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '40', '2', 'Use an array of EBS volumes', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '40', '3', 'Place the instance in an Auto Scaling Group', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '40', '4', 'Increase the size of the EC2 instance', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '40', '5', 'Enable multi-AZ mode', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '40', '6', 'Put the database behind an Elastic Load Balancer', 'N', now(), now());

-- Q41
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '41', 'You are working with a customer who is using Chef configuration management in their data center. Which service is designed to let the customer leverage existing Chef recipes in AWS? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '41', '1', 'Amazon Simple Workflow Service', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '41', '2', 'AWS Elastic Beanstalk', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '41', '3', 'AWS CloudFormation', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '41', '4', 'AWS OpsWorks', 'N', now(), now());

-- Q42
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '42', 'A Solutions Architect is architecting a workload that requires a performant object-based storage system that must be shared with multiple Amazon EC2 instances. Which AWS service meets this requirement? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '42', '1', 'Amazon EFS', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '42', '2', 'Amazon S3', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '42', '3', 'Amazon EBS', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '42', '4', 'Amazon ElastiCache', 'N', now(), now());

-- Q43
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '43', 'You have a video Trans coding application running on Amazon EC2. Each instance pools a queue to find out which video should be Trans coded, and then runs a Trans coding process. If this process is interrupted, the video will be Trans coded by another instance based on the queuing system. You have a large backlog of videos which need to be Trans coded and would like to reduce this backlog by adding more instances. You will need these instances only until the backlog is reduced. Which type of Amazon EC2 instance should you use to reduce the backlog in the most cost effective way? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '43', '1', 'Dedicated instances', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '43', '2', 'Spot instances', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '43', '3', 'On-demand instances', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '43', '4', 'Reserved instances', 'N', now(), now());

-- Q44
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '44', 'An application tier currently hosts two web services on the same set of instances, listening on different ports. Which AWS service should a Solutions Architect use to route traffic to the service based on the incoming request path? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '44', '1', 'AWS Application Load Balancer', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '44', '2', 'Amazon CloudFront', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '44', '3', 'Amazon Route 53', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '44', '4', 'AWS Classic Load Balancer', 'N', now(), now());

-- Q45
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '45', 'You are running a web application with four Amazon EC2 instances across two Availability Zones. The instances are in an Auto Scaling group behind an ELB Classic Load Balancer. A scaling event adds one instance to the group. After the event, you notice that, although all instances are serving traffic, some instances are serving more traffic than others. Which of the following could be the problem? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '45', '1', 'sticky bits is not enables on the ELB Classic Load Balancer', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '45', '2', 'A SSL/TLS certificate has not been deployed on the ELB Classic Load Balancer', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '45', '3', 'Cross-zone load balancing is not configuring on the ELB Classic Load Balancer', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '45', '4', 'Access logs are not enabled on the ELB Classic Load Balancer', 'N', now(), now());

-- Q46
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '46', 'A company has an application that uses Amazon CloudFront for content that is hosted on an Amazon S3 bucket. After an unexpected refresh, the users are still seeing old content. Which step should the Solutions Architect take to ensure that new content is displayed? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '46', '1', 'Perform a cache refresh on the CloudFront distribution that is serving the content', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '46', '2', 'Perform an invalidation on the CloudFront distribution that is serving the content', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '46', '3', 'Create a new cache behavior path with the updated content', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '46', '4', 'Change the TTL value tor removing the old objects.', 'Y', now(), now());

-- Q47
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '47', 'Which procedure for backing up a relational database on EC2 that is using a set of RAIDed EBS volumes for storage minimizes the time during which the database cannot be written to and results in a consistent backup? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '47', '1', '1 stop the EC2 instance, 2 snapshot the EBS volume', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '47', '2', '1 suspend disk I/O, 2 create an image of the EC2 instance, 3 resume disk I/O', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '47', '3', '1 detach EBS volumes, 2 start EBS snapshot of volumes, 3 re-attach EBS volumes', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '47', '4', '1 suspend disk I/O, 2 start EBS snapshot of volumes, 3 wait for snapshots to complete, 4 resume disk I/O', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '47', '5', '1 suspend disk I/O,2 start EBS snapshot of volumes, 3 resume disk I/O', 'N', now(), now());

-- Q48
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '48', 'A company''s policy requires that all data stored in Amazon S3 is encrypted. The company wants to use the option with the least overhead and does not manage any encryption keys. Which of the following options will meet the company''s requirements? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '48', '1', 'AWS CloudHSM', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '48', '2', 'AWS Trusted Advisor', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '48', '3', 'Server Side Encryption (SSE-S3)', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '48', '4', 'Server Side Encryption (SSE-KMS)', 'Y', now(), now());

-- Q49
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '49', 'A workload consists of downloading an image from an Amazon S3 bucket, processing the image, and moving it to another Amazon S3 bucket. An Amazon EC2 instance runs a scheduled task every hour to perform the operation. How should a Solutions Architect redesign the process so that it is highly available? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '49', '1', 'Charge the Amazon EC2 instance to compute optimized', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '49', '2', 'Launch a second Amazon EC2 instance to monitor the health of the first', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '49', '3', 'Trigger a Lambda function when a new object is uploaded', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '49', '4', 'Initially copy the images to an attached Amazon EBS volume.', 'N', now(), now());

-- Q50
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '50', 'A company is building a two-tier web application to serve dynamic transaction-based content. The data tier is leveraging an online transactional processing (OLTP) database. What services should you leverage to enable an elastic and scalable web tier? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '50', '1', 'Elastic Load Balancing, Amazon EC2, and Auto Scaling', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '50', '2', 'Elastic Load Balancing, Amazon RDS with Multi-AZ, and Amazon S3', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '50', '3', 'Amazon RDS with Multi-AZ and Auto Scaling', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '50', '4', 'Amazon EC2, Amazon DynamoDB, and Amazon S3', 'N', now(), now());

-- Q51
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '51', 'You originally built a VPC for a two-tier application. The subnets for the web and data tiers use all the IP address space in the VPC. Now you want to add subnets for an application tier. How can you accommodate the new subnets in your VPC? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '51', '1', 'Change the CIDR block for the VPC to create enough free address space for the new subnets', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '51', '2', 'Create the new subnets in the VPC; the VPC will automatically scale to accommodate the new subnets', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '51', '3', 'Build a new VPC that can accommodate all the subnets, and migrate the application to the new VPC', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '51', '4', 'Reduce the CIDR block ranges of the existing subnets to make room for the new subnets', 'N', now(), now());

-- Q52
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '52', 'A Solution Architect is designing a new social media application. The application must provide a secure method for uploading profile photos. Each user should be able to upload a profile photo into a shared storage location for one week after their profile is created.Which approach will meet all of these requirements? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '52', '1', 'Use Amazon Kinesis with AWS CloudTrail for auditing the specific times when profile photos are uploaded.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '52', '2', 'Use Amazon EBS volumes with IAM policies restricting user access to specific time periods', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '52', '3', 'Use Amazon S3 with the default private access policy and generate pre-signed URLs each time a new site profile is created', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '52', '4', 'Use Amazon CloudFront with AWS CloudTrail for auditing the specific times when profile photos are uploaded.', 'N', now(), now());

-- Q53
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '53', 'What does the following command do with respect to the Amazon EC2 security groups? ec2create-group CreateSecurityGroup ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '53', '1', 'Groups the user created security groups in to a new group for easy access.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '53', '2', 'Creates a new group inside the security group.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '53', '3', 'Creates a new security group for use with your account.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '53', '4', 'Creates a new rule inside the security group.', 'N', now(), now());

-- Q54
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '54', 'A customer has a public-facing web application hosted on a single amazon Elastic compute Cloud (EC2) instance and serving videos directly from an amazon simple storage service bucket. Which of the following will restrict third parties from directly accessing the video assets in the bucket? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '54', '1', 'Use a bucket policy to only allow the public IP address of the Amazon EC2 instance hosting the customer website', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '54', '2', 'Use a bucket policy to only allow referrals from the main website URL', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '54', '3', 'Launch the website Amazon EC2 instance using an IAM role that is authorized to access the videos', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '54', '4', 'restrict access to the bucket to the public CIDR range of the company locations', 'N', now(), now());

-- Q55
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '55', 'You are deploying an application to track GPS coordinates of delivery in the United States. Coordinates are transmitted from each delivery truck once every three seconds. You need to design an architecture that will enable realtime processing of these coordinates from multiple consumers. Which service should you use to implement data ingestion? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '55', '1', 'Amazon Kinesis', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '55', '2', 'AWS Data Pipeline', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '55', '3', 'Amazon AppStream', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '55', '4', 'Amazon Simple Queue Service', 'N', now(), now());

-- Q56
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '56', 'You''re building an API backend available at services.yourcompany.com. The API is implemented with API Gateway and Lambda. You successfully tested the API using curd. You implemented Javascript to call the API from a webpage on your corporate website, www.yourcompany.com. When you access that page in your browser, you get the following error: "The same origin policy disallows reading he remote resource" How can you allow your corporatewebpages to invoke the API? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '56', '1', 'Disable CORS in the API gateway', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '56', '2', 'Enable CORS in the Javascript frontend', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '56', '3', 'Disable CORS in the Javascript frontend', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '56', '4', 'Enable CORS in the API gateway', 'Y', now(), now());

-- Q57
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '57', 'You have launched an Amazon Elastic Compute Cloud (EC2) instance into a public subnet with a primary private IP address assigned, an internet gateway is attached to the VPC, and the public route table is configured to send all internet-based internet. Why is the internet unreachable from this instance? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '57', '1', 'The Internet gateway security group must allow all outbound traffic', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '57', '2', 'The instance does not have a public IP address', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '57', '3', 'The instance "Source/Destination check" property must be enabled', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '57', '4', 'The instance security group must allow all inbound traffic', 'N', now(), now());

-- Q58
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '58', 'An Administrator is hosting on application on a single Amazon EC2 instance, which users can access by the public hostname. The administrator is adding a second instance, but does not want users to have to decide between many public hostnames. Which AWS service will decouple the users from specific Amazon EC2 instances? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '58', '1', 'Amazon SQS', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '58', '2', 'Auto Scaling group', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '58', '3', 'Amazon EC2 security group', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '58', '4', 'Amazon ELB', 'Y', now(), now());

-- Q59
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '59', 'A company hosts a website on premises. The website has a mix of static and dynamic content, but users experience latency when loading static files. Which AWS service can help reduce latency? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '59', '1', 'Amazon CloudFront with on-premises servers as the origin', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '59', '2', 'ELB Application Load Balancer', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '59', '3', 'Amazon Route 53 latency-based routing', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '59', '4', 'Amazon EFS to store and serve static files', 'N', now(), now());

-- Q60
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '60', 'Your Amazon VPC has a public subnet with a route that sends all Internet traffic to the Internet gateway. An Amazon EC2 instance in the public subnet has an assigned private IP address. The instance belongs to a security group set to allow all outbound traffic. The instance cannot access the Internet. Why could the Internet be unreachable from the instance? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '60', '1', 'The instance does not have a public IP address.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '60', '2', 'The internet gateway security group must allow all outbound traffic.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '60', '3', 'The instance security group must allow all inbound traffic.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '60', '4', 'The instance "Source/Destination check" property must be enabled.', 'N', now(), now());

-- Q61
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '61', 'Which of the following are true regarding AWS Cloud Trail? Choose 3 answers ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '61', '1', 'Cloudtrail is enabled globally', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '61', '2', 'Cloudtrail is enabled by default', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '61', '3', 'Cloudtrail is enabled on a per-region basis', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '61', '4', 'Cloudtrail is enabled on a per-service basis', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '61', '5', 'Logs can be delivered to a single Amazon S3 bucket for aggregation', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '61', '6', 'Logs can only be processes and delivered to the region in which they are generated', 'N', now(), now());

-- Q62
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '62', 'How can software determine the public and private IP addresses of the Amazon EC2 instance that it is running on? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '62', '1', 'Use ipconfig or ifconfig command', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '62', '2', 'Query the local instance metadata', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '62', '3', 'Query the appropriate Amazon CloudWatch metric', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '62', '4', 'Query the local instance userdata', 'N', now(), now());

-- Q63
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '63', 'A client application requires operating system privileges on a relational database server. What is an appropriate configuration for highly available database architecture? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '63', '1', 'A standalone Amazon EC2 instance', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '63', '2', 'Amazon RDS in a multi-AZ configuration', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '63', '3', 'Amzon EC2 instances in a replication configuration utilizing a single Availability Zone', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '63', '4', 'Amazon EC2 instances in a replication configuration utilizing two different Availability Zones', 'Y', now(), now());

-- Q64
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '64', 'You are building an automated transcription service in which Amazon EC2 worker instances process an uploaded audio file and generate a text file. You must store both of these files in the same durable storage until the text file is retrieved. You do not know what the storage capacity requirements are. Which storage option is both cost-efficient and scalable? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '64', '1', 'Multiple instances stores', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '64', '2', 'A single Amazon S3 bucket', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '64', '3', 'Multiple Amazon EBS volume with snapshots', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '64', '4', 'A single Amazon Glacier vault', 'N', now(), now());

-- Q65
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '65', 'Your Amazon EC2 instances must access the AWS API, so you created a NAT gateway in an existing subnet. When you try to access the AWS API, you are unsuccessful.What could be preventing access? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '65', '1', 'The instances need an IAM role granting access to the NAT gateway', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '65', '2', 'The NAT gateway subnet does not have a route to an Internet gateway', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '65', '3', 'The NAT gateway does not have a route to the virtual private gateway', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '65', '4', 'The instances are not in the same subnet as the NAT gateway', 'N', now(), now());

-- Q66
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '66', 'Select the correct set of options. These are the initial settings for the default security group: ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '66', '1', 'Allow no inbound traffic, Allow all outbound traffic and Allow instances associated with this security group to talk to each other', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '66', '2', 'Allow no inbound traffic, Allow all outbound traffic and Does NOT allow instances associated with this security group to talk to each other', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '66', '3', 'Allow all inbound traffic, Allow no outbound traffic and Allow instances associated with this security group to talk to each other', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '66', '4', 'Allow all inbound traffic, Allow all outbound traffic and Does NOT allow instances associated with this security group to talk to each other', 'N', now(), now());

-- Q67
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '67', 'A media company has more than 100TB of data to be stored and retrieved infrequently. However the company occasionally receives requests for data within an hour The company needs a low- cost retrieval method to handle the requests. Which service meets this requirement? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '67', '1', 'Amazon S3 Standard', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '67', '2', 'Amazon Glacier standard retrievals', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '67', '3', 'Amazon Glacier bulk retrievals', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '67', '4', 'Amazon S3 Standard Infrequent Access', 'Y', now(), now());

-- Q68
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '68', 'A company has asked a Solutions Architect to ensure that data is protected during data transfer to and from Amazon S3. Use of which service will protect the data in transit? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '68', '1', 'AWS KMS', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '68', '2', 'HTTPS', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '68', '3', 'SFTP', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '68', '4', 'FTPS', 'N', now(), now());

-- Q69
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '69', 'A company is preparing to give AWS Management Console access to developers. Company policy mandates identity federation and role based access control. Roles are currently assigned using groups in the corporate Active Directory. What combination of the following will give developers access to the AWS console? Choose 2 answers ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '69', '1', 'AWS Directory Service AD connector', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '69', '2', 'AWS Directory Service Simple AD', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '69', '3', 'AWS identity and Access Management groups', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '69', '4', 'AWS identity and Access Management roles', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '69', '5', 'AWS identity and Access Management users', 'N', now(), now());

-- Q70
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '70', 'Which security functions are based on AWS STS? Choose 2 answers ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '70', '1', 'Adding conditions to managed policies', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '70', '2', 'Using Web federated identity to authenticate users', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '70', '3', 'Using IAM roles with Amazon EC2 instances', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '70', '4', 'Assigning managed policies to IAM groups', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '70', '5', 'Using access keys to authenticate IAM users', 'N', now(), now());

-- Q71
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '71', 'A company collects click-stream data from amazon EC2 instances that are in an auto scaling group. The age data feeds a centralized dashboard and is critical to the company''s business. Which method will help ensure data is collected before an auto scaling policy terminates an instance from the auto scaling group? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '71', '1', 'Use Auto Scaling lifecycle hooks', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '71', '2', 'Trigger Amazon S3 event notifications', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '71', '3', 'Implement Amazon kinesis as a log collector', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '71', '4', 'Snapshot the Amazon EC2 instance Elastic Block Store volumes', 'N', now(), now());

-- Q72
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '72', 'You are trying to use SSH to connect from your laptop to an Amazon EC2 instance over the internet. You cannot establish a connection. What could be the problem? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '72', '1', 'The network ACL is set to deny all outbound TCP traffic to your laptop IP address', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '72', '2', 'The IAM access key on your laptop does not have console access to the Amazon EC2 instance', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '72', '3', 'There is no security group and no network ACL associated with the Amazon EC2 instance', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '72', '4', 'The security group does not allow any outbound TCP traffic to your laptop IP address', 'Y', now(), now());

-- Q73
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '73', 'A Solutions Architect is designing a solution that includes a managed VPN connection. To monitor whether the VPN connection is up or down, the Architect should use: ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '73', '1', 'an external service to ping the VPN endpoint from outside the VPC', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '73', '2', 'AWS CloudTrail to monitor the endpoint', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '73', '3', 'the CloudWatch TunnelState Metric', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '73', '4', 'an AWS Lambda function that parses the VPN connection logs.', 'N', now(), now());

-- Q74
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '74', 'Which services allow the customer to retain full administrative privileges of the underlying EC2 instances? Choose 2 answers ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '74', '1', 'Amazon Relational Database Service', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '74', '2', 'Amazon Elastic Map Reduce', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '74', '3', 'Amazon ElastiCache', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '74', '4', 'Amazon DynamoDB', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '74', '5', 'AWS Elastic Beanstalk', 'N', now(), now());

-- Q75
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '75', 'A Solutions Architect needs to allow developers to have SSH connectivity to web servers The requirements are as follows: * Limit access to users originating from the corporate network * Web servers cannot have SSH access directly from the Internet * Web servers reside in a private subnet Which combination of steps must the Architect complete to meet these requirements? (Select TWO) ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '75', '1', 'Create a bastion host that authenticates users against the corporate directory', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '75', '2', 'Create a bastion host with security group rules that only allow traffic from the corporate network', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '75', '3', 'Attach an IAM role to the bastion host with relevant permissions', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '75', '4', 'Configure the web servers'' security group to allow SSH traffic from a bastion host', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '75', '5', 'Deny all SSH traffic from the corporate network in the inbound network ACL.', 'N', now(), now());

-- Q76
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '76', 'You are running a news website in the eu-west-1 region that updates every 15 minutes. The website has a world-wide audience it uses an Auto Scaling group behind an Elastic Load Balancer and an Amazon RDS database Static content resides on Amazon S3, and is distributed through Amazon CloudFront. Your Auto Scaling group is set to trigger a scale up event at 60% CPU utilization, you use an Amazon RDS extra large DB instance with 10.000 Provisioned IOPS its CPU utilization is around 80%. While freeable memory is in the 2 GB range. Web analytics reports show that the average load time of your web pages is around 1 5 to 2 seconds, but your SEO consultant wants to bring down the average load time to under 0.5 seconds. How would you improve page load times for your users? (Choose 3 answers) ', '', '', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '76', '1', 'Add an Amazon ElastiCache caching layer to your application for storing sessions and frequent DB queries', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '76', '2', 'Lower the scale up trigger of your Auto Scaling group to 30% so it scales more aggressively.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '76', '3', 'Configure Amazon CloudFront dynamic content support to enable caching of re-usable content from your site', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '76', '4', 'Switch Amazon RDS database to the high memory extra large Instance type', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '76', '5', 'Set up a second installation in another region, and use the Amazon Route 53 latency-based routing feature to select the right region.', 'N', now(), now());

-- Q77
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '77', 'All Amazon EC2 instances are assigned two IP addresses at launch, out of which one can only be reached from within the Amazon EC2 network? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '77', '1', 'Private IP address', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '77', '2', 'Public IP address', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '77', '3', 'Elastic IP Address', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '77', '4', 'Multiple IP address', 'N', now(), now());

-- Q78
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '78', 'An instance is launched into a VPC subnet with the network ACL configures to allow all inbound traffic and deny all outbound traffic. The instance''s security group is configured to allow SSH from any IP address and deny all outbound traffic. What changes need to be made to allow SSH access to instance? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '78', '1', 'The outbound security group needs to be modified to allow outbound traffic', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '78', '2', 'Both the outbound security group and outbound network ACL need to be modified to allow outbound traffic', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '78', '3', 'The outbound network ACL needs to be modified to allow outbound traffic', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '78', '4', 'Nothing, it can be accessed from any IP address using SSH', 'N', now(), now());

-- Q79
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '79', 'What services will help identify Amazon EC2 instances with underutilized CPU Capacity? Choose 2 answers ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '79', '1', 'AWS trusted advisor', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '79', '2', 'Amazon EC2 usage reports', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '79', '3', 'AWS CloudTrail', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '79', '4', 'Amazon CloudWatch', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '79', '5', 'Cost Explorer', 'N', now(), now());

-- Q80
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '80', 'You have created an API powered by API Gateway and AWS Lambda. Because of a new feature release, you expect traffic volume on your API to increase 10-fold. Which configuration should you use? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '80', '1', 'Use one Lambda function with API gateway as the trigger. Increase the amount of memory configured for the lambda function', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '80', '2', 'Use one Lambda function with API gateway as the trigger. AWS Lambda will allocate capacity to match the rate of incoming events', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '80', '3', 'Use multiple API Gateway endpoints, each triggering a Lambda function. You are charged per call, not per endpoint', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '80', '4', 'Use multiple copies of the Lambda function, each with API gateway as th trigger. You are charged per request, not per function', 'N', now(), now());

-- Q81
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '81', 'A company has an AWS account that contains three VPCs (Dev, Test, and Prod) in the same region. Test is peered to both Prod and Dev. All VPCs have non-overlapping CIDR blocks. The company wants to push minor code releases from Dev to Prod to speed up time to market. Which of the following options helps the company accomplish this? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '81', '1', 'Create a new peering connection Between Prod and Dev along with appropriate routes.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '81', '2', 'Create a new entry to Prod in the Dev route table using the peering connection as the target.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '81', '3', 'Attach a second gateway to Dev. Add a new entry in the Prod route table identifying the gateway as the target.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '81', '4', 'The VPCs have non-overlapping CIDR blocks in the same account. The route tables contain local routes for all VPCs.', 'N', now(), now());

-- Q82
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '82', 'You have configured mycorp.com as an Amazon route 53 private hosted zone for Amazon virtual private cloud. Amazon elastic compute cloud (EC2) instances in your eu-east-1 virtual private cloud successfully resolve to internal.mycorp.com. You are extending your infrastructure to a VPC in eu-west-1. Why are Amazon EC2 instance in eu-west-1 unable to resolve to internal.mycorp.com? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '82', '1', 'The VPC in eu-west 1 is not associated to the private hosted zone', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '82', '2', 'The DHCP options set in eu-west-1 requires the private hosted zone name server IP addresses', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '82', '3', 'The enableDnsHostnames attribute of the VPC in eu-west-1 should be set to false', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '82', '4', 'A second private hosted zone for Amazon VPC is requires for eu-west-1', 'N', now(), now());

-- Q83
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '83', 'What does Amazon Route53 provide? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '83', '1', 'None of these.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '83', '2', 'A scalable Domain Name System.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '83', '3', 'An SSH endpoint for Amazon EC2.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '83', '4', 'A global Content Delivery Network.', 'N', now(), now());

-- Q84
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '84', 'Your company has separate AWS accounts for development and production. Each developer is assigned an IAM user in the development account. Developers occasionally need to access the production account to roll out changes to that environment. Your company does not allow the creation of IAM users in the production account. What strategy will allow the development team to access the production account? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '84', '1', 'Create an IAM role in the production account. Allow IAM users in the development account to assume the role.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '84', '2', 'Create an IAM group in the development account. Grant IAM users in the development account membership in the group.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '84', '3', 'Create an IAM group in the production account. Grant IAM users in the development account membership in the group.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '84', '4', 'Create an IAM role in the development account. Allow IAM users in the development account to assume the role.', 'N', now(), now());

-- Q85
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '85', 'A customer wants to leverage Amazon Simple Storage Service (S3) and Amazon Glacier as part of their backup and archive infrastructure. The customer plans to use third-party software to support this integration. Which approach will limit the access of the third party software to only the Amazon S3bucket named "company-backup"? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '85', '1', 'A custom bucket policy limited to the Amazon S3 API in the Amazon Glacier archive companybackup', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '85', '2', 'A custom bucket policy limited to the Amazon S3 API in company-backup', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '85', '3', 'A custom IAM user policy limited to the Amazon S3 API for the Amazon Glacier archive companybackup', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '85', '4', 'A custom IAM user policy limited to the Amazon S3 API in company-backup', 'N', now(), now());

-- Q86
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '86', 'You Auto Scaling group is configured to launch one new Amazon EC2 instance if the overall CPU load exceeds 65% over a five-minute interval. Occasionally, the Auto Scaling group launches a second Amazon EC2 instance before the first is operational. The second instance is not required and introduces needless compute costs. How can you prevent the Auto Scaling group from launching the second instance? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '86', '1', 'Add a scaling-specific cooldown period to the scaling policy', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '86', '2', 'Configure a lifecycle hook for your Auto Scaling group', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '86', '3', 'Adjust the CPU threshold that triggers a scaling action', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '86', '4', 'Attach a new launch configuration to the Auto Scaling group', 'N', now(), now());

-- Q87
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '87', 'How can the domain''s zone apex, for example,"myzoneapexdomain.com", be pointed towards an Elastic Load Balancer? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '87', '1', 'By using an AAAA record', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '87', '2', 'By using an Amazon Route 53 CNAME record', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '87', '3', 'By using an Amazon Route 53 Alias record', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '87', '4', 'By using an A record', 'N', now(), now());

-- Q88
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '88', 'A company is using AWS Key Management Service (AWS KMS) to secure their Amazon RDS databases. An auditor has recommended that the company log all use of their AWS KMS keys What is me SIMPLEST solution? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '88', '1', 'Associate AWS KMS metrics with Amazon CloudWatch', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '88', '2', 'Use AWS CloudTrail to log AWS KMS key usage.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '88', '3', 'Deploy a monitoring agent on the RDS instances', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '88', '4', 'Poll AWS KMS periodically with a scheduled job', 'N', now(), now());

-- Q89
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '89', 'An instance is launched into a VPC subnet with the network ACL configured to allow all inbound traffic and deny all outbound traffic. The instance''s security group is configured to allow SSH form any IP address and deny all outbound traffic. What changes need to be made to allow SSH access to the instance? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '89', '1', 'The outbound security group needs to be modified to allow outbound traffic', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '89', '2', 'The outbound network ACL needs to be modified to allow outbound traffic', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '89', '3', 'Both the outbound security group and outbound network ACL need to modified to allow outbound traffic', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '89', '4', 'Nothing, it can be accessed from any IP using SSH', 'N', now(), now());

-- Q90
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '90', 'Fill in the blanks: Resources that are created in AWS are identified by a unique identifier called an __________ ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '90', '1', 'Amazon Resource Number', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '90', '2', 'Amazon Resource Name', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '90', '3', 'Amazon Resource Nametag', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '90', '4', 'Amazon Reesource Namespace', 'N', now(), now());

-- Q91
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '91', 'Is there a limit to how many groups a user can be in? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '91', '1', 'Yes unless special permission granted', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '91', '2', 'Yes for all users', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '91', '3', 'Yes for all users except root', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '91', '4', 'No', 'N', now(), now());

-- Q92
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '92', 'A media company asked a Solutions Architect to design a nighty available storage solution to serve as a centralized document store for their Amazon EC2 instances. The storage solution needs to be POSIX-compliant scale dynamically and be able to serve up to 100 concurrent EC2 instances. Which solution meets these requirements? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '92', '1', 'Create an Amazon S3 bucket and store all of the documents in this bucket.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '92', '2', 'Create an Amazon EBS volume and allow multiple users to mount that volume to their EC2 instance(s)', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '92', '3', 'Use Amazon Glacier to store all of the documents', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '92', '4', 'Create an Amazon Elastic File System (Amazon EFS) to store and share the documents.', 'N', now(), now());

-- Q93
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '93', 'A Solutions Architect must select the storage type tor a big data application that requires very high sequential I/O. The data must persist if the instance is stopped. Which of the following storage types will provide the best fit at the LOWEST cost for the application? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '93', '1', 'An Amazon EC2 instance store local SSD volume', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '93', '2', 'An Amazon EBS provisioned IOPS SSD volume', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '93', '3', 'An Amazon EBS throughput optimized HDD volume', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '93', '4', 'An Amazon EBS general purpose SSD volume', 'N', now(), now());

-- Q94
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '94', 'A workload in an Amazon VPC consist of an Elastic Load Balancer that distributes incoming requests across a fleet of six Amazon EC2 instances. Each EC2 instance stores and retrieves data from an Amazon DynamoDB table. Which of the following provisions will ensure that this workload a highly available? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '94', '1', 'Provision DynamoDB tables across a minimum of two Availability Zones', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '94', '2', 'Provision the EC2 instances evenly across a minimum of two Availability Zones in two regions', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '94', '3', 'Provision the EC2 instances evenly across a minimum of two Availability Zones in a single region', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '94', '4', 'Provision the Elastic Load Balancer to distribute connections across multiple Availability Zones', 'Y', now(), now());

-- Q95
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '95', 'A Solutions Architect needs to design an architecture for a new, mission-critical batch processing billing application. The application is requited to run Monday. Wednesday, and Friday from 5 AM to 11 AM. Which is the MOST cost-effective Amazon EC2 pricing model? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '95', '1', 'Amazon EC2 Spot Instances', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '95', '2', 'On-Demand Amazon EC2 Instances', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '95', '3', 'Scheduled Reserved instances', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '95', '4', 'Dedicated Amazon EC2 Instances', 'N', now(), now());

-- Q96
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '96', 'A company needs to monitor the read and write IOPs metrics for their AWS MySQL RDS instance and send real-time alerts to their operations team. Which AWS services can accomplish this? Choose 2 answers ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '96', '1', 'Amazon Simple Email Service', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '96', '2', 'Amazon CloudWatch', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '96', '3', 'Amazon Simple Queue Service', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '96', '4', 'Amazon Route 53', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '96', '5', 'Amazon Simple Notification Service', 'N', now(), now());

-- Q97
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '97', 'A Solutions Architect is creating a new relational database. The Compliance team will use the database and mandates that data content must be stored across three different Availability Zones. Which of the following options should the Architect use? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '97', '1', 'Amazon Aurora', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '97', '2', 'Amazon RDS MySQL with Multi-AZ enabled', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '97', '3', 'Amazon DynamoDB', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '97', '4', 'Amazon ElastiCache', 'N', now(), now());

-- Q98
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '98', 'What is the minimum interval for the data that Amazon CloudWatch receives and aggregates? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '98', '1', 'One second', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '98', '2', 'Five seconds', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '98', '3', 'One minutes', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '98', '4', 'Three minute', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '98', '5', 'Five minutes', 'N', now(), now());

-- Q99
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '99', 'When you put objects in Amazon 53, what is the indication that an object was successfullystored? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '99', '1', 'A HTTP 200 result code and MD5 checksum, taken together, indicate that the operation was successful', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '99', '2', 'A success code is inserted into the S3 object metadata', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '99', '3', 'Amazon S3 is engineered for 99.999999999% durability. Therefore there is no need to confirm that data was inserted.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '99', '4', 'Each S3 account has a special bucket named_ s3_logs. Success codes are written to this bucket with a timestamp and checksum', 'N', now(), now());

-- Q100
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '100', 'An application on an Amazon EC2 instance routinely stops responding to requests and requires a reboot to recover. The application logs are already exported into Amazon CloudWatch, and you notice that the problem consistently follows the appearance of a specific message in the log. The application team is working to address the bug, but has not provided a date for the fix. What workaround can you implement to automate recovery of the instance until the fix is deployed? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '100', '1', 'Create an Amazon CloudWatch alarm on instance memory usage; based on that alarm, trigger an Amazon CloudWatch action to reboot the instance', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '100', '2', 'Create an Amazon CloudWatch alarm on an Amazon CloudWatch Logs filter for that message; based on that alarm trigger an Amazon CloudWatch action to reboot the instance', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '100', '3', 'Create an AWS CloudTrail alarm to detect the deadlock; based on that alarm, trigger an Amazon SNS message to the Operations team', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '100', '4', 'Create an AWS CloudTrail alarm on low CPU; based on that alarm, trigger an Amazon SNS message to the Operations team', 'N', now(), now());

-- Q101
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '101', 'A company is deploying a new two-tier web application in AWS. The company has limited staff and requires high availability, and the application requires complex queries and table joins. Which configuration provides the solution for the company''s requirements? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '101', '1', 'mySQL installed on two Amazon EC2 instances in a single Availability Zone', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '101', '2', 'Amazon RDS for MySQL with Multi-AZ', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '101', '3', 'Amazon ElasticCache', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '101', '4', 'Amazon DynamoDB', 'N', now(), now());

-- Q102
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '102', 'For which of the following use cases are Simple Queue Service (SQS) and Amazon EC2 an appropriate solution? Choose 2 answers ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '102', '1', 'Using as a distributed session store for your web application', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '102', '2', 'Managing a multi-step and multi-decision checkout process of an e-commerce website', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '102', '3', 'Using as an SNS endpoint to trigger execution of video transcoding jobs', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '102', '4', 'Orchestrating the execution or distributed and auditable business processes', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '102', '5', 'Using as an encrypted to collect thousands of data points per hour from a distributed fleet of sensors', 'N', now(), now());

-- Q103
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '103', 'You are working with customer who has 10 TB of archival data that they want to migrate to Amazon Glacier. The customer has a 1Mbps connection to the Internet. Which service or feature provide the fastest method of getting the data into Amazon Glacier? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '103', '1', 'Amazon Glacier multipart upload', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '103', '2', 'AWS Storage Gateway', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '103', '3', 'VM Import/Export', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '103', '4', 'AWS Import/Export', 'Y', now(), now());

-- Q104
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '104', 'A mobile client requires data from several application-layer services to populate its user interface. What can the application team use to decouple the client interface from the underlying services behind them? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '104', '1', 'Application Load Balancer', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '104', '2', 'Amazon API Gateway', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '104', '3', 'Amazon Cognito', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '104', '4', 'AWS Device Farm', 'N', now(), now());

-- Q105
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '105', 'Two Auto Scaling applications, Application A and Application B, currently run within a shared set of subnets. A Solutions Architect wants to make sure that Application A can make requests to Application B, but Application B should be denied from making requests to Application ', 'Answer: C', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '105', '1', 'Which is the SIMPLEST solution to achieve this policy?', 'N', now(), now());

-- Q106
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '106', 'You have a CloudFront distribution configured with the following path patterns: When users request objects that start with ''static2/'', they are receiving 404 response codes. What might be the problem? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '106', '1', 'The "*" path pattern must appear before ''static1/*'' path', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '106', '2', 'CloudFront distributions cannot have origins in different AWS regions', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '106', '3', 'CloudFront distributions cannot have multiple different origin types', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '106', '4', 'The ''*'' path pattern must appear after the ''static2/*'' path', 'N', now(), now());

-- Q107
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '107', 'An application on an Amazon EC2 instance routinely stops responding to requests and requires a reboot to recover. The application logs are already exported into Amazon CloudWatch, and you notice that the problem consistently follows the appearance of a specific message in the log. The application team is working to address the bug, but has not provided a date for the fix. What workaround can you implement to automate recovery of the instance until the fix is deployed?', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '107', '1', 'Create an Amazon CloudWatch alarm on instance memory usage; based on that alarm, trigger an Amazon CloudWatch action to reboot the instance', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '107', '2', 'Create a AWS CloudTrail alarm on low CPU; based on that alarm, trigger an Amazon SNS message to the Operations team', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '107', '3', 'Create an Amazon CloudWatch alarm on an Amazon CloudWatch Logs for that message; based on that alarm, trigger an Amazon CloudWatch action to reboot the instance', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '107', '4', 'Create an AWS CloudTrail alarm to detect the deadlock; based on that alarm, trigger an Amazon SNS message to the Operations team', 'N', now(), now());

-- Q108
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '108', 'You are migrating a MySQL database to Amazon RDS. You have allocated enough block storage for the initial migration. You expect data storage requirements to grow slowly over time: How can you expand the storage capacity of your Amazon RDS database instance in the future? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '108', '1', 'Allocate additional storage as needed. Plan for a brief database outage during the allocation.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '108', '2', 'Migrate the data base to a larger instance type as needed. Plan for a period of reduced performance during the migration', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '108', '3', 'Migrate the database to a larger instance type as needed. Plan for a brief database outage during the migration', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '108', '4', 'Allocate additional storage as needed. Plan for a period of reduced performance during the allocation', 'N', now(), now());

-- Q109
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '109', 'Can the string value of ''Key'' be prefixed with laws? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '109', '1', 'No', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '109', '2', 'Yes', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '109', '3', 'Only for S3 not EC', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '109', '4', 'Only for EC2 not S3', 'N', now(), now());

-- Q110
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '110', 'A Solutions Architect must design an Amazon DynamoDB table to store data about customer activities. The data is used to analyze recent customer behavior, so data that is less than a week old is heavily accessed and older data is accessed infrequently. Data that is more than one month old never needs to be referenced by the application but needs to be archived for year-end analytics. ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '110', '1', 'Use DynamoDB time-to-live settings to expire items after a certain time period', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '110', '2', 'Provision a higher write capacity unit to minimize the number of partitions', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '110', '3', 'Create separate tables for each week''s data with higher throughput for the current week', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '110', '4', 'Pre-process data to consolidate multiple records to minimize write operations', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '110', '5', 'Export the old table data from DynamoDB to Amazon S3 using AWS Data Pipeline and delete the old table', 'N', now(), now());

-- Q111
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '111', 'Your company runs an application that generates several thousand 1-GB reports a month. Approximately 10% of these reports will be accessed once during the first 3 days and must beavailable on demand. After 30 days, reports are no longer accessed as a part of normal business processes but must be retained for compliance reasons. Which architecture would meet these requirements with the lowest cost? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '111', '1', 'Upload the reports to Amazon S3 Standard - Infrequent Access storage class. Set a lifecycle configuration on the bucket to transition the reports to Amazon Glacier after 30 days.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '111', '2', 'Upload the reports to Amazon Glacier. When reports are requested, copy them to Amazon S3 Standard storage class for access. Delete the copied reports after they have been viewed.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '111', '3', 'Upload the reports to Amazon S3 Standard storage class. Set a lifecycle configuration on the bucket to transition the reports to Amazon Glacier after 30 days.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '111', '4', 'Upload the reports to Amazon S3 Standard - Infrequent Access storage class. When reports are requested, copy them to Amazon S3 Standard storage class for access. Delete the copied reports after they have been viewed.', 'N', now(), now());

-- Q112
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '112', 'Which AWS Services are valid origins for an Amazon CloudFront distribution? Choose 2 answers ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '112', '1', 'Amazon RDS', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '112', '2', 'Amazon Glacier', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '112', '3', 'ELB Classic Load Balancer', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '112', '4', 'Amazon DynamoDB', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '112', '5', 'Amazon S3', 'N', now(), now());

-- Q113
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '113', 'In order to optimize performance for a compute cluster that requires low internode latency. Which of the following feature should you use? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '113', '1', 'EC2 dedicated instances', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '113', '2', 'Placement Groups', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '113', '3', 'Multiple Availability Zones', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '113', '4', 'VPC private subnets', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '113', '5', 'AWS Direct Connect', 'N', now(), now());

-- Q114
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '114', 'Can I detach the primary (eth0) network interface when the instance is running or stopped? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '114', '1', 'Depends on the state of the interface at the time', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '114', '2', 'Yes, You can.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '114', '3', 'No. You cannot', 'Y', now(), now());

-- Q115
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '115', 'You have been asked to design the storage layer for an application. The application requires disk performance of at least 100,000 IOPS in addition, the storage layer must be able to survive the loss of an individual disk. EC2 instance, or Availability Zone without any data loss. The volume you provide must have a capacity of at least 3 TB. Which of the following designs will meet these objectives''? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '115', '1', 'Instantiate an 12 8xlarge instance in us-east-1a Create a RAID 0 volume using the four 800GB SSDephemeral disks provided with the instance Provision 3x1 TB EBS volumes attach them to the instance and configure them as a second RAID 0 volume Configure synchronous, block-level replication from the ephemeral-backed volume to the EBS-backed volume.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '115', '2', 'Instantiate a c3 8xlarge Instance In us-east-1 Provision an AWS Storage Gateway and configure it for 3 TB of storage and 100 000 lOPS Attach the volume to the instance.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '115', '3', 'Instantiate a c3 8xlarge Instance in us-east-1 Provision 3x1TB EBS volumes attach them to the instance, and configure them as a single RAID 0 volume Ensure that EBS snapshots are performed every 15 minutes.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '115', '4', 'Instantiate an 12 8xlarge instance in us-east-1a create a raid 0 volume using the four 800GB SSD ephemeral disks provide with the Instance Configure synchronous block-level replication to an Identically configured Instance in us-east-1b.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '115', '5', 'Instantiate a c3 8xlarge instance in us-east-i provision 4x1TB EBS volumes, attach them to the instance, and configure them as a single RAID 5 volume Ensure that EBS snapshots are performed every 15 minutes.', 'N', now(), now());

-- Q116
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '116', 'A photo sharing service stores pictures in Amazon Simple Storage Service (S3) and allows application signin using an Open ID Connect compatible identity provider. Which AWS Security Token approach to temporary access should you use for the Amazon S3 operations? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '116', '1', 'SAML-based identity Federation', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '116', '2', 'Cross-Account Access', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '116', '3', 'AWS identity and Access Management roles', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '116', '4', 'Web identity Federation', 'N', now(), now());

-- Q117
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '117', 'Which combination of two policies enables AWS identity and access management crossaccount access? Choose 2 answers ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '117', '1', 'Permission policy', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '117', '2', 'Bucket policy', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '117', '3', 'Key policy', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '117', '4', 'Trust policy', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '117', '5', 'Access policy', 'N', now(), now());

-- Q118
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '118', 'A Solutions Architect is designing a stateful web application that will run for one year (24/7) and then be decommissioned. Load on this platform will be constant, using a number of r4.8xlarge instances. Key drivers for this system include high availability is not required. What is the MOST cost-effective way to purchase compute for this platform? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '118', '1', 'Scheduled Reserved instances', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '118', '2', 'Convertible Reserved Instances', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '118', '3', 'Standard Reserved instances', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '118', '4', 'Spot Instances', 'N', now(), now());

-- Q119
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '119', 'You have a web application running on Elastic Beanstalk using a RDS database instance. Using Amazon ElastiCache to store your web session data instead of storing it in the relational database will: Choose 2 answers ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '119', '1', 'Improve read/write performances of your session data', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '119', '2', 'Improve write performance by using ElasticCache to write to your database', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '119', '3', 'Reduce the load on your database instance', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '119', '4', 'Improve availability of your session data in an AZ failover scenario', 'N', now(), now());

-- Q120
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '120', 'A company is storing data on Amazon Simple Storage Service (S3). The company''s security policy mandates that data is encrypted at rest. Which of the following methods can achieve this? Choose 3 answers ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '120', '1', 'Use Amazon S3 server-side encryption with AWS key management Service managed keys', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '120', '2', 'Use Amazon S3 server-side encryption with customer-provided keys', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '120', '3', 'Use Amazon S3 server-side encryption with EC2 key pair', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '120', '4', 'Use Amazon S3 bucket policies to restrict access to the data at rest', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '120', '5', 'Encrypt the data on the client-side before ingesting to Amazon S3 using their own master key', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '120', '6', 'Use SSL to encrypt the data while in transit to Amazon S3', 'N', now(), now());

-- Q121
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '121', 'A Solutions Architect is deploying a new production MySQL database on AWS. It is critical that the database is highly available. What should the Architect do to achieve this goal with Amazon RDS? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '121', '1', 'Create a read replica of the primary database and deploy it in a different AWS Region', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '121', '2', 'Enable multi-AZ to create a standby database in a different Availability Zone', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '121', '3', 'Enable multi-AZ to create a standby database in a different AWS Region', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '121', '4', 'Create a read replica of the primary database and deploy it in a different Availability Zone', 'Y', now(), now());

-- Q122
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '122', 'An instance is launched into a VPC subnet with the network ACL configured to allow all inbound traffic and deny all outbound traffic. The instance''s security group is configured to allow SSH from any IP address and deny all outbound traffic. What changes need to be made to allow SSH access to the instance? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '122', '1', 'The outbound security group needs to be modified to allow outbound traffic.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '122', '2', 'The outbound network ACL needs to be modified to allow outbound traffic.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '122', '3', 'Nothing, it can be accessed from any IP address using SSH.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '122', '4', 'Both the outbound security group and outbound network ACL need to be modified to allow outbound traffic.', 'N', now(), now());

-- Q123
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '123', 'A company is developing several critical long-running applications hosted on Docker. How should a Solutions Architect design a solution to meet the scalability and orchestration requirements on AWS? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '123', '1', 'Use Amazon ECS and Service Auto Scaling', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '123', '2', 'Use Spot Instances for orchestration and for scaling containers on existing Amazon EC2 Instances.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '123', '3', 'Use AWS OpsWorks to launch containers in new Amazon EC2 instances', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '123', '4', 'Use Auto scaling groups to launch containers on existing Amazon EC2 instances.', 'N', now(), now());

-- Q124
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '124', 'Which Amazon elastic compute cloud feature can you query from within the instance to access instance properties? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '124', '1', 'Instance user data', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '124', '2', 'Amazon Machine Image', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '124', '3', 'Resource tags', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '124', '4', 'Instance metadata', 'Y', now(), now());

-- Q125
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '125', 'Which of the following items are required to allow an application deployed on an EC2 instance to write data to a DynamoDB table? Assume that to security keys are allowed to be stored on the EC2 instance. ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '125', '1', 'Launch an EC2 instance with the IAM user included in the launch configuration', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '125', '2', 'Create an IAM user that allows write access to the DynamoDB table', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '125', '3', 'Add an IAM user to a running EC2 instance', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '125', '4', 'Create an IAM role that allows write access to the dynamoDB table', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '125', '5', 'Add an IAM role to a running EC2 instance', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '125', '6', 'Launch an EC2 instance with the IAM role included in the launch configuration', 'N', now(), now());

-- Q126
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '126', 'In the context of MySQL, version numbers are organized as MySQL version = X.Y.Z. What does X denote here? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '126', '1', 'major version', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '126', '2', 'release level', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '126', '3', 'minor version', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '126', '4', 'version number', 'N', now(), now());

-- Q127
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '127', 'A Solutions Architect a VPC. Instances in a private subnet must to be able to establish IPv6 traffic to the Internet. The design must scale automatically and not incur any additional cost. This can be accomplished with: ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '127', '1', 'An egress-only internet gateway', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '127', '2', 'A NAT Gateway', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '127', '3', 'A custom NAT Instance', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '127', '4', 'A VPC endpoint', 'Y', now(), now());

-- Q128
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '128', 'You have an application running on a single Amazon EC2 instance with a 1 TB Amazon EBS magnetic volume. Using CloudWatch, you have found that Amazon EBS throughput is poor when the Amazon EC2 instance is under high network load. Which of the following may help improve performance? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '128', '1', 'Relaunch the instance as Amazon EBS-optimized', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '128', '2', 'Modify the instance to enable enhanced networking', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '128', '3', 'Migrate the Amazon EBS volume to a General Purpose volume', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '128', '4', 'Migrate the Amazon EBS volume to a provisioned IOPs volume', 'Y', now(), now());

-- Q129
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '129', 'A company is deploying a two-tier, highly available web application to AWS. Which service provides durable storage for static content while utilizing lower overall CPU resources for web tier? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '129', '1', 'Amazon S3', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '129', '2', 'Amazon EBS volume', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '129', '3', 'Amazon RDS instance', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '129', '4', 'Amazon EC2 instance store', 'N', now(), now());

-- Q130
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '130', 'Your application contains thousands of Images in an Amazon RDS MySQL instance. These images are frequently accessed and the number of images is growing rapidly. Which should you implement to reduce cost and improve application performance? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '130', '1', 'Create two Amazon RDS My SQL read replicas in different regions, and migrate the images to the cross-region read replicas', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '130', '2', 'Migrate the images to Amazon Glacier, and allow the end users to access the images through Amazon CloudFront', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '130', '3', 'Migrate the images to Amazon Elastic Block Store volumes, and allow the end users to access the images through Amazon CloudFront', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '130', '4', 'Migrate the images to Amazon Simple Storage Service, and allow the end udders to access the images through Amazon CloudFront', 'Y', now(), now());

-- Q131
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '131', 'Provisioned IOPS Costs: you are charged for the IOPS and storage whether or not you use them in a given month. ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '131', '1', 'TRUE', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '131', '2', 'FALSE', 'N', now(), now());

-- Q132
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '132', 'An Administrator is hosting on application on a single Amazon EC2 instance, which users can access by the public hostname. The administrator is adding a second instance, but does not want users to have to decide between many public hostnames. Which AWS service will decouple the users from specific Amazon EC2 instances? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '132', '1', 'Amazon SOS', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '132', '2', 'Auto Scaling group', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '132', '3', 'Amazon EC2 security group', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '132', '4', 'Amazon ELB', 'Y', now(), now());

-- Q133
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '133', 'You have a distributed application that periodically processes large volumes of data across multiple Amazon EC2 Instances. The application is designed to recover gracefully from Amazon EC2 instance failures. You are required to accomplish this task in the most cost-effective way. Which of the following will meet your requirements? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '133', '1', 'Spot Instances', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '133', '2', 'Reserved instances', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '133', '3', 'Dedicated instances', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '133', '4', 'On-Demand instances', 'N', now(), now());

-- Q134
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '134', 'Legacy applications currently send messages through a single Amazon EC2 instance, which then routes the messages to the appropriate destinations. The Amazon EC2 instance is a bottleneck and single point of failure, so the company would like to address these issues. Which services could address this architecture use case? (Select TWO) ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '134', '1', 'Amazon SNS', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '134', '2', 'AWS STS', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '134', '3', 'Amazon SQS', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '134', '4', 'Amazon Route 53', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '134', '5', 'AWS Glue', 'N', now(), now());

-- Q135
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '135', 'You have an EC2 Security Group with several running EC2 instances. You change the Security Group rules to allow inbound traffic on a new port and protocol, and launch several new instances in the same Security Group. The new rules apply: ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '135', '1', 'Immediately to all instances in the security group.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '135', '2', 'Immediately to the new instances only.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '135', '3', 'Immediately to the new instances, but old instances must be stopped and restarted before the new rules apply.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '135', '4', 'To all instances, but it may take several minutes for old instances to see the changes.', 'N', now(), now());

-- Q136
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '136', 'An organization designs a mobile application for their customers to upload photos to a site The application needs a secure login with MF', 'A.D. Use Amazon API Gateway and require SSE for photos.', 'Answer: A', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '136', '1', 'The organization wants to limit the initial ouiW time and maintenance of the solution. Which solution should a Solutions Architect recommend to meet the requirements?', 'N', now(), now());

-- Q137
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '137', 'A Solutions Architect is designing an Amazon VPC. Applications in the VPC must have private connectivity to Amazon DynamoDB in the same AWS Region. The design should route DynamoDB traffic through: ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '137', '1', 'VPC peering connection', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '137', '2', 'NAT gateway', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '137', '3', 'VPC endpoint', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '137', '4', 'AWS Direct Connect', 'N', now(), now());

-- Q138
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '138', 'You manually launch a NAT AMI in a public subnet. The network in properly configured. Security groups and network access control lists are properly configured. Instances in a private subnet can access the NAT. The NAT can access the internet. However, private instances cannot access the internet. What additional step is required to allow access from the private instances? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '138', '1', 'Enable Source/Destination check on the private instances', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '138', '2', 'Enable Source/Destination check on the NAT instance', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '138', '3', 'Disable Source/Destination check on the private instance', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '138', '4', 'Disable Source/Destination check on the NAT instance', 'Y', now(), now());

-- Q139
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '139', 'How frequently does the Amazon CloudWatch Logs agent send data by default? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '139', '1', 'Every five seconds', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '139', '2', 'Every minute', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '139', '3', 'Every five seconds and is configurable by the user', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '139', '4', 'Every minute and is configurable by the user', 'N', now(), now());

-- Q140
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '140', 'A company needs to quickly ensure that all files created in an Amazon S3 bucket in us-east-1 are also available in another bucket in ap-southeast-2. Which option represents the SIMPLEST way to implement this design? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '140', '1', 'Add an S3 lifecycle rule to move any new files from the bucket in us-east-1 to the bucket in apsoutheast-2.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '140', '2', 'Create a Lambda function to be triggered for every new file in us-east-1 that copies the file to the bucket in ap-southeast-2', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '140', '3', 'Use SNS to notify the bucket in ap-southeast-2 to create a file whenever a file is cheated in the bucket in us-east-1.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '140', '4', 'Enable versioning and configure cross-region replication from the bucket in us-east-1 to the bucket in ap-southeast-2.', 'Y', now(), now());

-- Q141
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '141', 'A Solutions Architect is architecting a workload that requires a performant object-based storage system that must be shared with multiple Amazon EC2 instances. Which AWS service meetsthis requirement? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '141', '1', 'Amazon EPS', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '141', '2', 'Amazon S3', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '141', '3', 'Amazon EBS', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '141', '4', 'Amazon ElastiCache', 'N', now(), now());

-- Q142
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '142', 'You try to connect via SSH to a newly created Amazon EC2 instance and get one of the following error messages: "Network error: Connection timed out" or "Error connecting to [instance], reason: -> Connection timed out: connect," You have confirmed that the network and security group rules are configured correctly and the instance is passing status checks. What steps should you take to identify the source of the behavior? Choose 2 answers ', '', '', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '142', '1', 'Verify that your IAM user policy has permission to launch Amazon EC2 instances.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '142', '2', 'Verify that the private key file corresponds to the Amazon EC2 key pair assigned at launch.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '142', '3', 'Verify that your federation trust to AWS has been established.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '142', '4', 'Verify that the Amazon EC2 Instance was launched with the proper IAM role.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '142', '5', 'Verify that you are connecting with the appropriate user name for your AMI.', 'N', now(), now());

-- Q143
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '143', 'Which of the following cannot be used in Amazon EC2 to control who has access to specific Amazon EC2 instances? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '143', '1', 'Security Groups', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '143', '2', 'SSH keys', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '143', '3', 'IAM System', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '143', '4', 'Windows passwords', 'N', now(), now());

-- Q144
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '144', 'You have a Cassandra cluster running in private subnets in an Amazon VPC. A new application in a different Amazon VPC needs access to the database. How can the new application access the database? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '144', '1', 'Set up a VPC peering connection between the two Amazon VPCs.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '144', '2', 'Set up a dual-homed instance with ENIs in both Amazon VPCs.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '144', '3', 'Set up a NAT Gateway in the application''s Amazon VP', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '144', '4', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '144', '5', 'Set up a NAT Gateway in the database''s Amazon VP', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '144', '6', '', 'N', now(), now());

-- Q145
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '145', 'A Solutions Architect is designing a solution that can monitor memory and disk space utilization of all Amazon EC2 instances running Amazon Linux and Windows. Which solution meets this requirement? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '145', '1', 'Default Amazon CloudWatch metrics', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '145', '2', 'Custom Amazon CloudWatch metrics', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '145', '3', 'Amazon inspector resource monitoring', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '145', '4', 'Detailed monitoring of Amazon EC2 instances', 'N', now(), now());

-- Q146
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '146', 'If I write the below command, what does it do? ec2-run ami-e3a5408a -n 20 -g appserver ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '146', '1', 'Creates 20 rules in the security group named appserver', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '146', '2', 'Terminate twenty instances as members of appserver group.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '146', '3', 'Start twenty instances as members of appserver group.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '146', '4', 'Start 20 security groups', 'N', now(), now());

-- Q147
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '147', 'You are building a solution for a customer to extend their on-premises data centre to AWS. The customer requires a 50-Mbps dedicated and private connection to their VPC. Which AWS product or feature satisfies this requirement? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '147', '1', 'Amazon VPC peering', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '147', '2', 'Elastic IP Addresses', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '147', '3', 'Amazon VPC virtual private gateway', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '147', '4', 'AWS Direct Connect', 'Y', now(), now());

-- Q148
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '148', 'A company has a workflow that uploads video files from their data center to AWS for transcoding. They use Amazon EC2 worker instances that pull transcoding jobs from SQS. Why is SQS an appropriate service for this scenario? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '148', '1', 'SQS decouples the transcoding task from the upload.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '148', '2', 'SQS can accommodate message payloads of any size.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '148', '3', 'SQS checks the health of the worker instances.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '148', '4', 'SQS synchronously provides transcoding output.', 'N', now(), now());

-- Q149
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '149', 'Which of the following items are required to allow an application deployed on an EC2 instance to write data to a Dynamo DB table? Assume that no security keys are allowed to be stored on the EC2 instance? Choose 2 answers ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '149', '1', 'Add an IAM Role to a running EC2 instance', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '149', '2', 'Launch an EC2 instance with the IAM Role included in the launch configuration', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '149', '3', 'Create an IAM User that allows write access to the DynamoDB table', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '149', '4', 'Create an IAM role that allows write access to the DynamoDB table', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '149', '5', 'Launch an EC2 instance with the IAM user included in the launch configuration', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '149', '6', 'Add an IAM user to a running EC2 instance', 'N', now(), now());

-- Q150
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '150', 'Which set of Amazon 53 features helps to prevent and recover from accidental data loss?', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '150', '1', 'Object lifecycle and service access logging', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '150', '2', 'Object versioning and Multi-factor authentication', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '150', '3', 'Access controls and server-side encryption', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '150', '4', 'Website hosting and Amazon S3 policies', 'N', now(), now());

-- Q151
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '151', 'When an EC2 instance that is backed by an s3based AMI is terminated .What happens to the data on the root volume? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '151', '1', 'Data is unavailable until the instance is restarted', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '151', '2', 'Data is automatically deleted', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '151', '3', 'Data is automatically saved as an EBS snapshot', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '151', '4', 'Data is automatically saved as an EBS volume', 'N', now(), now());

-- Q152
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '152', 'You need a solution to distribute traffic evenly across all of the containers for a task running on Amazon ECS. Your task definitions define dynamic host port mapping for your containers. What AWS feature provides this functionality? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '152', '1', 'All elastic Load balancing instances support dynamic host port mapping', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '152', '2', 'Application load balancers support dynamic host port mapping', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '152', '3', 'CloudFront custom origins support dynamic host port mapping', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '152', '4', 'Classic load balancers support dynamic host port mapping', 'N', now(), now());

-- Q153
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '153', 'You need to configure an Amazon S3 bucket to serve static assets for your public-facing web application. Which methods ensure that all objects uploaded to the bucket are set to public read? Choose 2 answers ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '153', '1', 'Set permissions on the object to public read during upload', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '153', '2', 'Configure the bucket ACL to sell all objects to public read', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '153', '3', 'Configure the bucket policy to set all objects to public read', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '153', '4', 'Use AWS identity and access Management roles to set the bucket to public read', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '153', '5', 'Amazon S3 objects default to public read, so no action is needed', 'N', now(), now());

-- Q154
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '154', 'You have a database application running on two instances in Amazon EC2.This application runs 24x7x365 and has a consistent and predictable workload. You want to choose the most costeffective pricing model. What kind of Amazon EC2 instances should you use? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '154', '1', 'Dedicated instances', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '154', '2', 'On-demand instances', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '154', '3', 'Reserved instances', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '154', '4', 'Spot instances', 'N', now(), now());

-- Q155
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '155', 'Every user you create in the IAM system starts with _________. ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '155', '1', 'Partial permissions', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '155', '2', 'Full permissions', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '155', '3', 'No permissions', 'Y', now(), now());

-- Q156
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '156', 'You have launched an Amazon elastic compute cloud (EC2) instance in a VPC with an attached internet gateway. You assigned a public IP address to the Amazon EC2 instance but cannot connect from your on-premises client via SSH. Which of the following may be the cause of the behavior experienced? Choose 2 answers ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '156', '1', 'An incorrect security group rule for inbound SSH traffic', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '156', '2', 'An incorrect policy in the AWS IAM service', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '156', '3', 'An incorrect AWS IAM role used in the Amazon EC2 instances', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '156', '4', 'An incorrect routes in the subnet''s route table', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '156', '5', 'An incorrect security group rule for outbound SSH traffic', 'N', now(), now());

-- Q157
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '157', 'When will you incur costs with an Elastic IP address (EIP)? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '157', '1', 'When an EIP is allocated', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '157', '2', 'When it is allocated and associated with a running instance', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '157', '3', 'When it is allocated and associated with a stopped instance', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '157', '4', 'Costs are incurred regardless of whether the EIP associated with a running instance', 'N', now(), now());

-- Q158
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '158', 'If you want to launch Amazon Elastic Compute Cloud (EC2) instances and assign each instance a predetermined private IP address you should: ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '158', '1', 'Launch the instance from a private Amazon Machine Image (AMI).', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '158', '2', 'Assign a group of sequential Elastic IP address to the instances.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '158', '3', 'Launch the instances in the Amazon Virtual Private Cloud (VPC).', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '158', '4', 'Launch the instances in a Placement Group.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '158', '5', 'Use standard EC2 instances since each instance gets a private Domain Name Service (DNS) already.', 'N', now(), now());

-- Q159
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '159', 'A user in account A has created a bucket and added a bucket policy allowing all actions for a user in account B. the user in account B has uploaded a file to the bucket, specifying Amazon S3 server-side encryption (SSE) and Amazon S3 reduced redundancy storage (RRS). Using the AWS management console, the user in account A attempts to download the file from the bucket but gets an "Access Denied" error. What is causing the error? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '159', '1', 'Account A user has not granted READ permission to itself', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '159', '2', 'Account B user has not granted READ permission to account A user', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '159', '3', 'SSE and RRS cannot be used on an object at the same time', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '159', '4', 'An SSE object cannot be copied between two different accounts', 'N', now(), now());

-- Q160
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '160', 'A Solutions Architect is designing a microservice to process records from Amazon Kinesis Streams. The metadata must be stored a Amazon DynamoDB. The microservice most be capable of concurrently processing 10.000 records daily as they arrive in the Kinesis stream. The MOST scalable way to design the microservice is: ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '160', '1', 'As an AWS Lambda function', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '160', '2', 'As a process on an Amazon EC2 instance.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '160', '3', 'As a Docker container running on Amazon ECS', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '160', '4', 'As a Docker container on an EC2 instance', 'N', now(), now());

-- Q161
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '161', 'You have an application running on an Amazon Elastic Compute Cloud instance, that uploads 5 GB video objects to Amazon Simple Storage Service (S3). Video uploads are taking longer than expected, resulting in poor application performance. Which method will help improve performance of your application? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '161', '1', 'Enable enhanced networking', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '161', '2', 'Use Amazon S3 multipart upload', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '161', '3', 'Leveraging Amazon CloudFront, use the HTTP POST method to reduce latency.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '161', '4', 'Use Amazon Elastic Block Store Provisioned IOPs and use an Amazon EBS-optimized instance', 'N', now(), now());

-- Q162
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '162', 'A user in account A has created a bucket and added a bucket policy allowing all actions for a user in account B. The user in account B has uploaded a file to the bucket, specifying Amazon S3 server-side encryption (SSE) and Amazon S3 reduced redundancy storage (RRS). Using the AWS management console, the user in account A attempts to download the file from the bucket but gets an "Access Denied" error. What is causing the error? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '162', '1', 'SSE and RRS cannot be used on an object at the same time', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '162', '2', 'Account B user has not granted READ permission to account A user', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '162', '3', 'Account A user has not granted READ permission to itself', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '162', '4', 'An SSE object cannot be copied between two different accounts', 'N', now(), now());

-- Q163
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '163', 'What is one key difference between an Amazon EBSbacked and an instancestore backed instance? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '163', '1', 'Amazon EBS-backed instances can be stopped and restarted', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '163', '2', 'Instance-store backed instances can be stopped and restarted', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '163', '3', 'Auto scaling requires using Amazon EBS-backed instances', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '163', '4', 'Virtual Private Cloud requires EBS backed instances', 'N', now(), now());

-- Q164
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '164', 'You have been asked to design a fault-tolerant and scalable web application across three Availability Zones. The presentation logic will reside on web server''s behinds an ELB Classic Load Balance, and the application logic will reside on a set of app servers behind a second load balancer. How should you use Auto Scaling groups? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '164', '1', 'Deploy two Auto Scaling groups: one for the web servers in all Availability Zones and one for the app servers in all Availability Zones', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '164', '2', 'Deploy six Auto Scaling groups: a web server group in each Availability Zone and an app server group in each Availability Zone', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '164', '3', 'Deploy one Auto Scaling group that includes all the web and app servers across all Availability Zones', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '164', '4', 'Deploy three Auto Scaling groups: one for each Availability Zone that includes both web and app servers', 'N', now(), now());

-- Q165
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '165', 'You are deploying an application to collect votes for a very popular television show. Millions of users will submit votes using mobile devices. The votes must be collected into a durable, scalable, and highly available data store for real-time public tabulation. Which service should you use? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '165', '1', 'Amazon DynamoDB', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '165', '2', 'Amazon Redshift', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '165', '3', 'Amazon Kinesis', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '165', '4', 'Amazon Simple Queue Service', 'N', now(), now());

-- Q166
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '166', 'Which AWS service allows you to collect and process e-commerce data for near real-time analysis? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '166', '1', 'Amazon Redshift', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '166', '2', 'Amazon DynamoDB', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '166', '3', 'Amazon Elastic Map reduce', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '166', '4', 'Amazon ElasticCache', 'N', now(), now());

-- Q167
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '167', 'A Solutions Architect is developing a solution for sharing files in an organization. The solution must allow multiple users to access the storage service at once from different virtual machines and scale automatically. It must also support file-level locking. Which storage service meets the requirements of this use case? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '167', '1', 'Amazon S3', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '167', '2', 'Amazon EFS', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '167', '3', 'Amazon EBS', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '167', '4', 'Cached Volumes', 'N', now(), now());

-- Q168
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '168', 'A business-critical MySql database is running on an Amazon EC2 instance. Storage Performance and durability are important to the application.Which volume type provides a persistent volume with single-digit millisecond latencies and sustained IOPS performance? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '168', '1', 'Amazon EC2 instance store', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '168', '2', 'Amazon EBS Cold HDD', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '168', '3', 'Amazon EBS provisioned IOPS SSD', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '168', '4', 'Amazon EBS General purpose SSD', 'N', now(), now());

-- Q169
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '169', 'A customer is complaining that requests made to theirload balancer are closing prematurely. The customer also mentions that the issue only happens when waiting for the multiweek report to be generated. Which option will resolve the customer''s issue? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '169', '1', 'Adjust the timeout on health check settings', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '169', '2', 'Increase the idle timeout on registered instances', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '169', '3', 'Disable connection draining on the load balancer', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '169', '4', 'Enable stickiness on the load balancer', 'N', now(), now());

-- Q170
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '170', 'A company uses Amazon S3 for storing a variety of files. A Solutions Architect needs to design a feature that will allow users to instantly restore any deleted files within 30 days of deletion. Which is the Most cost-efficient solution? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '170', '1', 'Create lifecycle policies that move the objects to Amazon Glacier and delete them after 30 days', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '170', '2', 'Enable cross-region replication. Empty the replica bucket every 30 days using an AWS Lambda function', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '170', '3', 'Enable versioning and create a lifecycle policy to remove expired versions after 30 days', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '170', '4', 'Enable versioning and MFA Delete. Using a Lambda function, remove MFA delete from objects more than 30 days old', 'N', now(), now());

-- Q171
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '171', 'When creation of an EBS snapshot is initiated, but not completed, the EBS volume: ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '171', '1', 'Can be used while the snapshot is in progress', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '171', '2', 'Cannot be used until the snapshot completes', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '171', '3', 'Can be used in read-only mode while the snapshot is in progress', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '171', '4', 'Cannot be detached or attached to an EC2 instance until the snapshot completes', 'N', now(), now());

-- Q172
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '172', 'A Solutions Architect is designing an application that requires having six Amazon EC2 instances running at all times. The application will be deployed in the sa-east-1 region, which has three Availability Zones: sa-east-la, sa-east-1b, and sa-east-1c. Which action will provide 100 percent fault tolerance and the LOWEST cost in the event that one Availability Zone in the region becomes unavailable? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '172', '1', 'Deploy six Amazon EC2 instances in sa-east-1a, six Amazon EC2 instances in sa-east-1b, and six Amazon EC2 instances in sa-east-lc.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '172', '2', 'Deploy six Amazon EC2 instances in sa-east-1a, four Amazon EC2 instances in sa-east-lb, and two Amazon EC2 instances in sa-east-1c.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '172', '3', 'Deploy three Amazon EC2 instances in sa-east-1a, three Amazon EC2 instances in sa-east-1b, and three Amazon EC2 instances in sa-east-1c.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '172', '4', 'Deploy two Amazon EC2 instances in sa-east-1a, two Amazon EC2 instances in sa-east-1b, and two Amazon EC2 instances in sa-east-1c.', 'N', now(), now());

-- Q173
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '173', 'A customer wants to track access to their Amazon Simple Storage Service (S3) buckets and also use this information for their internal security and access audits. Which of the following will meet the Customer requirement? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '173', '1', 'Enable AWS CloudTrail to audit all Amazon S3 bucket access.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '173', '2', 'Enable server access logging for all required Amazon S3 buckets.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '173', '3', 'Enable the Requester Pays option to track access via AWS Billing', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '173', '4', 'Enable Amazon S3 event notifications for Put and Post.', 'N', now(), now());

-- Q174
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '174', 'You are building a system to distribute confidential training videos to employees. Using cloud front, what method could be used to serve content that is stored in S3, but not publically accessible from S3 directly? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '174', '1', 'Add the CloudFront account security group "amazon-ct/amazon-cf-sg" to the appropriate S3 bucket policy', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '174', '2', 'Create an Origin Access identity for CLoudFront and grant access to the objects in your S3 bucket to that OAI', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '174', '3', 'Create an identity and Access Amangeement User for CloudFornt and grant Access to the objects in your S3 bucket to that IAM user', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '174', '4', 'Create a S3 bucket policy that lists the Cloudfront distribution ID as the Principle and the target as the Amazon Resource Name', 'N', now(), now());

-- Q175
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '175', 'What are characteristics of Amazon S3? Choose 2 answers ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '175', '1', 'S3 allows you to store objects of virtually unlimited size.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '175', '2', 'S3 offers Provisioned IOPS.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '175', '3', 'S3 allows you to store unlimited amounts of data.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '175', '4', 'S3 should be used to host a relational database.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '175', '5', 'Objects are directly accessible via a URL.', 'N', now(), now());

-- Q176
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '176', 'Which of the following are true regarding AWS CloudTrail? Choose 3 answers ', '', '', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '176', '1', 'CloudTrail is enabled by default', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '176', '2', 'CloudTrail is enabled for all available services within a region.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '176', '3', 'CloudTrail is enabled on a per-region basis', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '176', '4', 'CloudTrail is enabled on a per-service basis.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '176', '5', 'Logs can only be processed and delivered to the region in which they are generated.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '176', '6', 'CloudTrail is enabled globally G. Logs can be delivered to a single Amazon S3 bucket for aggregation.', 'N', now(), now());

-- Q177
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '177', 'A company has configured and peered two VPCs: VPC-1 and VPC-2. VPC-1 contains only private subnets, and VPC-2 contains only public subnets. The company uses a single AWS Direct Connect connection and private virtual interface to connect their on-premises network with VPC-1. Which two methods increases the fault tolerance of the connection to VPC-1? Choose 2 answers ', '', '', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '177', '1', 'Establish a new AWS Direct Connect connection and private virtual interface in the same AWS region as VPC-1', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '177', '2', 'Establish a hardware VPN over the internet between VPC-1 and the on-premises network.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '177', '3', 'Establish a hardware VPN over the internet between VPC-2 ana the on-premises network.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '177', '4', 'Establish a new AWS Direct Connect connection and private virtual interface in the same region as VPC-2.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '177', '5', 'Establish a new AWS Direct Connect connection and private virtual interface in a different AWS region than VPC-1.', 'N', now(), now());

-- Q178
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '178', 'Can Amazon S3 uploads resume on failure or do they need to restart? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '178', '1', 'Restart from beginning', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '178', '2', 'You can resume them, if you flag the "resume on failure" option before uploading.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '178', '3', 'This question doesn''t make sense', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '178', '4', 'Resume on failure', 'Y', now(), now());

-- Q179
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '179', 'A company is storing a data on Amazon Simple Storage Service (S3). The company''s security policy mandates that data is encrypted at rest. Which of the following methods can achieve this? Choose 3 answers ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '179', '1', 'Use Amazon S3 server-side encryption with AWS key management service managed keys', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '179', '2', 'Use Amazon S3 server-side encryption with customer-provided keys', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '179', '3', 'Use Amazon S3 server-side encryption with EC2 key pair', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '179', '4', 'Use Amazon S3 bucket policies to restrict access to the data at rest', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '179', '5', 'Encrypt the data on the client-side before ingesting to Amazon S3 using their own master key', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '179', '6', 'Use SSL to encrypt the data while in transit to Amazon S3', 'N', now(), now());

-- Q180
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '180', 'A company needs to deploy services to an AWS region which they have not previously used. The company currently has an AWS identity and Access Management (IAM) role for the Amazon EC2 instances, which permits the instance to have access to Amazon DynamoDB. The company wants their EC2 instances in the new region to have the same privileges. How should the company achievethis? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '180', '1', 'Create a new IAM role and associated policies within the new region', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '180', '2', 'Assign the existing IAM role to the Amazon EC2 instances in the new region', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '180', '3', 'Copy the IAM role and associated policies to the new region and attach it to the instances', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '180', '4', 'Create an Amazon Machine Image (AMI) of the instance and copy it to the desired region using the AMI Copy feature', 'N', now(), now());

-- Q181
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '181', 'Can we attach an EBS volume to more than one EC2 instance at the same time? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '181', '1', 'Yes.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '181', '2', 'Only EC2-optimized EBS volumes.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '181', '3', 'No', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '181', '4', 'Only in read mode.', 'N', now(), now());

-- Q182
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '182', 'Which of the following approaches provides the lowest cost for Amazon Elastic Block Store snapshots while giving you the ability to fully restore data? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '182', '1', 'Maintain a single snapshots: the latest snapshot is both incremental and complete', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '182', '2', 'Maintain the most current snapshots, archive the original and incremental to Amazon Glacier', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '182', '3', 'Maintain a volume snapshot: subsequent snapshots will overwrite one another', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '182', '4', 'Maintain two snapshots: the original snapshot and the latest incremental snapshot', 'N', now(), now());

-- Q183
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '183', 'You are implementing a URL whitelisting system for a company that wants to restrict outbound HTTP''S connections to specific domains from their EC2-hosted applications you deploy a single EC2 instance running proxy software and configure It to accept traffic from all subnets and EC2 instances in the VPC. You configure the proxy to only pass through traffic to domains that you define in its whitelist configuration You have a nightly maintenance window or 10 minutes where ail instances fetch new software updates. Each update Is about 200MB In size and there are 500 instances In the VPC that routinely fetch updates After a few days you notice that some machines are failing to successfully download some, but not all of their updates within the maintenance window The download URLs used for these updates are correctly listed in the proxy''s whitelist configuration and you are able to access them manually using a web browser on the instances What might be happening? (Choose 2 answers) ', '', '', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '183', '1', 'You are running the proxy in a public subnet but have not allocated enough EIPs lo support the needed network throughput through the Internet Gateway (IGW)', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '183', '2', 'You are running the proxy on a affilelentiy-sized EC2 instance in a private subnet and its network throughput is being throttled by a NAT running on an undersized EC2 instance', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '183', '3', 'You are running the proxy on an undersized EC2 instance type so network throughput is not sufficient for all instances to download their updates in time.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '183', '4', 'The route table for the subnets containing the affected EC2 instances is not configured to direct network traffic for the software update locations to the proxy.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '183', '5', 'You have not allocated enough storage to the EC2 instance running me proxy so the network buffer is filling up. causing some requests to fall', 'N', now(), now());

-- Q184
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '184', 'A customer has a single 3-TB volume on-premises that is used to hold a large repository of images and print layout files. This repository is growing at 500 GB a year and must be presented as a single logical volume. The customers is becoming. Which AWS Storage Gateway configuration meets the customer requirements? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '184', '1', 'Gateway-Cached volumes with snapshots scheduled to Amazon S3', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '184', '2', 'Gateway-stored volumes with snapshots scheduled to Amazon S3', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '184', '3', 'Gateway-Virtual Tape library with snapshots to Amazon S3', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '184', '4', 'Gateway-Virtual tape library with snapshots to Amazon Glacier', 'N', now(), now());

-- Q185
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '185', 'In order to optimize performance for a compute cluster that requires low inter-node latency, which of the following feature should you use? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '185', '1', 'EC2 Dedicated Instances', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '185', '2', 'AWS Direct Connect', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '185', '3', 'VPC private', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '185', '4', 'Multiple Availability Zones', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '185', '5', 'Placement Groups', 'Y', now(), now());

-- Q186
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '186', 'A company''s website receives 50.000 requests each second, and the company wants 10 use multiple applications to analyze the navigation patterns of the users on their website so that the experience can Be personalized. What can a Solutions Architect use to collect page clicks for the website and process them sequentially for each user? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '186', '1', 'Amazon Kinesis Stream', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '186', '2', 'Amazon SQS standard queue', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '186', '3', 'Amazon SQS FIFO queue', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '186', '4', 'AWS CloudTrail trail', 'N', now(), now());

-- Q187
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '187', 'A news organization plans to migrate their 20 TB video archive to AWS. The files are rarely accessed, but when they are a request is made in advance and a 3- to 5-hour retrieval time frame is acceptable However, when there is a breaking news story, the editors require access to archived footage within minutes. Which storage solution meets the needs of this organization while providing the LOWEST cost of storage? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '187', '1', 'Store the archive in Amazon S3 Reduced Redundancy Storage.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '187', '2', 'Store the archive in Amazon Glacier and use standard retrieval for all content', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '187', '3', 'Store the archive in Amazon Glacier and pay the additional charge for expedited retrieval when needed', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '187', '4', 'Store the archive in Amazon S3 with a lifecycle policy to move this to S3 Infrequent Access after 30 days.', 'Y', now(), now());

-- Q188
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '188', 'You are designing the network infrastructure for an application server in Amazon VPC Users will access all the application instances from the Internet as well as from an on-premises network The on-premises network is connected to your VPC over an AWS Direct Connect link. How would you design routing to meet the above requirements? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '188', '1', 'Configure a single routing Table with a default route via the Internet gateway Propagate a default route via BGP on the AWS Direct Connect customer router Associate the routing table with all VPC subnets.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '188', '2', 'Configure a single routing table with two default routes: one to the internet via an Internet gateway the other to the on-premises network via the VPN gateway use this routing table across all subnets in your VP', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '188', '3', 'Configure a single routing table with a default route via the internet gateway Propagate specific routes for the on-premises networks via BGP on the AWS Direct Connect customer router Associate the routing table with all VPC subnets.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '188', '4', 'Configure two routing tables one that has a default route via the Internet gateway and another that has a default route via the VPN gateway Associate both routing tables with each VPC subnet.', 'N', now(), now());

-- Q189
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '189', 'A company needs to deploy virtual desktops to its customers in a virtual private cloud, leveraging existing security controls. Which set of AWS services and features will meet the company''s requirements? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '189', '1', 'Virtual private network connection, AWS Directory services, and ClassicLink', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '189', '2', 'Virtual private network connection, AWS Directory services, and Amazon WorkSpaces', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '189', '3', 'AWS Directory service, Amazon WorkSpaces, and AWS Identity and Access Management', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '189', '4', 'Amazon Elastic Compute Cloud, and AWS identity and access management', 'N', now(), now());

-- Q190
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '190', 'Which of the following are true regarding encrypted Amazon Elastic Block Store (EBS) volumes? Choose 2 answers ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '190', '1', 'Snapshots are automatically encrypted', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '190', '2', 'Existing volumes can be encrypted', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '190', '3', 'Supported on all Amazon EBS volume types', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '190', '4', 'Available to all instances types', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '190', '5', 'Shared volumes can be encrypted', 'N', now(), now());

-- Q191
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '191', 'For which of the following use cases are Simple Workflow Service (SWF) and Amazon EC2 an appropriate solution? Choose 2 answers ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '191', '1', 'Using as an endpoint to collect thousands of data points per hour from a distributed fleet of sensors', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '191', '2', 'Managing a multi-step and multi-decision checkout process of an e-commerce website', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '191', '3', 'Orchestrating the execution of distributed and auditable business processes', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '191', '4', 'Using as an SNS (Simple Notification Service) endpoint to trigger execution of video transcoding jobs', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '191', '5', 'Using as a distributed session store for your web application', 'N', now(), now());

-- Q192
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '192', 'A us-based company is expanding their web presence into Europe. The company wants to extend their AWS infrastructure from Northern Virginia (us-east-1) into the Dublin (eu-west-1) region. Which of the following options would enable an equivalent experience for users on both continents? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '192', '1', 'Use a public-facing load balancer per region to load-balancer web traffic, and enable HTTP health checks', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '192', '2', 'Use a public-facing load balancer per region to load balancer web traffic, and enable sticky sessions', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '192', '3', 'Use Amazon Route S3, and apply a geolocation routing policy to distribution traffic across both regions', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '192', '4', 'Use Amazon Route S3, and apply a weighted routing policy to distribute traffic across both regions', 'N', now(), now());

-- Q193
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '193', 'Through which of the following interfaces is AWS Identity and Access Management available? A) AWS Management Console B) Command line interface (CLI) C) IAM Query API D) Existing libraries ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '193', '1', 'Only through Command line interface (CLI)', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '193', '2', 'A and C', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '193', '3', 'All of the above', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '193', '4', 'A, B and C', 'N', now(), now());

-- Q194
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '194', 'A company is building software on AWS that requires access to various AWS services. Which configuration should be used to ensure that AWS credentials (i.e., Access Key ID/secret access key combination) are not compromised? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '194', '1', 'Enable Multi-factor Authentication for your AWS root account', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '194', '2', 'Assign an IAM role to the Amazon EC2 instance', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '194', '3', 'Store the AWS Access key ID/secret Access Key combination in software comments', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '194', '4', 'Assign an IAM user to the Amazon EC2 instance', 'N', now(), now());

-- Q195
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '195', 'A customer need to capture all client connection information from their load balancer every five minutes. The company wants to use this data for analyzing traffic patterns and troubleshooting their applications. Which of the following options meets the customer requirements? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '195', '1', 'Enable access logs on the load balancer', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '195', '2', 'Enable Amazon CloudWatch metrics on the load balancer', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '195', '3', 'Enable AWS CloudTrail for the load balancer', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '195', '4', 'Install the Amazon CloudWatch logs agent on the load balancer', 'N', now(), now());

-- Q196
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '196', 'Which of the following are characteristics of a reserved instance?', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '196', '1', 'It is specific to an Amazon Machine Image(AMI)', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '196', '2', 'It can be applied to instances launched by Auto Scaling', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '196', '3', 'It can be migrated across Availability Zones', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '196', '4', 'It can be used to lower Total Cost of Ownership (TCO) of a system', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '196', '5', 'It is specific to an insurance Type', 'N', now(), now());

-- Q197
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '197', 'Your company stores financial documents in amazon S3. Aacording to company policy, all financial documents must be retained for a perios of seven years. however documents older than one year are rarely accessed. How can you optimize cost? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '197', '1', 'Create an Amazon S3 lifecycle rule to move objects older than one year to storage Gateway', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '197', '2', 'Create an Amazon S3 lifecycle rule to move objects older than one year to Amazon Glacier', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '197', '3', 'Create an Amazon S3 event to move objects older than one year to Amazon Glacier', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '197', '4', 'Create an Amazon S3 event to move objects older than one year to Storage Gateway', 'N', now(), now());

-- Q198
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '198', 'A customer is hosting their company website on a cluster of web servers that are behind a public-facing load balancer. The customer also uses Amazon Route 53 to manage their public DNS. How should the customer configure the DNS zone apex record to point to the load balancer? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '198', '1', 'Create an A record pointing to the IP address of the load balancer', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '198', '2', 'Create a CNAME record aliased to the load balancer DNS name.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '198', '3', 'Create an A record aliased to the load balancer DNS name', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '198', '4', 'Create a CNAME record pointing to the load balancer DNS name.', 'N', now(), now());

-- Q199
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '199', 'Which technique can be used to integrate AWS IAM (Identity and Access Management) with an on-premise LDAP (Lightweight Directory Access Protocol) directory service? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '199', '1', 'Use an IAM policy that references the LDAP account identifiers and the AWS credentials.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '199', '2', 'Use SAML (Security Assertion Markup Language) to enable single sign-on between AWS and LDAP.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '199', '3', 'Use AWS Security Token Service from an identity broker to issue short-lived AWS credentials.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '199', '4', 'Use IAM roles to automatically rotate the IAM credentials when LDAP credentials are updated.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '199', '5', 'Use the LDAP credentials to restrict a group of users from launching specific EC2 instance types.', 'N', now(), now());

-- Q200
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '200', 'Which services can invoke AWS lambda functions? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '200', '1', 'Amazon Route53', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '200', '2', 'Amazon Redshift', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '200', '3', 'Elastic Load Blanching', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '200', '4', 'Amazon DynamoDB', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '200', '5', 'Amazon SNS', 'N', now(), now());

-- Q201
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '201', 'A Solutions Architect is building a multi-tier website. The web servers will be in a public subnet, and the database servers will be in a private subnet. Only the web servers can be accessed from the internet. The database servers must have Internet access for software updates. Which solution meets these requirements? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '201', '1', 'Assign Elastic IP addresses to the database instances', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '201', '2', 'Allow Internet traffic on the private subnet through the network ACL', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '201', '3', 'Use a NAT Gateway.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '201', '4', 'Use an egress-only internet Gateway', 'N', now(), now());

-- Q202
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '202', 'An Auto-Scaling group spans 3 AZs and currently has 4 running EC2 instances. When Auto Scaling needs to terminate an EC2 instance by default, AutoScaling will: Choose 2 answers ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '202', '1', 'Allow at least five minutes for Windows/Linux shutdown scripts to complete, before terminating the instance.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '202', '2', 'Terminate the instance with the least active network connections. If multiple instances meet this criterion, one will be randomly selected.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '202', '3', 'Send an SNS notification, if configured to do so.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '202', '4', 'Terminate an instance in the AZ which currently has 2 running EC2 instances.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '202', '5', 'Randomly select one of the 3 AZs, and then terminate an instance in that AZ.', 'N', now(), now());

-- Q203
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '203', 'A Solutions Architect has a two-tier blog application with a single Amazon EC2 instance web server and Amazon RDS MySQL Multi-AZ DB instances. The Architect is re-architecting the application for high availability by adding instances in a second Availability Zone. Which additional services will improve the availability of the application? (Select TWO) ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '203', '1', 'Auto Scaling group', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '203', '2', 'AWS CloudTrail', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '203', '3', 'ELB Classic Load Balancer', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '203', '4', 'Amazon DynamoDB', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '203', '5', 'Amazon ElasitCache', 'N', now(), now());

-- Q204
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '204', 'Per the AWS Acceptable Use Policy, Penetration testing of EC2 instances: ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '204', '1', 'Are expressly prohibited under all circumstances', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '204', '2', 'May be performed by AWS, and is periodically performed by AWS', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '204', '3', 'May be performed by the customer on their own instances, only if performed from EC2 instances', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '204', '4', 'May be performed by the customer on their own instances with prior authorization from AWS', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '204', '5', 'May be performed by AWS, and will be performed by AWS upon customer request', 'N', now(), now());

-- Q205
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '205', 'Your company moved into AWS and created separate AWs accounts per department. Toaddress latency and bandwidth challenges, the company ordered a single AWS Direct Connect circuit. How should you allocate the cost of the data transfer over AWS Direct Connect back to each department ? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '205', '1', 'Configure a connection per department and ta each with the department account number. Use details usage reports', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '205', '2', 'Configure a connection per department and set the Connection Owner to the department''s AWS account number', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '205', '3', 'Configure virtual interfaces and tag each with the department account number. Use detail usage reports', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '205', '4', 'Configure virtual interfaces and set the virtual interface owner to the department''s AWS account number', 'N', now(), now());

-- Q206
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '206', 'A bank is writing new software that is heavily dependent upon database transactions for write consistency. The application will also occasionally generate reports on data m the database, and will do joins across multiple tables. The database must automatically scale as the amount of data grows. Which AWS service should be used to run the database? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '206', '1', 'Amazon S3', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '206', '2', 'Amazon Aurora', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '206', '3', 'Amazon DynamoDB', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '206', '4', 'Amazon Redshift', 'N', now(), now());

-- Q207
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '207', 'A company is deploying a two tier, highly available web application to AWS. Which Service provides durable storage for static content while utilizing lower overall CPU resources for the web tier? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '207', '1', 'Amazon EBS volume', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '207', '2', 'Amazon S3', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '207', '3', 'Amazon EC2 instance store', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '207', '4', 'Amazon RDS instance', 'N', now(), now());

-- Q208
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '208', 'Which of the following instance types are available as Amazon EBS backend only? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '208', '1', 'General purpose T2', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '208', '2', 'General purpose M3', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '208', '3', 'Compute-optimized C4', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '208', '4', 'Compute-optimized C3', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '208', '5', 'Storage-optimized 12', 'N', now(), now());

-- Q209
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '209', 'A Solutions Architect is designing the storage layer for a production relation database. The database will run on Amazon EC2. The database is accessed by an application that performs intensive reads and writes, so the database requires the LOWEST random I/O latency.Which data storage method fulfils the above requirements? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '209', '1', 'Store data in a filesystem backed by Amazon Elastic File System (EFS)', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '209', '2', 'Store data Amazon S3 and use a third-party solution to expose Amazon S3 as a filesystem to the database server', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '209', '3', 'Store data in Amazon DynamoDB and emulate relational database semantics', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '209', '4', 'Stripe data across multiple Amazon EBS volume using RAID 0', 'Y', now(), now());

-- Q210
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '210', 'You are designing a web application that stores static assets in an Amazon Simple Storage Service (S3) bucket. You expect this bucket to immediately receive over 150 PUT requests per second. What should you do to ensure optimal performance? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '210', '1', 'Use multi-part upload.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '210', '2', 'Add a random prefix to the key names.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '210', '3', 'Amazon S3 will automatically manage performance at this scale.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '210', '4', 'Use a predictable naming scheme, such as sequential numbers or date time sequences, in the key names', 'N', now(), now());

-- Q211
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '211', 'Which route needs to be added to your routing table in order to allow connections to the internet from your subnet? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '211', '1', 'Destination: 0.0.0.0/0 target: 0.0.0.0/24', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '211', '2', 'Destination: 0.0.0.0/0 target: your internet Gateway', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '211', '3', 'Destination: 10.0.0.0/32 target: your Virtual Gateway', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '211', '4', 'Destination: 0.0.0.0/33 target: your internet gateway', 'N', now(), now());

-- Q212
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '212', 'A workload consists of downloading an image from an Amazon S3 bucket, processing the image, and moving it to another Amazon S3 bucket. An Amazon EC2 instance runs a scheduled task every hour lo perform the operation. How should a Solutions Architect redesign the process so that it is highly available? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '212', '1', 'Charge the Amazon EC2 instance to compute optimized', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '212', '2', 'Launch a second Amazon EC2 instance to monitor the health of the first', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '212', '3', 'Trigger a Lambda function when a new object is uploaded', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '212', '4', 'Initially copy the images to an attached Amazon EBS volume.', 'N', now(), now());

-- Q213
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '213', 'You require the ability to analyze a large amount of data, which is stored on Amazon S3 using Amazon Elastic Map Reduce. You are using the cc2 8x large Instance type, whose CPUs are mostly idle during processing. Which of the below would be the most cost efficient way to reduce the runtime of the job? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '213', '1', 'Create more smaller flies on Amazon S3.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '213', '2', 'Add additional cc2 8x large instances by introducing a task group.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '213', '3', 'Create fewer, larger files on Amazon S3.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '213', '4', 'Use smaller instances that have higher aggregate I/O performance.', 'Y', now(), now());

-- Q214
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '214', 'You run an adsupported photo sharing website using S3 to serve photos to visitors of your site. At some point you find out that other sites have been linking to the photos on your site, Causing loss to your business. What is an effective method to mitigate this? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '214', '1', 'Use CloudFront distributions for static content', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '214', '2', 'Store photos on an EBS volume of the web server', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '214', '3', 'Block the IPs of the offering websites in Security Groups', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '214', '4', 'Remove public read access and use signed URLs with expiry dates', 'Y', now(), now());

-- Q215
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '215', 'Which of the following are valid statements about Amazon S3? Choose 2 answers ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '215', '1', 'S3 provides read-after-write consistency for any type of PUT or DELETE', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '215', '2', 'Partially saved objects are immediately readable with a GET after an overwrite Put', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '215', '3', 'Consistency is not guaranteed for any type of PUT and DELETE', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '215', '4', 'A successful response to a PUT request only occurs when a complete object is saved', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '215', '5', 'S3 provides eventual consistency for overwrite PUTS and DELETES', 'N', now(), now());

-- Q216
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '216', 'You are launching an application in an Auto Scaling group. To store the user session state, you need a structured storage service with durability and low latency. Which service meets your needs? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '216', '1', 'Amazon DynamoDB', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '216', '2', 'Amazon EC2 instance storage', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '216', '3', 'Amazon S3', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '216', '4', 'Amazon ElastiCache', 'N', now(), now());

-- Q217
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '217', 'A company has reproducible data that they want to store on Amazon Web Services. The company may want to retrieve the data on a frequent basis. Which Amazon web services storage option allows the customer to optimize storage costs and still achieve high availability for their data? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '217', '1', 'Amazon S3 Reduced Redundancy Storage', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '217', '2', 'Amazon EBS Magnetic Volume', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '217', '3', 'Amazon Glacier', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '217', '4', 'Amazon S3 Standard Storage', 'N', now(), now());

-- Q218
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '218', 'On a single EC2 instance, which configuration provides the highest IOPS performance? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '218', '1', 'Using an EBS-optimized instance using provisioned IOPs volumes', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '218', '2', 'Striping across several EBS volumes using standards EBS volumes', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '218', '3', 'Using a High 1/0 instance using local instance storage volumes', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '218', '4', 'Striping across several EBS volumes using provisioned IOPs volumes', 'N', now(), now());

-- Q219
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '219', 'Your application currently stores data on an unencrypted EBS volume. A new security policy mandates that all data must be encrypted at rest. How can you encrypt the data? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '219', '1', 'Create a snapshot of the volume. Create a new, encrypted volume from the snapshot. Replace the volume.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '219', '2', 'Create a snapshot of the volume. Make an encrypted copy of the snapshot. Create a new volume from the new snapshot. Replace the volume.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '219', '3', 'Modify the EBS settings to encrypt the volume. You do need to detach the volume or stop the instance.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '219', '4', 'Stop the instance. Detach the volume. Modify the EBS settings to encrypt the volume. Reattach the volume. Start the instance.', 'N', now(), now());

-- Q220
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '220', 'If you''re unable to connect via SSH to your EC2 instance. Which of the following should you check and possibly correct to restore connectivity? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '220', '1', 'Adjust security group to permit egress traffic over TCP port 443 from your IP', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '220', '2', 'Modify the instance security group to allow ingress of ICMP packets from your IP', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '220', '3', 'Apply the most recently released Operating System security patches', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '220', '4', 'Configure the IAM role to permit changes to security group settings', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '220', '5', 'Adjust the instance''s Security Group to permit ingress traffic over port 22 from your IP', 'N', now(), now());

-- Q221
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '221', 'What does the "Server Side Encryption" option on Amazon S3 provide? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '221', '1', 'It provides an encrypted virtual disk in the Cloud.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '221', '2', 'It encrypts the files that you send to Amazon S3, on the server side.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '221', '3', 'It allows to upload files using an SSL endpoint, for a secure transfer.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '221', '4', 'It doesn''t exist for Amazon S3, but only for Amazon EC2.', 'N', now(), now());

-- Q222
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '222', 'A Solution Architect is trying to bring a data warehouse workload to an Amazon EC2 instance. The data will reside in Amazon EBS volumes and full table scans will be executed frequently. What type of Amazon AWS EBS volume would be most suitable in this scenario? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '222', '1', 'Throughput Optimized HDD (st1)', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '222', '2', 'Provisioned IOPS SSD (io1)', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '222', '3', 'General Purpose SSD (gp2)', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '222', '4', 'Cold HDD (sc1)', 'N', now(), now());

-- Q223
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '223', 'An Autoscaling group spans 3 AZs and currently has 4 running EC2 instances. When Auto scaling needs to terminate an EC2 instance, by default, Auto scaling will: ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '223', '1', 'Send an SNS notification, if configured to do so', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '223', '2', 'Allow at least five minutes for Windows/Linux shutdown scripts to complete, before terminating the instance', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '223', '3', 'Randomly select one of the 3 AZs, and then terminate an instance in that AZ', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '223', '4', 'Terminate an instance in the AZ which currently has 2 running EC2 instances', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '223', '5', 'Terminate the instance with the least active network connections if multiple instances meet this criterion, one will be randomly selected', 'N', now(), now());

-- Q224
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '224', 'What is the type of monitoring data (for Amazon EBS volumes) which is available automatically in 5-minute periods at no charge called? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '224', '1', 'Basic', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '224', '2', 'Detailed', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '224', '3', 'Primary', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '224', '4', 'Local', 'N', now(), now());

-- Q225
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '225', 'What is required in order to make a single web server in VPC (Virtual Private Cloud) publicity accessible? Choose 4 answers ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '225', '1', 'Configure an internet gateway', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '225', '2', 'Associate an Elastic IP to the web server', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '225', '3', 'Set up a NAT instance', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '225', '4', 'Alter the web server''s security group to allow inbound web traffic on ports being used to serve web traffic', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '225', '5', 'Configure the routing table of the subnet', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '225', '6', 'Add a CNAME record to your Route 53 hosted zone', 'N', now(), now());

-- Q226
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '226', 'A company is running both their website and human resources (HR) application within the same virtual private cloud (VPC). For company compliance and security reasons, the instances running their HR application stack must not share hardware with other AWS customers. The website owner wants to keep their infrastructure costs as low as possible. How can the company ensure that all of the requirements are met within a single VPC? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '226', '1', 'Create the VPC with Dedicated tenancy, launch the HR instances in placement groups, and launch the website instances in Shared tenancy', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '226', '2', 'Create the VPC with dedicated tenancy, launch the HR instances in Default tenancy, and launch the website instances in Shared tenancy', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '226', '3', 'Create the VPC with Default tenancy, launch the HR instances in placement groups, and launch the website instances in Shared tenancy', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '226', '4', 'Create the VPC with default tenancy, launch the HR instances in Dedicated tenancy, and launch the website instances in Shared tenancy', 'Y', now(), now());

-- Q227
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '227', 'You have a video transcoding application running on Amazon EC2. Each instance polls aqueue to find out which video should be transcoded, and then runs a transcoding process. If this process is interrupted, the video will be transcoded by another instance based on the queuing system. You have a large backlog of videos which need to be transcoded and would like to reduce this backlog by adding more instances. You will need these instances only until the backlog is reduced. Which type of Amazon EC2 instances should you use to reduce the backlog in the most cost efficient way? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '227', '1', 'Reserved instances', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '227', '2', 'Dedicated instances', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '227', '3', 'On-demand instances', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '227', '4', 'Spot instances', 'N', now(), now());

-- Q228
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '228', 'Which features can be used to restrict access to data in S3? Choose 2 answers ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '228', '1', 'Set an S3 ACL on the bucket or the object.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '228', '2', 'Create a CloudFront distribution for the bucket.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '228', '3', 'Set an S3 bucket policy.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '228', '4', 'Enable IAM Identity Federation', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '228', '5', 'Use S3 Virtual Hosting', 'N', now(), now());

-- Q229
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '229', 'When an EC2 EBS-backed (EBS root) instance is stopped, what happens to the data on any ephemeral store volumes? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '229', '1', 'Data is unavailable until the instance is restarted', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '229', '2', 'Data will be deleted and will no longer be accessible', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '229', '3', 'Data is automatically saved in an EBS snapshot', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '229', '4', 'Data is automatically saved in an EBS volume', 'N', now(), now());

-- Q230
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '230', 'Which auto scaling features allow you to scale ahead of expected increases in load? Choose 2 answers ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '230', '1', 'Cooldown period', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '230', '2', 'Metric-based scaling', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '230', '3', 'Health check grace period', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '230', '4', 'Scheduled scaling', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '230', '5', 'Lifecycle hooks', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '230', '6', 'Desired capacity', 'N', now(), now());

-- Q231
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '231', 'A company is designing a hybrid IT architecture and requires a private connection betweenan on-premises data center and their virtual private cloud (VPC). Which of the following would enable the company to achieve this? Choose 2 answers ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '231', '1', 'VPN connection', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '231', '2', 'AWS Direct connect', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '231', '3', 'AWS DataPipeline', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '231', '4', 'Amazon Route53', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '231', '5', 'ClassicLink', 'N', now(), now());

-- Q232
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '232', 'A company is evaluating Amazon S3 as a data storage solution for their daily analyst reports. The company has implemented stringent requirements concerning the security of the data at test Specifically, the CISO asked for the use of envelope encryption with separate permissions for the use of an envelope key, automated rotation of the encryption keys, and visibility into when an encryption key was used and by whom. Which steps should a Solutions Architect take to satisfy the security requirements requested by the CISO? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '232', '1', 'Create an Amazon S3 bucket to store the reports and use Server-Side Encryption with CustomerProvided Keys (SSE-C)', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '232', '2', 'Create an Amazon S3 bucket to store the reports and use Server-Side Encryption with Amazon S3Managed Keys (SSE-S3)', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '232', '3', 'Create an Amazon S3 bucket to store the reports and use Server-Side Encryption with AWS KMSManaged Keys (SSE-KMS)', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '232', '4', 'Create an Amazon S3 bucket to store the reports and use Amazon S3 versioning with Server- Side Encryption with Amazon S3-Managed Keys (SSE-S3)', 'N', now(), now());

-- Q233
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '233', 'A customer is hosting their company website on a cluster of web servers that are behind a public-facing load balancer. The customer also uses Amazon Route S3 to manage their public DNS. How should the customer configure the DNS zone apex record to point to the load balancer? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '233', '1', 'Create a CNAME record pointing to the load balancer DNS name', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '233', '2', 'Create a CNAME record aliased to the load balancer DNS name', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '233', '3', 'Create an A record pointing to the IP address of the load balancer', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '233', '4', 'Create an A record aliased to the load balancer DNS name', 'N', now(), now());

-- Q234
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '234', 'You try to connect via SSH to a newly created Amazon EC2 instance and get one of the error messages: "Network error: Connection timed out" or "Error connecting to [instance], reason: -> Connection timed out connect," You have confirmed that the network and security group rules are configured correctly and the instance is passing status checks. What steps should you take to identify the source of the behavior? Choose 2 answers ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '234', '1', 'Verify that your IAM user policy has permission to launch Amazon EC2 instances', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '234', '2', 'Verify that you are connecting with the appropriate user name for your AMI', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '234', '3', 'Verify that the Amazon EC2 instance was launched with the proper IAM role', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '234', '4', 'Verify that your federation trust to AWS has been established', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '234', '5', 'Verify that the private key file corresponds to the Amazon EC2 key pair assigned at launch', 'N', now(), now());

-- Q235
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '235', 'Which of the following are valid statements about Amazon S3? Choose 2 answers ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '235', '1', 'S3 provides read-after-write consistency for any type of PUT or DELET', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '235', '2', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '235', '3', 'Consistency is not guaranteed for any type of PUT or DELET', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '235', '4', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '235', '5', 'A successful response to a PUT request only occurs when a complete object is saved.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '235', '6', 'Partially saved objects are immediately readable with a GET after an overwrite PUT.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '235', '7', 'S3 provides eventual consistency for overwrite PUTS and DELETES.', 'N', now(), now());

-- Q236
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '236', 'A colleague asked for your advice about how to easily deploy, monitor, and scale a threetier LAMP (Linux, Apache, MySQL, PHP) application on AWS. Your colleague has time and staffing constraints and wants to deploy and manage the application with minimal effort. What AWS service would you suggest? ', '', '', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '236', '1', 'Data Pipeline', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '236', '2', 'Elastic Beanstalk', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '236', '3', 'CloudFormation', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '236', '4', 'CodeDeploy', 'N', now(), now());

-- Q237
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '237', 'An existing application stores sensitive information on a non-boot Amazon EBS data volume attached to an Amazon Elastic Compute Cloud instance. Which of the following approaches would protect the sensitive data on an Amazon EBS volume? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '237', '1', 'Snapshot the current Amazon EBS volume. Restore the snapshot to a new, encrypted Amazon EBS volume Mount the Amazon EBS volume', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '237', '2', 'Create and mount a new, encrypted Amazon EBS volume. Move the data to the new volume. Delete the old Amazon EBS volume', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '237', '3', 'Unmount the EBS volume. Toggle the encryption attribute to True. Re-mount the Amazon EBs volume', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '237', '4', 'Upload your customer keys to AWS CloudHSM. Associate the Amazon EBS volume with AWS CloudHSM. Re-mount the Amazon EBS volume', 'N', now(), now());

-- Q238
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '238', 'You''re building an API backend available at services.yourcompany.com. The API is implemented with API Gateway and Lambda. You successfully tested the API using curl. You implemented JavaScript to call the API from a webpage on your corporate website, www.yourcompany.com. When you access that page in your browser, you get the following error:"The same origin policy disallows reading the remote resource" How can you allow your corporate webpages to invoke the API? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '238', '1', 'Enable CORS in the API Gateway', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '238', '2', 'Enable CORS in the JavaScript frontend', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '238', '3', 'Disable CORS in the JavaScript frontend', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '238', '4', 'Disable CORS in the API Gateway', 'N', now(), now());

-- Q239
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '239', 'You have an Amazon EC2 instance that belongs to two security groups. The first security group has a rule that allows ingress traffic to TCP port 80 from IP address 206.251.8.21 and the second security group has a rule that allows ingress traffic to TCP ports 80 and 443 from everywhere. Which traffic is allowed to the Amazon EC2 instance? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '239', '1', 'Only ingress traffic to TCP port 80 from everywhere', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '239', '2', 'Only ingress traffic to TCP port 80 from 206.251.8.21', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '239', '3', 'Only ingress traffic to TCP ports 80 and 443 from everywhere', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '239', '4', 'Only ingress traffic to TCP ports 80 and 443 from 206.251.8.21', 'Y', now(), now());

-- Q240
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '240', 'You have a content management system running on an Amazon EC2 instance that is approaching 100% CPU utilization. Which option will reduce load on the Amazon EC2 instance? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '240', '1', 'Create a load balancer, and register the Amazon EC2 instance with it', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '240', '2', 'Create a CloudFront distribution, and configure the Amazon EC2 instance as the origin', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '240', '3', 'Create an Auto Scaling group from the instance using the CreateAutoScalingGroup action', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '240', '4', 'Create a launch configuration from the instance using the CreateLaunchConfiguration action', 'N', now(), now());

-- Q241
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '241', 'A Solutions Architect is designing an architecture for a mobile gaming application. The application is expected to be very popular. The Architect needs to prevent the Amazon ROS MySQL database from becoming a bottleneck due to frequently accessed queries. Which service or feature should the Architect add to prevent a bottleneck? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '241', '1', 'Multi-AZ feature on the RDS MySQL Database', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '241', '2', 'ELB Classic Load Balancer in front of the web application tier.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '241', '3', 'Amazon SQS in front of RDS MySQL Database', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '241', '4', 'Amazon ElastiCache in front of the RDS MySQL Database.', 'Y', now(), now());

-- Q242
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '242', 'Developers are creating a new online transaction processing (OLTP) application for a small database that is very read-write intensive. A single table in the database is updated continuously throughout the day, and the developers want to ensure that the database performance is consistent. Which Amazon EBS storage option will achieve the MOST consistent pertoimance to help maintain application performance? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '242', '1', 'Provisioned IOPS SSD', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '242', '2', 'General Purpose SSD', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '242', '3', 'Cold HDD', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '242', '4', 'Throughput Optimized HDD', 'N', now(), now());

-- Q243
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '243', 'Your organization is looking for a solution that can help the business with streaming data. Several services will require access to read and process the same stream concurrently. What AWS service meets the business requirements? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '243', '1', 'Amazon Kinesis Firehose', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '243', '2', 'Amazon CloudFront', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '243', '3', 'Amazon SQS', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '243', '4', 'Amazon Kinesis Streams', 'Y', now(), now());

-- Q244
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '244', 'If you want to setup a web server on EC2 with multiple Virtual Hosts Using distinct SSL certificates you need to: ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '244', '1', 'Use an S3 bucket with server side encryption', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '244', '2', 'Run your Apache EC2 instance in VPC', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '244', '3', 'Create one Amazon Elastic Load Balancer with SSL termination', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '244', '4', 'Upload your SSL server certification to Amazon identity and Access Management', 'N', now(), now());

-- Q245
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '245', 'Which of the following services natively encrypts data at rest within an AWS region? Choose 2 answers ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '245', '1', 'Amazon DynamoDB', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '245', '2', 'Amazon CloudFront', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '245', '3', 'Amazon Simple Queue Service', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '245', '4', 'Amazon Glacier', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '245', '5', 'AWS storage Gateway', 'N', now(), now());

-- Q246
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '246', 'Which of the following actions can Cloud Formation trigger when launching Amazon Linux EC2 instance? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '246', '1', 'Download and install software', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '246', '2', 'Attach the instance to an Elastic Map Reduce job flow', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '246', '3', 'Change the password for the root user', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '246', '4', 'Create custom files on the file system', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '246', '5', 'Change the EC2 instance metadata', 'N', now(), now());

-- Q247
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '247', 'A customer''s security team requires the logging of all network access attempts to Amazon EC2 instances in their production VPC on AWS.Which configuration will meet the security team''s requirement? ', '', '', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '247', '1', 'Enable CloudTrail for the production VP', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '247', '2', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '247', '3', 'Enable both CloudTrail and VPC Flow Logs for the AWS account.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '247', '4', 'Enable both CloudTrail and VPC Flow Logs for the production VP', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '247', '5', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '247', '6', 'Enable VPC Flow Logs for the production VP', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '247', '7', '', 'N', now(), now());

-- Q248
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '248', 'An organization regularly bocks up their application data. The application backups are required to be stored on Amazon S3 for a certain amount of time, and need to be accessed instantly in the event of a disaster recovery. Which of the following Amazon S3 storage classes would be the MOST cost-effective option to meet the needs of this scenario? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '248', '1', 'Glacier Storage Class', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '248', '2', 'Standard Storage Class', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '248', '3', 'Standard - Infrequent Access (IA)', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '248', '4', 'Reduced Redundancy Class (RRS)', 'N', now(), now());

-- Q249
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '249', 'Will my standby RDS instance be in the same Region as my primary? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '249', '1', 'No', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '249', '2', 'Only for Oracle RDS types', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '249', '3', 'Yes', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '249', '4', 'Only if configured at launch', 'N', now(), now());

-- Q250
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '250', 'A development team is building an application win front-end and backend application tiers. Each tier consists of Amazon EC2 instances behind on ELB Classic Load Balancer. The instances run in Auto Scaling groups across multiple Availability Zones. The network team has allocated the 10.0.0.0/24 address space for this application. Only the front-end load balancer should be exposed to the Internet. There are concerns about the limited size of the address space and the ability of each tier to scale. What should the VPC subnet design be in each Availability Zone? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '250', '1', 'One public subnet for the load balancer tier, one public subnet for the front-end tier, and one private subnet for the backend tier', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '250', '2', 'One shared public subnet for an tiers of the application', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '250', '3', 'One public subnet for the load balancer tier and one shared private subnet for the application tiers', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '250', '4', 'One shared private subnet for all tiers of the application', 'N', now(), now());

-- Q251
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '251', 'You have a load balancer configured for VPC, and all backend Amazon EC2 instances are in service. However, your web browser times out when connecting to the load balancer''s DNS name. Which options are probable causes of this behaviour? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '251', '1', 'The load balancer was not configured to use a public subnet with an Internet gateway configured', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '251', '2', 'The Amazon EC2 instances do not have a dynamically allocated private IP address', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '251', '3', 'The security groups or network ACLs are nor properly configured for web traffic', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '251', '4', 'The load balancer is not configured in a private subnet with a NAT instance', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '251', '5', 'The VPC does not have a VGW configured', 'N', now(), now());

-- Q252
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '252', 'Your customers located around the globe require low-latency access to private video files. Which configuration meets these requirements? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '252', '1', 'Use Amazon CloudFront with signed URLs', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '252', '2', 'Use Amazon EC2 with provisioned IOPS Amazon EBS volumes', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '252', '3', 'Use Amazon S3 with signed URLs', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '252', '4', 'Use Amazon S3 with access control lists', 'N', now(), now());

-- Q253
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '253', 'Your company has set up an application in eu-west1 with a disaster recovery site in eucentral-1. You want to be notified of any AWS API activity in regions other than these two. How can you monitor AWS API activity in other regions? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '253', '1', 'Create a CloudWatch alarm for CloudTrail events', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '253', '2', 'Create a CloudWatch alarm for SSH key usage', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '253', '3', 'Create a CloudWatch alarm for Trusted Advisor', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '253', '4', 'Create a CloudWatch alarm for VPC flow logs', 'N', now(), now());

-- Q254
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '254', 'After launching an instance that you intend to serve as NAT (Network Address Translation) device in a public subnet you modify your route tables to have the NAT device be the target of internet bound traffic of your private subnet. When you try and make an outbound connection to the internet from an instance in the private subnet, you are not successful. Which of the following steps could resolve the issue? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '254', '1', 'Disabling the Source/Destination check attribute on the NAT instance', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '254', '2', 'Attaching an Elastic IP address to the instance in the private subnet', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '254', '3', 'Attaching a second Elastic Network Interface(ENI) to the instance in the private subnet, and placing it in the public subnet', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '254', '4', 'Attaching a second Elastic Network Interface to the NAT instance, and placing it in the private subnet', 'N', now(), now());

-- Q255
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '255', 'The AWS CloudHSM service is integrated with which of the following service? Choose 2 answers ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '255', '1', 'Amazon Elastic Block Store', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '255', '2', 'Amazon Simple Storage Service', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '255', '3', 'Amazon redshift', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '255', '4', 'Amazon DynamoDB', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '255', '5', 'Amazon RDS (Oracle)', 'N', now(), now());

-- Q256
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '256', 'How can you secure data at rest on an EBS volume? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '256', '1', 'Create an IAM policy that restricts read and write access to the volume', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '256', '2', 'Use an encrypted file system on top of the EBS volume', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '256', '3', 'Write the data randomly instead of sequentially', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '256', '4', 'Encrypt the volume using the S3 server-side encryption service', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '256', '5', 'Attach the volume to an insurance using EC2 SSL interface', 'N', now(), now());

-- Q257
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '257', 'When you resize the Amazon RDS DB instance, Amazon RDS will perform the upgrade during the next maintenance window. If you want the upgrade to be performed now, rather than waiting for the maintenance window, specify the _____ option. ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '257', '1', 'ApplyImmediately', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '257', '2', 'ApplySoon', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '257', '3', 'ApplyThis', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '257', '4', 'ApplyNow', 'N', now(), now());

-- Q258
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '258', 'A customer is deploying a production portal application on AWS. The database tier has structured data. The company requires a solution that is easily manageable and highly availability. How can these requirements be met? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '258', '1', 'Deploy the database on multiple Amazon EC2 instances backed by Amazon EBS across multiple Availability Zones', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '258', '2', 'Use Amazon RDS with a multiple Availability Zone option', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '258', '3', 'Use RDS with a single Availability Zone option and schedule periodic database snapshots', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '258', '4', 'Use Amazon DynamoDB', 'Y', now(), now());

-- Q259
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '259', 'At t2.medium EC2 instance type must be launched with what type of amazon machine image (AMI)? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '259', '1', 'An instance store Hardware Virtual Machine AMI', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '259', '2', 'An instance store Paravirtual AMI', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '259', '3', 'An Amazon EBS-backed Hardware Virtual Machine AMI', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '259', '4', 'An Amazon EBS-backed paravirtual AMI', 'N', now(), now());

-- Q260
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '260', 'You have just created an Amazon Relational Database Service (RDS) PostgreSQL instances in Amazon VPC and are unable to connect. Which of the following may be causing connection issues to your Amazon RDS endpoint? Choose 3 answers ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '260', '1', 'Incorrect rules in VPC security groups', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '260', '2', 'Incorrect rules in DB security groups', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '260', '3', 'Amazon RDS endpoint port restrictions on the local firewall', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '260', '4', 'An incorrect configuration in the Options Group', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '260', '5', 'An incorrect Amazon RDS DB instance type', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '260', '6', 'The Amazon RDS instance is not yet in a running state', 'N', now(), now());

-- Q261
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '261', 'Your startup wants to implement an order fulfillment process for selling a personalized gadget that needs an average of 3-4 days to produce with some orders taking up to 6 months you expect 10 orders per day on your first day. 1000 orders per day after 6 months and 10,000 orders after 12 months. Orders coming in are checked for consistency men dispatched to your manufacturing plant for production quality control packaging shipment and payment processing If the product does not meet the quality standards at any stage of the process employees may force the process to repeat a step Customers are notified via email about order status and any critical issues with their orders such as payment failure. Your case architecture includes AWS Elastic Beanstalk for your website with an RDS MySQL instance for customer data and orders. How can you implement the order fulfillment process while making sure that the emails are delivered reliably? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '261', '1', 'Add a business process management application to your Elastic Beanstalk app servers and re-use the ROS database for tracking order status use one of the Elastic Beanstalk instances to send emailsto customers.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '261', '2', 'Use SWF with an Auto Scaling group of activity workers and a decider instance in another Auto Scaling group with min/max=1 Use the decider instance to send emails to customers.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '261', '3', 'Use an SQS queue to manage all process tasks Use an Auto Scaling group of EC2 Instances that poll the tasks and execute them. Use SES to send emails to customers.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '261', '4', 'Use SWF with an Auto Scaling group of activity workers and a decider instance in another Auto Scaling group with min/max=1 use SES to send emails to customers.', 'Y', now(), now());

-- Q262
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '262', 'A Solutions Architect is developing a new web application on AWS The Architect expects the application to become very popular, so the application must scale to support the load. The Architect wants to focus on software development and deploying new features without provisioning or managing instances. Which solution is appropriate? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '262', '1', 'Amazon API Gateway and AWS Lambda', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '262', '2', 'Elastic Load Balancing with Auto Scaling groups and Amazon EC2', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '262', '3', 'Amazon API Gateway and Amazon EC2', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '262', '4', 'Amazon CloudFront and AWS Lambda', 'N', now(), now());

-- Q263
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '263', 'You are working with a customer who has 10 TB of archival data that they want to migrate to Amazon glacier. The customer has a 1-Mbps connection to the internet. Which service or feature provides the fastest method of getting the data into Amazon glacier? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '263', '1', 'Amazon Glacier multipart upload', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '263', '2', 'AWS storage Gateway', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '263', '3', 'VM Import/Export', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '263', '4', 'AWS Import/Export', 'N', now(), now());

-- Q264
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '264', 'You are configuring your company''s application to use Auto Scaling and need to move user state information. Which of the following AWS services provides a shared data store with durability and low latency? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '264', '1', 'Amazon Simple Storage Service', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '264', '2', 'Amazon DynamoDB', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '264', '3', 'Amazon EC2 instance storage', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '264', '4', 'AWS ElasticCAche Memcached', 'N', now(), now());

-- Q265
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '265', 'What would happen to an RDS (Relational Database Service) multiAvailability Zone deployment if the primary DB instance fails? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '265', '1', 'The IP of the primary DB instance is switched to the standby DB instance', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '265', '2', 'A new DB instance is created in the standby availability zone', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '265', '3', 'The canonical name record (CNAME) is changed from primary to standby', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '265', '4', 'The RDS DB instance reboots', 'N', now(), now());

-- Q266
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '266', 'Your existing web application requires a persistent key-value store database that must service 50,000 reads/second. Your company is looking at 10% growth in traffic and data volume month over month for the next several years. Which service meets these requirements? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '266', '1', 'Amazon RDS', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '266', '2', 'Amazon DynamoDB', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '266', '3', 'Amazon SQS', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '266', '4', 'Amazon RedShift', 'N', now(), now());

-- Q267
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '267', 'Which of the following categories are available from Amazon elastic compute cloud instance metadata ? Choose two answers ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '267', '1', 'Instance ID', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '267', '2', 'Elastic Load Balancing health status', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '267', '3', 'Auto Scaling launch configuration', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '267', '4', 'Bucket device mapping', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '267', '5', 'Bucket ID', 'N', now(), now());

-- Q268
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '268', 'An AWS customer runs a public blogging website. The site users upload two million blog entries a month The average blog entry size is 200 KB. The access rate to blog entries drops to negligible 6 months after publication and users rarely access a blog entry 1 year after publication. Additionally, blog entries have a high update rate during the first 3 months following publication, this drops to no updates after 6 months. The customer wants to use CloudFront to improve his user''s load times. Which of the following recommendations would you make to the customer? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '268', '1', 'Create a CloudFronl distribution with Restrict Viewer Access Forward Query string set to true and minimum TTL of 0.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '268', '2', 'Create a CloudFront distribution with "US''Europe price class for US/Europe users and a different CloudFront distribution with All Edge Locations'' for the remaining users.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '268', '3', 'Create a CloudFront distribution with S3 access restricted only to the CloudFront identity and partition the blog entry''s location in S3 according to the month it was uploaded to be used with CloudFront behaviors.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '268', '4', 'Duplicate entries into two different buckets and create two separate CloudFront distributions where S3 access is restricted only to Cloud Front identity', 'N', now(), now());

-- Q269
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '269', 'After creating a new IAM user which of the following must be done before they can successfully make API calls? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '269', '1', 'Create a set of Access Keys for the user', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '269', '2', 'Enable Multi-Factor Authentication for the user', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '269', '3', 'Add a password to the user', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '269', '4', 'Assign a Password Policy to the user', 'N', now(), now());

-- Q270
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '270', 'A customer is running two Amazon EC2 instances, Server1 and server2, in different subnets of the same VPC. Server1 can ping Server2, but server2 cannot ping Server1. What could explain this behavior? Choose 2 answers ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '270', '1', 'There is no route from server2 to server 1 defined in the route table', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '270', '2', 'The ingress rules for Server1''s security group do not allow ICMP traffic', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '270', '3', 'The two servers are not located in the same Availability Zone', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '270', '4', 'The operating system firewall on server1 is blocking traffic from server 2', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '270', '5', 'The ingress rules for server2 security group do not allow ICMP traffic', 'N', now(), now());

-- Q271
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '271', 'A workload consists of downloading an image from an Amazon S3 bucket, processing the image, and moving to another Amazon S3 bucket. An Amazon EC2 instance runs a scheduled task every hour to perform the operation. How should a Solutions Architect redesign the process so that it is highly available? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '271', '1', 'Change the Amazon EC2 instance to compute optimized', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '271', '2', 'Launch a second Amazon EC2 instance to monitor the health of the first', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '271', '3', 'Trigger a Lambda function when a new object is uploaded', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '271', '4', 'Install copy the images to an attached Amazon EBS volume', 'N', now(), now());

-- Q272
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '272', 'A company hosts a two-tier application that consists of a publicly accessible web server that communicates with a private database. Only HTTPS port 443 traffic to the web server must be allowed from the internet. Which of the following options will achieve these requirements? (Select Two.) ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '272', '1', 'Security group rule that allows inbound internet traffic for port 443', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '272', '2', 'Security group rule that drives all inbound internet traffic expect port 443', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '272', '3', 'Network ACL rule that allows port 443 inbound and all ports outbound for internet traffic', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '272', '4', 'Security group rule that allows internet traffic for port 443 in both inbound and outbound', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '272', '5', 'Network ACL rule that allows port 443 for both inbound and outbound for all Internet traffic', 'N', now(), now());

-- Q273
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '273', 'A development team is building an application win front-end and backend application tiers. Each tier consists of Amazon EC2 instances behind on ELB Classic Load Balancer. The instances run in Auto Scaling groups across multiple Availability Zones. The network team has allocated the 10.0.0.0/24 address space for this application. Only the front-end load balancer should be exposed to the Internet. There are concerns about the limited size of the address space and the ability of each tier to scale. What should the VPC subnet design be in each Availability Zone? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '273', '1', 'One public subnet for the load balancer tier, one public subnet for the front-end tier, and one private subnet for the backend tier', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '273', '2', 'One shared public subnet for all tiers of the application', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '273', '3', 'One public subnet for the load balancer tier and one shared private subnet for the application tiers', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '273', '4', 'One shared private subnet for all tiers of the application', 'N', now(), now());

-- Q274
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '274', 'A customers needs to capture all client connection information from their load balancer every five minutes. The company wants to use data for analyzing traffic patterns and troubleshooting their applications. Which of the following options meets the customer requirements? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '274', '1', 'Enable access logs on the load balancer', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '274', '2', 'Enable AWS CloudTrail for the load balancer', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '274', '3', 'Enable Amazon CloudWatch metrics on the load balancer', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '274', '4', 'Install the Amaozn CloudWatch Logs agent on the load balancer', 'N', now(), now());

-- Q275
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '275', 'You bid $0.22 for an Amazon EC2 Spot Instance when the market price was $0.20. For 90 minutes, the market price remained at $0.20. Then the market price changed to $0.25, and your instance was terminated by AWS. What was your cost of running the instance for the entire duration? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '275', '1', '$0.47', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '275', '2', '$0.20', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '275', '3', '$0.22', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '275', '4', '$0.40', 'N', now(), now());

-- Q276
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '276', 'Within a VPC, you need to allow a wide range of ports, and block several non-contiguous ports within the range. Which option will allow you to do this ? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '276', '1', 'Using a network ACL, place a DENY rule for ports to be blocked ahead of the ALLOW rule for the wide range of ports', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '276', '2', 'Using a network ACL, place a DENY rule for ports to be blocked after the ALLOW rule for the wide range of ports', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '276', '3', 'Using a security group, place a DENY rule for ports to be blocked ahead of the ARROW rule for the wide range of ports', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '276', '4', 'Using a security group, place a DENY rule for ports to be blocked after the ALLOW rule for the wide range of ports', 'N', now(), now());

-- Q277
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '277', 'Which of the following approaches help improve the availability of an application on AWS?. Choose 2 answer ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '277', '1', 'Using multiple Availability zones', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '277', '2', 'Using placement groups', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '277', '3', 'Using Amazon virtual private cloud', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '277', '4', 'Using AutoScaling to replace lost capacity', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '277', '5', 'Using the largest available instance type', 'N', now(), now());

-- Q278
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '278', 'An organization runs an online voting system for a television program. During broadcasts, hundreds of thousands of votes are submitted within minutes and sent to a front-end feet of autoscaled Amazon EC2 instances. The EC2 instances push the votes to a RBDMS database. The database is unable to keep up with the front-end connection requests. What is the MOST efficient and cost-effective way of ensuring that votes are processes in a timely manner? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '278', '1', 'Each front-end node should send votes to an Amazon SQS queue. Provision worker instances to read the SQS queues and process the message information into the RBDMS database', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '278', '2', 'As the load on the database increases, horizontally-scale the RDBMS database with additional memory-optimized instances. When voting has ended, scale down the additional instances', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '278', '3', 'Re-provision the RDBMS database with larger, memory-optimized instances. When voting ends, re-provision the back-end database with similar instances', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '278', '4', 'Send votes from each front-end node to Amazon DynamoD', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '278', '5', 'Provision worker instances to process the votes in DynamoDB into the RDBMS database', 'N', now(), now());

-- Q279
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '279', 'When will you incur costs with an Elastic IP address (EIP)? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '279', '1', 'When an EIP is allocated.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '279', '2', 'When it is allocated and associated with a running instance.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '279', '3', 'When it is allocated and associated with a stopped instance.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '279', '4', 'Costs are incurred regardless of whether the EIP is associated with a running instance.', 'N', now(), now());

-- Q280
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '280', 'An on-premises workload consists of a single server with an Apache instance end a MySQL database. The Solutions Architect plans to migrate on-premises database to MySQL on Amazon RDS using multiple Availability Zones. What solution ensures that the remaining workload win be highly available? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '280', '1', 'Provision the workload in an Auto Scaling group, with a minimum of two servers Use an Amazon Route 53 DNS-weighted routing policy to direct traffic to healthy servers.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '280', '2', 'Provision the workload in an Auto Scaling group across Availability Zones, with a minimum of two Amazon 0C2 instances Use an Application Load Balancer in front of an Auto Scaling group', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '280', '3', 'Provision at least two EC2 instances across two separate regions Use an Application Load Balancer to direct traffic between the instances', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '280', '4', 'Provision the workload in an Auto Scaling group across Availability Zones, with a minimum of two servers Use a Route 53 DNS simple routing policy to direct traffic to healthy servers', 'N', now(), now());

-- Q281
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '281', 'Using only AWS services .you intend to automatically scale a fleet of stateless of stateless web servers based on CPU and network utilization metrics. Which of the following services are needed? Choose 2 answers', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '281', '1', 'Auto Scaling', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '281', '2', 'Amazon Simple Notification Service', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '281', '3', 'AWS Cloud Formation', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '281', '4', 'CloudWatch', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '281', '5', 'Amazon Simple Workflow Service', 'N', now(), now());

-- Q282
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '282', 'What is a placement group? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '282', '1', 'A collection of Auto Scaling groups in the same region', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '282', '2', 'A feature that enables EC2 instances to interact with each other via high bandwidth, low latency connections', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '282', '3', 'A collection of authorized CloudFront edge locations for a distribution', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '282', '4', 'A collection of Elastic Load Balancers in the same Region or Availability Zone', 'N', now(), now());

-- Q283
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '283', 'A company needs to deploy services to an AWS region which they not previously used. The company currently has an AWS identity and Access Management (IAM) role for their Amazon EC2 instances, which permits the instance to have access to Amazon DynamoDB. The company wants their EC2 instances in the new region to have the same privileges. How should the company achieve this? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '283', '1', 'Create a new IAM role and associated policies within the new region', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '283', '2', 'Assign the existing IAM role to the Amazon EC2 instances in the new region', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '283', '3', 'Copy the IAM role and associated policies to the new region and attach it to the instances', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '283', '4', 'Create the Amazon Machine Image of the instance and copy it to the desired region using the AMI Copy feature', 'N', now(), now());

-- Q284
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '284', 'A Solutions Architect has a two-tier blog application with a single Amazon EC2 instance web server and Amazon RDS MySQL Multi-AZ OB instances. The Architect is re-architecting the application for high availability by adding instances in a second Availability Zone. Which additional services will improve the availability of the application? (Select TWO ) ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '284', '1', 'Auto Scaling group', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '284', '2', 'AWS CloudTrail', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '284', '3', 'ELB Classic Load Balancer', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '284', '4', 'Amazon DynamoDB', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '284', '5', 'Amazon ElasitCache', 'N', now(), now());

-- Q285
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '285', 'An Organization has a long-running image processing application that runs on Spot Instances that will terminated when interrupted. A highly available workload must be designed to respond to Spot Instance interruption notices. The solution must include a two-minute warning when there is not enough capacity. How can these requirements be met?', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '285', '1', 'Use Amazon CloudWatch Events to invoke an AWS Lambda function that can launch On-Demand Instances', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '285', '2', 'Regularly store data from the application on Amazon DynamoD', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '285', '3', 'Increase the maximum number of instances in the AWS Auto Scaling group', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '285', '4', 'Manually place a bid for additional Spot Instances at a higher price in the same AWS Region and Availability Zone', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '285', '5', 'Ensure that the Amazon Machine Image associated with the application has the latest configurations for the launch configuration', 'N', now(), now());

-- Q286
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '286', 'Which of the following are use cases for Amazon DynamoDB? Choose 3 answers ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '286', '1', 'Storing BLOB data', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '286', '2', 'Managing web sessions', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '286', '3', 'Storing JSON documents', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '286', '4', 'Storing metadata for Amazon S3 objects', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '286', '5', 'Running relational joins and complex updates', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '286', '6', 'Storing large amounts of infrequently accessed data', 'N', now(), now());

-- Q287
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '287', 'A company needs to monitor the read and write IOPs metrics for their AWS MySQL RDS instances and send real-time alerts to their operations team. Which AWS services can accomplish this? Choose 2 answers ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '287', '1', 'Amazon Simple Email Service', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '287', '2', 'Amazon CloudWatch', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '287', '3', 'Amazon Simple Queue Service', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '287', '4', 'Amazon Route 53', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '287', '5', 'Amazon Simple Notification Service', 'N', now(), now());

-- Q288
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '288', 'You have an application running in multiple Availability Zones, to confirm this application can continue to operate at full capacity without performance degradation or downtime. In the event of an Availability Zone failure. You must: ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '288', '1', 'Use Spot instances to guarantee supplemental capacity', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '288', '2', 'Use Auto Scaling to launch instances in other Availability Zones to replace lost capacity', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '288', '3', 'Use dedicated instances in all Availability Zones', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '288', '4', 'Have enough running EC2 instances in other Availability Zones', 'N', now(), now());

-- Q289
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '289', 'A customer is leveraging Amazon simple storage service in eu-west-1 to store static content for a web-based property. The customer is storing objects using the standard storage class. Where are the customer''s objects replicated ? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '289', '1', 'A single facility in eu-west-1 and a single facility in eu-central-1', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '289', '2', 'A single facility in ru-west-1 and a single facility in us-east-1', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '289', '3', 'Multiple facilities in eu-west-1', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '289', '4', 'A single facility in eu-west-1', 'N', now(), now());

-- Q290
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '290', 'Which set of Amazon S3 features helps to prevent and recover from accidental data loss? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '290', '1', 'Object lifecycle and service access logging', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '290', '2', 'Object versioning and Multi-factor authentication', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '290', '3', 'Access controls and server-side encryption', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '290', '4', 'Website hosting and Amazon S3 policies', 'N', now(), now());

-- Q291
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '291', 'In AWS, which security aspects are the customer''s responsibility? Choose 4 answers ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '291', '1', 'Life-Cycle management of IAM credentials', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '291', '2', 'Security Group and ACL settings', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '291', '3', 'Controlling physical access to compute resources', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '291', '4', 'Path management on the EC2 instance''s operating system', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '291', '5', 'Encryption of EBS volumes', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '291', '6', 'Decommissioning storage devices', 'N', now(), now());

-- Q292
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '292', 'You are designing a multi-platform web application for AWS The application will run on EC2 instances and will be accessed from PCs. tablets and smart phones Supported accessing platforms are Windows. MACOS. IOS and Android Separate sticky session and SSL certificate setups are required for different platform types which of the following describes the most cost effective and performance efficient architecture setup? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '292', '1', 'Set up two ELBs The first ELB handles SSL certificates for all platforms and the second ELB handles session stickiness for all platforms for each ELB run separate EC2 instance groups to handle the web application for each platform.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '292', '2', 'Setup a hybrid architecture to handle session state and SSL certificates on-prem and separate EC2 Instance groups running web applications for different platform types running in a VP', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '292', '3', '', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '292', '4', 'Assign multiple ELBS to an EC2 instance or group of EC2 instances running the common components of the web application, one ELB for each platform type Session stickiness and SSL termination are done at the ELBs.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '292', '5', 'Set up one ELB for all platforms to distribute load among multiple instance under it Each EC2 instance implements ail functionality for a particular platform.', 'N', now(), now());

-- Q293
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '293', 'You have a content management system running on an Amazon EC2 instance that is approaching 100% CPU utilization. Which option will reduce load on the Amazon EC2 instance? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '293', '1', 'Create a new load balancer, and register the Amazon EC2 instqance with it', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '293', '2', 'Create a CloudFront distribution, and configure the Amazon EC2 instance as the origin', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '293', '3', 'Create an Auto Scaling group from the instance using the CreateAutoScalingGroup action', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '293', '4', 'Create a launch configuration from the instance using the CreateLaunchConfiguration action', 'N', now(), now());

-- Q294
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '294', 'To meet compliance standards, a company must have encrypted archival data storage. Data will be accessed infrequently, with lead times when in advance of when archived data must be recovered. The company requires that the storage be secure, durable and provided at the lowest price per 1TB of data stored. What type of stooge should be used? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '294', '1', 'Amazon S3', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '294', '2', 'Amazon EBS', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '294', '3', 'Amazon Glacier', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '294', '4', 'Amazon EPS', 'N', now(), now());

-- Q295
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '295', 'You have a web application running on six Amazon EC2 instances, consuming about 45% of resources on each instance. You are using autoscaling to make sure that six instances are running at all times. The number of requests this application processes is consistent and does not experience spikes. The application is critical to your business and you want high availability at all times. you want the load to be distributed evenly between all instances. you also want to use the same Amazon Machine image(AMI) for all instances .which of the following architectural choices should you make? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '295', '1', 'Deploy 2 EC2 instances in three regions and use Amazon Elastic Load Balancer', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '295', '2', 'Deploy 6 EC2 instances in one availability zone and use Amazon Elastic Load Balancer', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '295', '3', 'Deploy 3 EC2 instances in one availability zone and 3 in another availability zone and use Amazon Elastic Load Balancer', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '295', '4', 'Deploy 3 EC2 instances in one region and 3 in another region and use Amazon Elastic Load Balancer', 'N', now(), now());

-- Q296
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '296', 'A Solutions Architect is designing a highly-available website that is served by multiple web servers hosted outside of AWS. If an instance becomes unresponsive, the Architect needs to remove it from the rotation. What is the MOST efficient way to fulfill this requirement? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '296', '1', 'Use Amazon CloudWatch to monitor utilization.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '296', '2', 'Use Amazon API Gateway to monitor availably', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '296', '3', 'Use an Amazon Elastic Load Balancer', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '296', '4', 'Use Amazon Route 53 health checks', 'Y', now(), now());

-- Q297
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '297', 'You have an Amazon EC2 instance with data stored in an Amazon elastic block store (EBS) volume. You want to make the data available in another region. Which of the following methods should be used for making the data in the Amazon EBS volume available to the newly launched Amazon EC2 instance? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '297', '1', 'Detach the Amazon EBS volume and attach it to the newly launched Amazon EC2 instance', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '297', '2', 'Snapshot the Amazon EBS volume and copy it to the other region. Create a new Amazon EBSvolume from the snapshot, and attach it to the newly launched Amazon EC2 instance', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '297', '3', 'Copy the Amazon EBS volume to the other region, create a new Amazon EBS volume from that, and then attach it to newly launched Amazon EC2 instance', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '297', '4', 'Use AWS Import/Export to copy the Amazon EBS volume to the other region and attach it to newly launched instance', 'N', now(), now());

-- Q298
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '298', 'If you are using Amazon RDS Provisioned IOPS storage with MySQL and Oracle database engines, you can scale the throughput of your database Instance by specifying the IOPS rate from __________ . ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '298', '1', '10, 000 to 1, 00, 000', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '298', '2', '1,000 to 1, 00, 000', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '298', '3', '1, 000 to 10, 000', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '298', '4', '100 to 1, 000', 'N', now(), now());

-- Q299
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '299', 'An on-premises workload consists of a single server with an Apache instance end a MySQL database. The Solutions Architect plans to migrate on-premises database to MySQL on Amazon RDS using multiple Availability Zones. What solution ensures that the remaining workload win be highly available? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '299', '1', 'Provision the workload in an Auto Scaling group, with a minimum of two servers Use an Amazon Route 53 DNS-weighted routing policy to direct traffic to healthy servers.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '299', '2', 'Provision the workload in an Auto Scaling group across Availability Zones, with a minimum of two Amazon EC2 instances Use an Application Load Balancer in front of an Auto Scaling group', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '299', '3', 'Provision at least two EC2 instances across two separate regions Use an Application Load Balancer to direct traffic between the instances', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '299', '4', 'Provision the workload in an Auto Scaling group across Availability Zones, with a minimum of two servers Use a Route 53 DNS simple routing policy to direct traffic to healthy servers', 'N', now(), now());

-- Q300
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '300', 'Which of the following notification endpoints or clients are supported by Amazon Simple Notification Service? Choose 2 answers ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '300', '1', 'Email', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '300', '2', 'CloudFront distribution', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '300', '3', 'File Transfer Protocol', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '300', '4', 'Short Message Service', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '300', '5', 'Simple Network Management Protocol', 'N', now(), now());

-- Q301
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '301', 'You are running a mobile media application and are considering API Gateway for the client entry point. What benefits would this provide? Choose 2 answers ', '', '', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '301', '1', 'Caching API responses', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '301', '2', 'Intrusion prevention', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '301', '3', 'IP blacklisting', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '301', '4', 'Load balancing', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '301', '5', 'Throttling traffic', 'N', now(), now());

-- Q302
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '302', 'Your security team requires each Amazon ECS task to have an IAM policy that limits the task''s privileges to only those required for its use of AWS services. How can you achieve this? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '302', '1', 'Reboot each Amazon ECS task programmatically to generate new instance metadata for each task', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '302', '2', 'Connect to each running Amazon ECS container instance and add discrete credentials', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '302', '3', 'Use IAM roles on the Amazon ECS container instances to associate IAM roles with each ECS task on that instance', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '302', '4', 'Use IAM roles for Amazon ECS tasks to associate a specific IAM role with each ECS task definition', 'Y', now(), now());

-- Q303
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '303', 'When creation of an EBS snapshot is initiated, but not completed, the EBS volume: ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '303', '1', 'Cannot be detached or attached to an EC2 instance until the snapshot completes', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '303', '2', 'Can be used while the snapshots is in progress', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '303', '3', 'Cannot be used until the snapshot completes', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '303', '4', 'Can be used in read-only mode while the snapshot is in progress', 'N', now(), now());

-- Q304
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '304', 'A web-startup runs its very successful social news application on Amazon EC2 with an Elastic Load Balancer, an Auto-Scaling group of Java/Tomcat application-servers, and DynamoDB as data store. The main web-application best runs on m2 x large instances since it is highly memory- bound Each new deployment requires semi-automated creation and testing of a new AMI for the application servers which takes quite a while ana is therefore only done once per week. Recently, a new chat feature has been implemented in nodejs and wails to be integrated in the architecture. First tests show that the new component is CPU bound Because the company has some experience with using Chef, they decided to streamline the deployment process and use AWS Ops Works as an application life cycle tool to simplify management of the application and reduce the deployment cycles. What configuration in AWS Ops Works is necessary to integrate the new chat module in the most cost-efficient and flexible way? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '304', '1', 'Create two AWS Ops Works stacks create two AWS Ops Works layers create one custom recipe', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '304', '2', 'Create two AWS Ops Works stacks create two AWS Ops Works layers create two custom recipe', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '304', '3', 'Create one AWS Ops Works stack, create one AWS Ops Works layer, create one custom recipe', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '304', '4', 'Create one AWS Ops Works stack create two AWS Ops Works layers create one custom recipe', 'N', now(), now());

-- Q305
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '305', 'Which of the following features ensures even distribution of traffic to Amazon EC2 instances in multiples Availability Zones registered with a load balancer? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '305', '1', 'An Amazon Route 53 latency routing policy', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '305', '2', 'Elastic Load Balancing request routing', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '305', '3', 'An Amazon Route 53 weighted routing policy', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '305', '4', 'Elastic Load Balancing cross-zone load balancing', 'Y', now(), now());

-- Q306
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '306', 'You are designing a scalable web application with stateless web servers. Which service or feature is well suited to store user session information? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '306', '1', 'Amazon SQS', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '306', '2', 'Amazon EBS', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '306', '3', 'Amazon DynamoDB', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '306', '4', 'Amazon EC2 instance store', 'N', now(), now());

-- Q307
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '307', 'You are architecting a web application that will be backed by a relational database. Theapplication will be read-heavy, and database queries will be computationally intensive. How can you improve overall application response for users? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '307', '1', 'Use data Pipeline to replicate your relational data across all of your web tier nodes', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '307', '2', 'Use Amazon SQS to distribute messages among workers that are less busy', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '307', '3', 'Use ElastiCache to store critical pieces of data in memory for low-latency access', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '307', '4', 'Use an Auto Scaling group and ELB Classic Load Balancer for the application tier', 'N', now(), now());

-- Q308
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '308', 'You have a web portal composed of two services. Each service musts scale independently. Both services should be served under the same domain. Which configuration allows this? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '308', '1', 'Use one AWS Classic Load Balancer. Create a redirect in the web server based on users'' source IPs.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '308', '2', 'Use two AWS Application Load Balancer; one for each service. Assign the same CNAME to both.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '308', '3', 'Use one AWS Application Load Balancer. Specify listener rules to route requests to each service.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '308', '4', 'Use two AWS Classic Load Balancers; one for each service. Assign the same CNAME to both.', 'N', now(), now());

-- Q309
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '309', 'A company is deploying a new two-tier web application in AWS. The company has limited staff and requires high availability, and the application requires complex queries and table joins. Which configuration provides the solution for the company''s requirements? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '309', '1', 'MySQL Installed on two Amazon EC2 Instances in a single Availability Zone', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '309', '2', 'Amazon RDS for MySQL with Multi-AZ', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '309', '3', 'Amazon ElastiCache', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '309', '4', 'Amazon DynamoDB', 'N', now(), now());

-- Q310
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '310', 'A Solutions Architect is designing a mobile application that will capture receipt images to track expenses. The Architect wants to store the images on Amazon S3. However, uploading images through the web server will create too much traffic. What is the MOST efficient method to store images from a mobile application on Amazon S3? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '310', '1', 'Upload directly to S3 using a pre-signed URL', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '310', '2', 'Upload to a second bucket, and have a Lambda event copy the image to the primary bucket', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '310', '3', 'Upload to a separate Auto Scaling group of servers behind an ELB Classic Load Balancer, and have them write to the Amazon S3 bucket', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '310', '4', 'Expand the web server fleet with Spot Instances to provide the resources to handle the images', 'N', now(), now());

-- Q311
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '311', 'Your web application front end consists of multiple EC2 instances behind an Elastic Load Balancer. You configured ELB to perform health checks on these EC2 instances, if an instance fails to pass health checks, which statement will be true? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '311', '1', 'The instance gets terminated automatically by the EL', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '311', '2', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '311', '3', 'The instance gets quarantined by the ELB for root cause analysis.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '311', '4', 'The instance is replaced automatically by the EL', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '311', '5', 'The ELB stops sending traffic to the instance that failed its health check.', 'N', now(), now());

-- Q312
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '312', 'If you want to launch Amazon Elastic Compute Cloud (EC2) instances and assign each instance a predetermined private IP address, you should: ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '312', '1', 'Assign a group of sequential Elastic IP address to the instances', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '312', '2', 'Use standard EC2 instances since each instance gets a private Domain Name Service already', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '312', '3', 'Launch the instances in the Amazon Virtual Cloud (VPC)', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '312', '4', 'Launch the instances in a placement Group', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '312', '5', 'Launch the instances from a private Amazon Machine Image (AMI)', 'N', now(), now());

-- Q313
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '313', 'You need a solution to distribute traffic across all the containers for a task running on Amazon ECS. Your task definitions define dynamic host port mapping for your containers. What AWS feature provides this functionality? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '313', '1', 'CloudFront custom origins support dynamic host port mapping', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '313', '2', 'All Elastic Load Balancing instances support dynamic host port mapping', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '313', '3', 'Classic Load Balancers support dynamic host port mapping', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '313', '4', 'Application Load Balancers support dynamic host port mapping', 'Y', now(), now());

-- Q314
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '314', 'You have been asked to design a NAT solution for your company''s VPC-based web application. Traffic from the private subnets varies throughout the day from 500 Mbps to spikes of 7 Gbps. What is the most cost-effective and scalable solution? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '314', '1', 'Move the internet gateway for the VPC to a public subnet: route all internet traffic through the internet gateway', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '314', '2', 'Create an Amazon EC2 NAT instance with a second elastic network interface in a public subnet; route all private subnet internet traffic through the NAT gateway', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '314', '3', 'Create an Auto Scaling group of Amazon EC2 NAT instances in a public subnet; route all private subnet internet traffic through the NAT gateway', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '314', '4', 'Create a NAT gateway in a public subnet; route all private subnet internet traffic through the NAT gateway', 'Y', now(), now());

-- Q315
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '315', 'You have deployed a three-tier web application in a VPC with a CIOR block of 10 0 0 0/28 You initially deploy two web servers, two application servers, two database servers and one NAT instance tor a total of seven EC2 instances The web. Application and database servers are deployed across two availability zones (AZs). You also deploy an ELB in front of the two web servers, and use Route53 for DNS Web (raffle gradually increases in the first few days following the deployment, so you attempt to double the number of instances in each tier of the application to handle the new load unfortunately some of these new instances fail to launch. Which of the following could De the root caused? (Choose 2 answers) ', '', '', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '315', '1', 'The ELB has scaled-up. Adding more instances to handle the traffic reducing the number of available private IP addresses for new instance launches.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '315', '2', 'AWS reserves the first and the last private IP address in each subnet''s CIDR block so you do not have enough addresses left to launch all of the new EC2 instances.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '315', '3', 'The Internet Gateway (IGW) of your VPC has scaled-up adding more instances to handle the traffic spike, reducing the number of available private IP addresses for new instance launches.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '315', '4', 'AWS reserves the first tour and the last IP address in each subnet''s CIDR block so you do not have enough addresses left to launch all of the new EC2 instances.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '315', '5', 'AWS reserves one IP address In each subnet''s CIDR block for Route53 so you do not have enough addresses left to launch all of the new EC2 instances.', 'N', now(), now());

-- Q316
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '316', 'A customer is running a multi-tier web application farm in a virtual private cloud (VPC) that is not connected to their corporate network. They are connecting to the VPC. Which of the following bastion deployment scenarios will meet this requirement? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '316', '1', 'Deploy a Windows Bastion host on the corporate network that has RDP access to all intances in the VPC', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '316', '2', 'Deploy a Windows Bastion host with an Elastic IP address in the public subnet, and allow SSH access to the bastion from anywhere', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '316', '3', 'Deploy a Windows Bastion host with an Elastic IP address in the private subnet, and restrict RDP access to the bastion from only the corporate public IP addresses', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '316', '4', 'Deploy a Windows Bastion host with an auto-assigned Public subnet, and allow RDP access to the bastion from only the corporate public IP addresses', 'Y', now(), now());

-- Q317
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '317', 'A photo-sharing service stores pictures in Amazon Simple Storage Service (S3) and allows application sign-in using an OpenID Connect-compatible identity provider. Which AWS Security Token Service approach to temporary access should you use for the Amazon S3 operations? ', '', '', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '317', '1', 'SAML-based Identity Federation', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '317', '2', 'Cross-Account Access', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '317', '3', 'AWS Identity and Access Management roles', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '317', '4', 'Web Identity Federation', 'N', now(), now());

-- Q318
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '318', 'A Solution Architect is designing a solution with AWS Lambda where different environments require different database passwords. What should the Architect do to accomplish this in a secure and scalable way? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '318', '1', 'Create a Lambda function for each individual environment', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '318', '2', 'Use Amazon DynamoDB to store environment variables', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '318', '3', 'Use encrypted AWS Lambda environment variables', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '318', '4', 'Implement a dedicated Lambda function for distributing environment variables', 'N', now(), now());

-- Q319
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '319', 'A company has configured and peered two VPCs : VPC-1 and VPC-2. VPC-1 contains only private subnets, and VPC-2 contains only public subnets. The company uses a single AWS Direct Connect connection and private virtual interface to connect their on-premises network with VPC-1. Which two methods increase the fault tolerance of the connection to VPC-1? Choose 2 answers ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '319', '1', 'Establish a hardware VPN over the internet between VPC-2 and then the on-premises network', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '319', '2', 'Establish a hardware VPN over the internet between VPC-1 and then the on-premises network', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '319', '3', 'Establish a new AWS direct connect connection and private virtual interface in the same region as VPC-2', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '319', '4', 'Establish a new AWS direct connect connection and private virtual interface in a different AWS region than VPC-1', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '319', '5', 'Establish a new AWS direct connect connection and private virtual interface in the same AWS region as VPC-1', 'N', now(), now());

-- Q320
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '320', 'Your Amazon RDS MySQL DB instance runs on the largest available instance type. The DB instance runs at near capacity for CPU and network bandwidth. You expect traffic to increase and are looking for ways you can continue to scale your database. Which strategies allow you to continue to scale and take on more traffic? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '320', '1', 'Create a cross-region read replica of the master database; configure the app to send read-only calls to the replica', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '320', '2', 'Convert the DB instance to a m=Multi-AZ deployment; configure the app to send read-only calls to the standby', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '320', '3', 'Create additional database accounts in the DB instance; configure the app servers to make calls using different account credentials', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '320', '4', 'Create a read replica of the master database in another Availability Zone; configure the app to send read-only calls to the replica.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '320', '5', 'Create an Amazon Elasticache cluster; configure the app to retrieve frequently accessed data and queries from the cache.', 'N', now(), now());

-- Q321
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '321', 'How can an EBS volume that is currently attached to an EC2 instance be migrated from one Availability Zone to another? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '321', '1', 'Simply create a new volume in the other AZ and specify the original volume as the source', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '321', '2', 'Detach the volume and attach it to another EC2 instance in the other AZ', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '321', '3', 'Create a snapshot of the volume, and create a new volume from the snapshot in the other AZ', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '321', '4', 'Detach the volume, then use the ec2-migrate-volume command to move it to another AZ', 'N', now(), now());

-- Q322
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '322', 'SQL Server __________ store logins and passwords in the master database. ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '322', '1', 'does', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '322', '2', 'doesn''t', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '322', '3', 'can be configured to but by default does not', 'N', now(), now());

-- Q323
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '323', 'As part of securing an API layer but on Amazon API Gateway, a Solutions Architect has to authorize users who are currently authenticated by an existing identity provider. The users must be denied access for a period of one hour after three unsuccessful attempts. How can be Solutions Architect meet these requirements? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '323', '1', 'Use AWS IAM authorization and add least-privileged permissions to each respective IAM role', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '323', '2', 'Use an API Gateway custom authorizer to invoke an AWS Lambda function to validate each user''s identity', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '323', '3', 'Use Amazon Cognito user pools to provide built-in user management', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '323', '4', 'Use Amazon Cognito user pools to integrate with external identity providers', 'N', now(), now());

-- Q324
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '324', 'Your application provides data transmission services. Files containing data to be transformed are first uploaded to Amazon S3 and then transformed by a fleet of sport EC2 instances. Files submitted by your premium customers must be transformed with the highest Priority. How should you implement such a system? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '324', '1', 'Use two SQS queues. One for high priority messages, the other for default priority. Transformation instances first poll the high priority queue, if there is no message; they poll the default priority queue .', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '324', '2', 'Use Route latency based-routing to send high priority tasks to the closet transformation instances.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '324', '3', 'Use a DynamoDB table with an attribute defining the priority level. Transformation instances will scan the table for tasks, sorting results by priority level', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '324', '4', 'Use a single SQS queue. Each message contains the priority contains the priority level. Transformation instances poll high=priority messages first', 'N', now(), now());

-- Q325
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '325', 'When should I choose Provisioned IOPS over Standard RDS storage? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '325', '1', 'If you have workloads that are not sensitive to consistent performance', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '325', '2', 'If you use production online transaction processing (OLTP) workloads.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '325', '3', 'If you have batch-oriented workloads', 'N', now(), now());

-- Q326
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '326', 'Which of the following are characteristics of Amazon VPC subnets? Choose 2 answers ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '326', '1', 'Each subnet spans at least 2 Availability Zones to provide a high-availability environment.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '326', '2', 'Each subnet maps to a single Availability Zone.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '326', '3', 'CIDR block mask of/25 is the smallest range supported.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '326', '4', 'By default, all subnets can route between each other, whether they are private or public.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '326', '5', 'Instances in a private subnet can communicate with the Internet only if they have an Elastic IP.', 'N', now(), now());

-- Q327
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '327', 'After reviewing their logs, a startup company noticed larger, random spikes in traffic to their web application. The company wants to configure a cost-efficient Auto Scaling solution to support high availability ofthe web application. Which scaling plan should a Solution Architect recommend to meet the company''s needs? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '327', '1', 'Dynamic', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '327', '2', 'Scheduled', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '327', '3', 'Manual', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '327', '4', 'Lifecycle', 'N', now(), now());

-- Q328
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '328', 'The Trusted Advisor service provides insight regarding which four categories of an AWS account? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '328', '1', 'Security, fault tolerance, high availability, and connectivity', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '328', '2', 'Security, access control, high availability, and performance', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '328', '3', 'Performance, cost optimization, security, and fault tolerance', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '328', '4', 'Performance, cost optimization, access control, and connectivity', 'N', now(), now());

-- Q329
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '329', 'An internet-facing multi-tier web application must be highly available. An ELB Classic Load Balancer is deployed in front of the web tier. Amazon EC2 instances at the web application tier are deployed evenly across two Availably Zones. The database is deployed using RDS Multi-AZ. A NAT instance is launched for Amazon EC2 instances and database resources to access the Internet. These instances are not assigned with public IP addresses. Which component poses a potential single point of failure in this architecture? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '329', '1', 'Amazon EC2', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '329', '2', 'NAT instance', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '329', '3', 'ELB Classic Load Balancer', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '329', '4', 'Amazon RDS', 'N', now(), now());

-- Q330
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '330', 'A customer owns a simple API for their website that receives about 1,000 requests each day and has an average response time of 50 ms. It is currently hosted on one c4.large instance. Which changes to the architecture will provide high availably at the LOWEST cost? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '330', '1', 'Create an Auto Scaling group with a minimum of one instance and a maximum of two instances then use an Application Load Balancer to balance the traffic', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '330', '2', 'Recreate the API using Amazon API Gateway and use AWS Lambda as the service backend', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '330', '3', 'Create an Auto Scaling group with a minimum and a maximum of two instances, then use an Application Load Balancer to balance the traffic.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '330', '4', 'Recreate the API using Amazon API Gateway and integrate the new API with the existing backend service', 'N', now(), now());

-- Q331
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '331', 'A company runs a legacy application with a single-tier architecture on an Amazon EC2 Instance. Disk I/O is low, with occasional small spikes during business hours. The company requires the instance to be stopped from 8 PM to 8 AM daily. Which storage option is MOST appropriate for this workload?', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '331', '1', 'Amazon EC2 instance storage', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '331', '2', 'Amazon EBS General Purpose SSD (gp2) storage', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '331', '3', 'Amazon S3', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '331', '4', 'Amazon EBS Provision IOPS SSD (io1) storage', 'N', now(), now());

-- Q332
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '332', 'A Solutions Architect is designing a solution to monitor weather changes by the minute. The frontend application is hosted on Amazon EC2 instances. The backend must be scalable to a virtually unlimited size, and data retrieval must occur with minimal latency. Which AWS service should the Architect use to store the data and achieve these requirements? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '332', '1', 'Amazon S3', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '332', '2', 'Amazon DynamoDB', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '332', '3', 'Amazon RDS', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '332', '4', 'Amazon EBS', 'N', now(), now());

-- Q333
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '333', 'You have established a virtual private cloud (VPC) peering relationship between VPC 1 and VPC 2. VPC 1 has routes to VPC 2, yet hosts in VPC 1 cannot connect to hosts in VPC 2. Which of the following is a possible cause? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '333', '1', 'Security groups applied to VPC 2 are blocking the traffic', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '333', '2', 'The network access control list applied to VPC 2 denies by default', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '333', '3', 'The subnet route table in VPC 2 does not have routes to VPC 1', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '333', '4', 'The VPCs have not been attached to a virtual private gateway', 'N', now(), now());

-- Q334
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '334', 'An online company wants to conduct real-time sentiment analysis about its products from its social media channels using SQL. Which of the following solutions has the LOWEST cost and operational burden? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '334', '1', 'Set up a streaming data ingestion application on Amazon EC2 and connect it to a Hadoop cluster for data processing. Send the output to Amazon S3 and use Amazon Athena to analyze the data.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '334', '2', 'Configure the input stream using Amazon Kinesis Data Streams Use Amazon Kinesis Data Analytics to write SQL queries against the stream.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '334', '3', 'Configure the input stream using Amazon Kinesis Data Streams. Use Amazon Kinesis Data Firehose to send data to an Amazon Redshift cluster, and then query directly against Amazon Redshift.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '334', '4', 'Set up a streaming data ingestion application on Amazon EC2 and send the output to Amazon S3 using Kinesis Data Firehose. Use Athena to analyze the data', 'N', now(), now());

-- Q335
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '335', 'You are configuring your company''s application to use Auto Scaling and need to move user state information. Which of the following AWS services provides a shared data store with durability and low latency? ', '', '', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '335', '1', 'Amazon DynamoDB', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '335', '2', 'Amazon Simple Storage Service', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '335', '3', 'AWS ElastiCache Memcached', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '335', '4', 'Amazon EC2 instance storage', 'N', now(), now());

-- Q336
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '336', 'A Solutions Architect needs to design an Amazon EC2 duster to analyze data that is currently stored in Amazon S3. A key requirement is to utilize the fastest storage service available when analyzing the data locally on the Amazon EC2 instance. Which of the following storage types should the Architect choose to meet the requirement? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '336', '1', 'AWS Storage Gateway', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '336', '2', 'Amazon EBS using Provisioned IOPS (PIOPS)', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '336', '3', 'Amazon EC2 instance (ephemeral) Store', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '336', '4', 'Amazon Glacier', 'N', now(), now());

-- Q337
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '337', 'Your company wants to start working with AWS, but has not yet opened an account. With which of the following services should you begin local development? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '337', '1', 'Amazon DynamoDB', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '337', '2', 'Amazon Simple Queue Service', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '337', '3', 'Amazon Simple Email Service', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '337', '4', 'Amazon CloudSearch', 'N', now(), now());

-- Q338
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '338', 'An organization must process a stream erf large-volume hashtag data in real time and needs to run custom SQL queries on the data to gel insights on certain lags. The organization needs this solution to be elastic and does not want to manage clusters. Which of the following AWS services meets these requirements? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '338', '1', 'Amazon Elasticsearch Service', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '338', '2', 'Amazon Athena', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '338', '3', 'Amazon Redshift', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '338', '4', 'Amazon Kinesis Data Analytics', 'Y', now(), now());

-- Q339
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '339', 'A Solutions Architect is designing a solution that retains traffic information between network interfaces. The traffic information will then be monitored for anomalies by an InfoSec team using Amazon CloudWatch. What approach should the Architect take? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '339', '1', 'Save all inbound requests to Amazon DynamoDB', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '339', '2', 'Maintain traffic history on each Amazon EC2 instance', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '339', '3', 'Enable Amazon VPC Flow Logs', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '339', '4', 'Save all inbound requests to Amazon S3', 'N', now(), now());

-- Q340
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '340', 'You are deploying an application to track GPS coordinates of delivery trucks in the United States. Coordinates are transmitted from each delivery truck once every three seconds. You need to design an architecture that will enable real-time processing of these coordinates from multiple consumers. Which service should you use to implement data ingestion? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '340', '1', 'Amazon Kinesis', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '340', '2', 'Amazon Simple Queue Service', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '340', '3', 'Amazon AppStream', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '340', '4', 'AWS Data Pipeline', 'N', now(), now());

-- Q341
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '341', 'A Solutions Architect was tasked with reviewing several templates that build VPCs and ensuring that they meet specific security requirements. After reviewing the templates, the Architect realizes that all of the templates are missing important security best practices. What should the Architect do to implement security best practices in an efficient manner? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '341', '1', 'Use VPC peering to enforce network consistency', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '341', '2', 'Restrict users from deploying an AWS CloudFormation template.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '341', '3', 'Provide the teams a nested AWS CloudFormation template that builds the VPC correctly.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '341', '4', 'Create AWS identity and Access Management (IAM) policies that enforce the corporate VPC architecture standards', 'Y', now(), now());

-- Q342
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '342', 'What are characteristics Os Amazon S3? Choose 2 answers ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '342', '1', 'S3 allows you to store unlimited amounts of data', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '342', '2', 'S3 offers Provisioned IOPS', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '342', '3', 'S3 allows you to store objects of virtually unlimited size', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '342', '4', 'S3 should be used to host a relational database', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '342', '5', 'Objects are directly accessible via a URL', 'N', now(), now());

-- Q343
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '343', 'You have a web application running on six Amazon EC2 instances, consuming about 45% of resources on each instance. You are using auto-scaling to make sure that six instances are running at all times. The number of requests this. Which of the following architectural choices should you make ? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '343', '1', 'Deploy 3 EC2 instances in one availability zone and 3 in another availability zone and use Amazon Elastic Load Balancer', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '343', '2', 'Deploy 3 EC2 instances In one region and 3 other region and use Amazon Elastic Load Balancer', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '343', '3', 'Deploy 2 EC2 instances in three regions and use Amazon Elastic Load Balancer', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '343', '4', 'Deploy 6 EC2 instances in one availability zone and use Amazon Elastic Load Balancer', 'N', now(), now());

-- Q344
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '344', 'A photo-sharing service stores pictures in Amazon Simple Storage Service (S3) and allows application sign-in using an opened connect-compatible identity provider. Which AWS Security Token Service approach to temporary access should you use for the Amazon S3 operations?', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '344', '1', 'Cross-Account Access', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '344', '2', 'AWS identity and Access Management roles', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '344', '3', 'SAML-based Identity Federation', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '344', '4', 'Web identity Federation', 'N', now(), now());

-- Q345
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '345', 'A solution architect is designing an application that will encrypt all data in an Amazon Redshift cluster. Which action will encrypt the data? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '345', '1', 'Place the Redshift KMS Default Cluster in a private subnet', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '345', '2', 'Use the AWS KMS Default Customer master key', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '345', '3', 'Encrypt the Amazon EBS volumes', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '345', '4', 'Encrypt the data using SSL/TLS', 'N', now(), now());

-- Q346
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '346', 'You are tasked with migrating a high throughput, distributed, fault-tolerent NoSQL data store to AWS. The system is extremely disk-IO intensive. Which instance family is best suited for this workload? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '346', '1', 'I2', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '346', '2', 'T2', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '346', '3', 'HS!', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '346', '4', 'R3', 'N', now(), now());

-- Q347
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '347', 'A Solutions Architect is designing a microservices-based application using Amazon ECS. The application includes a WebSocket component, and the traffic needs to be distributed between microservices based on the URL. Which service should the Architect choose to distribute me workload? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '347', '1', 'ELB Classic Load Balancer', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '347', '2', 'Amazon Route 53 DNS', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '347', '3', 'ELB Application Load Balancer', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '347', '4', 'Amazon CloudFront', 'N', now(), now());

-- Q348
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '348', 'A company''s website receives 50.000 requests each second, and the company wants 10 use multiple applications to analyze the navigation patterns of the users on their website so that the experience can Be personalized. What can a Solutions Architect use to collect page clicks for the website and process them sequentially for each user? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '348', '1', 'Amazon Kinesis Stream', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '348', '2', 'Amazon SOS standard queue', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '348', '3', 'Amazon SOS FIFO queue', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '348', '4', 'AWS CloudTrail trail', 'N', now(), now());

-- Q349
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '349', 'A data analytics startup company asks a Solutions Architect to recommend an AWS data store option for indexed data. The data processing engine will generate and input more than 64 TB of processed data every day. with item sizes reaching up to 300 KB The startup is flexible with data storage models and is more interested in a database that requires minimal effort to scale with a growing dataset size. Which AWS data store service should the Architect recommend? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '349', '1', 'Amazon RDS', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '349', '2', 'Amazon Redshift', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '349', '3', 'Amazon DynamoDB', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '349', '4', 'Amazon S3', 'N', now(), now());

-- Q350
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '350', 'Your company runs an application that generates several thousand 1-GB reports a month. Approximately 10% of these reports will be accessed once during the first 30 days and must be Available on demand. After 30 days, reports are no longer accessed as a part of normal business processes but must be retained for compliance reasons. Which architecture would meet these requirements with the lowest cost? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '350', '1', 'Upload the reports to Amazon S3 Standard storage class. Set a lifecycle configuration on the bucket to transition the reports to Amazon Glacier after 30 days', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '350', '2', 'Upload the report s to Amazon S3 standard- infrequent Access storage class. Set a lifecycle configuration on the bucket to transition the reports to Amazon Glacier after 30 days', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '350', '3', 'Upload the reports to Amazon Glacier. When reports are requests, copy them to Amazon S3 standard storage class for access. Delete the copied reports after they have been viewed', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '350', '4', 'Upload the reports to Amazon S3 standard- infrequent access storage class. When reports are requests, copy them to Amazon S3 standard storage class for access. Delete the copied reports after they have been viewed.', 'N', now(), now());

-- Q351
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '351', 'A Solutions Architect is designing the storage layer for a production relational database. The database will run on Amazon EC2. The database is accessed by an application that performs intensive reads and writes, so the database requires the LOWEST random I/O latency. Which data storage method fulfills the above requirements? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '351', '1', 'Store data m a filesystem backed by Amazon Elastic File System (EFS)', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '351', '2', 'Store data in Amazon S3 and use a third-party solution to expose Amazon S3 as a filesystem to the database server', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '351', '3', 'Store data in Amazon DynamoDB and emulate relational database semantics', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '351', '4', 'Stripe data across multiple Amazon EBS volumes using RAID 0', 'Y', now(), now());

-- Q352
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '352', 'After launching an instance that you intend to serve as a NAT (Network Address Translation) device in a public subnet you modify your route tables to have the NAT device be the target of internet bound traffic of your private subnet. When you try and make an outbound connection to the internet from an instance in the private subnet, you are not successful. Which of the following steps could resolve the issue?', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '352', '1', 'Attaching a second Elastic network interface to the instance in the private subnet, and placing it in the public subnet', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '352', '2', 'Attaching an Elastic IP address to the instance in the private subnet', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '352', '3', 'Disabling the Source/Destination check attribute on the NAT instance', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '352', '4', 'Attaching a second Elastic Network interface to the NAT instance, and placing it in the private subnet', 'N', now(), now());

-- Q353
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '353', 'A company is launching a static website using the zone apex (mycompany.com). The company wants to use Amazon Route 53 for DNS. Which steps should the company perform to implement a scalable and cost-effective solution? (Select TWO) ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '353', '1', 'Host the website on an Amazon EC2 instance with ELB and Auto Scaling, and map a Route S3 abas record to the ELB endpoint', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '353', '2', 'Host the website using AWS Elastic Beanstalk, and map a Route 53 alias record to the Beanstalk stack.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '353', '3', 'Host the website on an Amazon EC2 instance, and map a Route 53 alias record to the public IP address of the Amazon EC2 instance.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '353', '4', 'Serve the website from an Amazon S3 bucket and map a Route 53 alias record to the website endpoint', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '353', '5', 'Create a Route 53 hosted zone, and set the NS records of the domain to use Route 53 name servers.', 'N', now(), now());

-- Q354
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '354', 'IAM provides several policy templates you can use to automatically assign permissions to the groups you create. The _____ policy template gives the Admins group permission to access all account resources, except your AWS account information ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '354', '1', 'Administrator Access', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '354', '2', 'AWS Cloud Formation Read Only Access', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '354', '3', 'Power User Access', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '354', '4', 'Read Only Access', 'N', now(), now());

-- Q355
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '355', 'How can you secure data at rest on an EBS volume? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '355', '1', 'Attach the volume to an instance using EC2''s SSL interface.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '355', '2', 'Write the data randomly instead of sequentially.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '355', '3', 'Encrypt the volume using the S3 server-side encryption service.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '355', '4', 'Create an IAM policy that restricts read and write access to the volume.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '355', '5', 'Use an encrypted file system on top of the EBS volume.', 'Y', now(), now());

-- Q356
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '356', 'A Solutions Architect notices slower response times from an application. The CloudWatch metrics on the MySQL RDS indicate Read IOPS are high and fluctuate significantly when the database is under load. How should the database environment be re-designed to resolve the IOPS fluctuation?', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '356', '1', 'Change the RDS instance type to get more RAM.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '356', '2', 'Change the storage type to Provisioned IOPS.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '356', '3', 'Scale the web server tier horizontally.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '356', '4', 'Split the DB layer into separate RDS instances', 'N', now(), now());

-- Q357
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '357', 'A customer is running a multi-tier web application farm in a virtual private cloud (VPC) that is not connected to their corporate network. They are connecting to the VPC over the Internet to manage all of their Amazon EC2 instances running in both the public and private subnets. They have only authorized the bastion-security-group with Microsoft Remote Desktop Protocol (RDP) access to the application instance security groups, but the company wants to further limit administrative access to all of the instances in the VPC. Which of the following Bastion deployment scenarios will meet this requirement? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '357', '1', 'Deploy a Windows Bastion host on the corporate network that has RDP access to all instances in the VP', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '357', '2', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '357', '3', 'Deploy a Windows Bastion host with an Elastic IP address in the public subnet and allow SSH access to the bastion from anywhere.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '357', '4', 'Deploy a Windows Bastion host with an Elastic IP address in the private subnet, and restrict RDP access to the bastion from only the corporate public IP addresses.', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '357', '5', 'Deploy a Windows Bastion host with an auto-assigned Public IP address in the public subnet, and allow RDP access to the bastion from only the corporate public IP addresses.', 'N', now(), now());

-- Q358
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '358', 'A Solutions Architect needs to use AWS to implement pilot light disaster recovery for a three- tier web application hosted in an on-premises datacenter. Which solution allows rapid provision of a working, fully-scaled production environment? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '358', '1', 'Continuously replicate the production database server to Amazon RDS Use AWS CloudFormation to deploy the application and any additional servers if necessary', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '358', '2', 'Continuously replicate the production database server to Amazon RDS Create one application load balancer and register on-premises servers Configure ELB Application Load Balancer to automatically deploy Amazon EC2 instances for application and additional servers if the on- premises application is down.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '358', '3', 'Use a scheduled Lambda function to replicate the production database to AWS Use Amazon Route 53 health checks to deploy the application automatically to Amazon S3 if production is unhealthy', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '358', '4', 'Use a scheduled Lambda function to replicate the production database to AWS Register onpremises servers to an Auto Scaling group and deploy the application and additional servers if production is unavailable.', 'N', now(), now());

-- Q359
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '359', 'Using Amazon CloudWatch''s Free Tier, what is the frequency of metric updates which you receive? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '359', '1', '1 minute', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '359', '2', '500 milliseconds.', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '359', '3', '5 minutes', 'Y', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '359', '4', '30 seconds', 'N', now(), now());

-- Q360
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '360', 'You have a load balancer configured for VPC, and all back-end Amazon EC2 instances are in service. However, your web browser times out when connecting to the load balancer''s DNS name. Which options are probable causes of this behavior? Choose 2 answers ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '360', '1', 'The load balancer was not configured to use a public subnet with an Internet gateway configured', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '360', '2', 'The security groups or network ACLs are not properly configured for web traffic', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '360', '3', 'The VPC does not have a VGW configured', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '360', '4', 'The Amazon EC2 instances do not have a dynamically allocated private IP address', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '360', '5', 'The load balancer is not configured in a private subnet with a NAT instance', 'N', now(), now());

-- Q361
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '361', 'Is the encryption of connections between my application and my DB Instance using SSL for the MySQL server engines available? ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '361', '1', 'Only in VPC', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '361', '2', 'Only in certain regions', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '361', '3', 'No', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '361', '4', 'Yes', 'Y', now(), now());

-- Q362
insert into question (test_id, ver_nbr, quest_nbr, quest_txt, explanation, reference, multi_answer_yn, created_date, modified_date) values ('143', '214', '362', 'Which of the following are true regarding encrypted amazon elastic block store (EBS) volumes? Choose 2 answers ', '', '', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '362', '1', 'Available to all instance types', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '362', '2', 'Existing volumes can be encrypted', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '362', '3', 'Supported on all Amazon EBS volume types', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '362', '4', 'Snapshots are automatically encrypted', 'N', now(), now());
insert into example (test_id, ver_nbr, quest_nbr, exmp_nbr, exmp_txt, answer_yn, created_date, modified_date) values ('143', '214', '362', '5', 'Shared volumes can be encrypted', 'N', now(), now());
