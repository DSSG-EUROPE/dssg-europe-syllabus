# SSH and the Cloud
Cloud computing is a computing paradigm popularised by Amazon, which enables access over the internet to shared pools of configurable system resources and higher-level services that can be rapidly provisioned with minimal management effort. Cloud computing relies on sharing of resources to achieve coherence and economies of scale. 

Each of you has been assigned an individual account that gives you access to Amazon Web Services (AWS), try logging into the portal:

**AWS portal:** [login link](https://dssg-europe.signin.aws.amazon.com/console) <br/>
**Username:** _firstinitial + lastname_ (e.g. Alice Smith becomes asmith) <br/>
**Password:** &ast;&ast;&ast;&ast;&ast;&ast;&ast; (you will be asked to change the password upon the first login) <br/>

![screenshot aws](images/screenshot1.png)

AWS is one of the most popular cloud based computing services, along with Microsoft's Azure, and IBM Bluemix. These services offer multiple services and their capabilities are being extended all the time. For your projects the most important things to be aware of are:

* **Amazon Elastic Compute Cloud (EC2)** - these so called EC2 instances allow users to rent virtual computers on which to run their applications. EC2 encourages scalable deployment of applications. A user can create, launch, and terminate server-instances as needed, paying by the second for active servers – hence the term "elastic". EC2 provides users with control over the geographical location of instances that allows for latency optimisation and high levels of redundancy.
* **Amazon Elastic Block Store (EBS)** - acts like a virtual hard drive and can be used with EC2 instances in the AWS cloud. When you require more storage or storage that persists beyond the life of the EC2 instance, the EBS can be utilised. The data is separate from your computing instance and persists independently so that if a computing instance fails, you will not lose data as it is located on the block storage volume. There are three volume types offered through EBS: general purpose (SSD), provisioned IOPS (SSD) for intensive I/O, and magnetic for rarely accessed data.
* **Amazon Simple Storage Service (S3)** - a highly scalable object storage that is suited to both small and large repositories of objects. The low cost service can be utilised for online backup and archiving of data and application programs and for content distribution as well as for big data analytics and disaster recovery. Storage is available in the form of any file or object and supports downloading, uploading and storage from across the web.
* **Amazon Relational Database Service (RDS)** - is a distributed relational database service designed to simplify the setup, operation, and scaling of a relational database for use in applications.

Typically a team will be given a shared EC2 instance to use for development with an associated EBS, data from project partners will be dumped into an S3 bucket. Usually this will be loaded into an RDS to improve query performance and create a single shared data repository, with a backup of the raw data in the S3 bucket. Using these tools along with Git allows for greater collaboration, computing scalability, and security. 

# Secure Shell (SSH) 
SSH can be used to access cloud services on AWS providing a secure channel over an unsecured network in a client-server architecture. This allows you to connect from your laptop to an EC2 instance and write and execute code remotely.

## Note on SSH key management
On Unix-like systems, the list of authorized public keys is typically stored in the home directory of the user that is allowed to log in remotely, in the file `~/.ssh/authorized_keys`. This file is respected by SSH only if it is not writable by anything apart from the owner and root (`chmod 600`). When the public key is present on the remote end and the matching private key is present on the local end, typing in the password is no longer required. However, for additional security the private key itself can be locked with a passphrase.

The private key can also be looked for in standard places, and its full path can be specified as a command line setting (the option -i for ssh). The ssh-keygen utility produces the public and private keys, always in pairs.

SSH also supports password-based authentication that is encrypted by automatically generated keys. In this case, the attacker could imitate the legitimate server side, ask for the password, and obtain it (man-in-the-middle attack). However, this is possible only if the two sides have never authenticated before, as SSH remembers the key that the server side previously used. The SSH client raises a warning before accepting the key of a new, previously unknown server. Password authentication can be disabled.

## Exercise

1. Login to the AWS EC2 training instance:

`ssh -i /path/key.pem username@training.dssg.io`

2. Move to your training data folder:
`cd /mnt/data/username`

