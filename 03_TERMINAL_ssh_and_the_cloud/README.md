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
