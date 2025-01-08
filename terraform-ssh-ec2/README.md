```
pwd  ---->>  /home/bhavna/practice/ssh

ssh-keygen -t rsa -b 2048
MENTION THE PATH WHERE YOU WANT TO GENERATE THE KEYS

chmod 400 id_rsa

ssh -i "/home/bhavna/practice/ssh/id_rsa" ubuntu@ec2-54-163-50-187.compute-1.amazonaws.com

```
