# S3-Downloader
AWS S3 Downloader

---

First, install AWS CLI

https://docs.aws.amazon.com/en_us/cli/latest/userguide/installing.html

---


```
Usage: bash s3Download.sh {BUCKET NAME} --path={PATH NAME} [-rR]
Options:
  -p, --path    Path location you want to download
  -r, --region  Region of S3 (if blank, ap-southeast-1)
  -R            Recursive download

Your downloaded results on {BUCKET NAME}_files/
```
