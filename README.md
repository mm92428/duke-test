# Ruby on Rails API

## Setup

After cloning this repository to your local machine, you'll need to build and run a container or setup a local Ruby environment.

### Container
If you are not running Linux, we recommend using [Rancher Desktop](https://rancherdesktop.io) as a container manager (though Docker Desktop and others will likely also work).

During install select `dockerd (moby)` container runtime. 

Examples of commands you may use are listed at the top of the docker-compose.yml file.

The container will mount the entire repository, so you can make changes to the files on your (host) machine and they will be immediately reflected in the container to allow easy development. However If you make changes to the application config, or add additional files, you may need to restart the container.

### Local Environment

If the container method isn't working out, or you're more comfortable working directly on your machine, you can setup a local Ruby environment on your machine. The best way to get one is to first install the [Ruby Version Manager (rvm)](https://rvm.io/rvm/install). This will allow you to run Ruby 3 and not interfere with the system Ruby that is required by some operating systems.

After it is installed, run `rvm install 3.3.1`. Then, you need to run `rvm use 3.3.1`.

---
## Assignment
### This assignment consists of two parts, rails API and SQL

### Installation

1. Complete setup (above)

1. Install gems in Gemfile

1. Launch the application

1. Run rspec


### Running tests

We use RSpec for our automated tests. You must write tests for your code
according to the following standard:

- spec/models: specifications for any models that you create
- **BONUS** spec/requests: specifications for all requests against the application
- **BONUS** avoid hard-coding test artifacts such as created objects, request
  parameters, etc.

### Problems to be solved

As you work through these problems, please **commit your code early and often**.
A good rule of thumb is to make small commits grouped by specific functionality.

#### Problem 1 REST backend

You have been provided assignment.apib, and assignment.html (a human readable version).
Using the existing Rails api application framework, implement the requirements specified in assignment.apib.

---

### SQL

Please edit this README.md file and provide your answers below.  The datatypes are Oracle, but feel free to use any variant of SQL.

1.  Below is a table containing information about protocols within the Duke Institutional Review Board (IRB) Application.
	Write a query that selects distinct studies currently approved by the IRB that might be trauma-related (based on title).
	
		TABLE protocols
			Protocol_ID VARCHAR2
			Full_Title VARCHAR2
			Short Title VARCHAR2
			CRU VARCHAR2
			Department VARCHAR2
			Status VARCHAR2

	**Answer:**

		SELECT DISTINCT
			Protocol_ID,
			Full_Title,
			Short_Title,
			CRU,
			Department,
			Status
		FROM protocols
		WHERE Status = 'Approved'
		AND (Full_Title LIKE '%trauma%' OR Short_Title LIKE '%trauma%');
			
2.	Below are tables containing information about protocol dates from the IRB and Clinical Research Management System (CRMS).  Write a query that selects distinct studies currently approved or closed that provides the following dates – Date Created, IRB Reviewed Date, IRB Approval Date – including number of days between each date. Also provide the earliest date a subject enrolled on the study. Also include PI, CRU, Department

		TABLE protocols
		  Protocol_ID VARCHAR2
		  Full_Title VARCHAR2
		  Short_Title VARCHAR2
		  Created_On DATE
		  IRB_Reviewed_On DATE
		  IRB_Approval_Date DATE
		  PI_First_Name VARCHAR2
		  PI_Last_Name VARCHAR2
		  CRU VARCHAR2
		  Department VARCHAR2
		  Status VARCHAR2

		TABLE Enrollment
		  Protocol_ID VARCHAR2
		  Subject_MRN VARCHAR2
		  Enrolled_On  DATE

	**Answer:**

		SELECT DISTINCT
		p.Protocol_ID,
		p.Full_Title,
		p.Short_Title,
		p.Created_On,
		p.IRB_Reviewed_On,
		p.IRB_Approval_Date,
		p.PI_First_Name,
		p.PI_Last_Name,
		p.CRU,
		p.Department,
		p.Status,
		MIN(e.Enrolled_On) AS Earliest_Enrollment_Date,
		(p.IRB_Reviewed_On - p.Created_On) AS Days_To_IRB_Reviewed,
		(p.IRB_Approval_Date - p.IRB_Reviewed_On) AS Days_To_IRB_Approval
	FROM protocols p
	LEFT JOIN Enrollment e ON p.Protocol_ID = e.Protocol_ID
	WHERE p.Status IN ('Approved', 'Closed')
	GROUP BY
		p.Protocol_ID,
		p.Full_Title,
		p.Short_Title,
		p.Created_On,
		p.IRB_Reviewed_On,
		p.IRB_Approval_Date,
		p.PI_First_Name,
		p.PI_Last_Name,
		p.CRU,
		p.Department,
		p.Status
	ORDER BY p.Protocol_ID;
