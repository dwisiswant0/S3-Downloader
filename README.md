# S3-Downloader
AWS S3 Downloader

![AWS S3 Downloader](https://user-images.githubusercontent.com/25837540/50551335-8d3f6e80-0cb1-11e9-928b-d8396bddb2ea.png)


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
