# Multi-Tier Java Application using Vagrant

[![Vagrant](https://img.shields.io/badge/Vagrant-2.2+-blue.svg)](https://www.vagrantup.com/)
[![Java](https://img.shields.io/badge/Java-8-orange.svg)](https://www.java.com/)
[![Status](https://img.shields.io/badge/Status-Operational-brightgreen.svg)]()

This repository contains an automated local development environment for the **vProfile** application. It uses **Vagrant** to orchestrate multiple Virtual Machines to create a full-stack, high-availability infrastructure.

<img width="1318" height="785" alt="architecture" src="https://github.com/user-attachments/assets/9bb56880-0f53-4052-a915-f6d5648bebe1" />

<img width="1137" height="543" alt="vprofile_web_arc" src="https://github.com/user-attachments/assets/115bd702-0c63-41b7-9b20-6845b8e30309" />

## 🏗️ Architecture
The infrastructure is distributed across 6 specialized VMs to simulate a real-world production environment:

* **Nginx (web01):** High-performance Load Balancer with `ip_hash` session affinity.
* **Tomcat (app01, app02):** Clustered Application Servers running Java/Spring.
* **Memcached (mc01):** Distributed Session Management for seamless failover.
* **RabbitMQ (rmq01):** Reliable Message Broker for asynchronous tasks.
* **MariaDB (db01):** Relational Database for user data and application state.



---

## 🚀 Quick Start

### Prerequisites
- [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
- [Vagrant](https://www.vagrantup.com/downloads)

### Setup
1. **Clone the repository:**
   ```bash
   git clone [https://github.com/rocketonthemoon/vagrant-project.git](https://github.com/rocketonthemoon/vagrant-project.git)
   cd vagrant-project

2. **Spin up the stack:**
    ```bash
    vagrant up

3. **Connection Details:**
```markdown
 Component Details
| Service | VM Name | IP Address | Port |
| :--- | :--- | :--- | :--- |
| Load Balancer | web01 | 192.168.33.10 | 80 |
| App Server 1 | app01 | 192.168.33.11 | 8080 |
| App Server 2 | app02 | 192.168.33.12 | 8080 |
| Database | db01 | 192.168.33.14 | 3306 |
| Memcached | mc01 | 192.168.33.15 | 11211 |
| RabbitMQ | rmq01 | 192.168.33.16 | 5672 |
```
