# 1. How to use
Leave `DB_NAME` is empty to backup all databases

### 1.1 Run without schedule
```
docker run \
  -v atlas_to_s3_tmp:/backup \
  -e 'DB_NAME=mydb' \
  -e 'CLUSTER=cluster0.ad2cx' \
  -e 'ATLAS_USER=myuser' \
  -e 'ATLAS_PASSWORD=mypassword' \
  -e 'BUCKET=my-bucket' \
  -e 'AWS_ACCESS_KEY_ID=xxx' \
  -e 'AWS_SECRET_ACCESS_KEY=xxx' \
  abinhho/atlas-to-s3
```

### 1.2 Run with cron schedule

```
docker run \
  -v atlas_to_s3_tmp:/backup \
  -e 'DB_NAME=mydb' \
  -e 'CLUSTER=cluster0.ad2cx' \
  -e 'ATLAS_USER=myuser' \
  -e 'ATLAS_PASSWORD=mypassword' \
  -e 'BUCKET=my-bucket' \
  -e 'AWS_ACCESS_KEY_ID=xxx' \
  -e 'AWS_SECRET_ACCESS_KEY=xxx' \
  -e 'CRON_SCHEDULE=0 1 * * *' \
  abinhho/atlas-to-s3
```

# 2. Dev noted

```
docker build . -t abinhho/atlas-to-s3 -f Dockerfile.atlas_to_s3 --force-rm
docker push abinhho/atlas-to-s3
```

# 3. Github

https://github.com/abinhho/atlas-to-s3