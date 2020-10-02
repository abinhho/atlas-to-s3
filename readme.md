# Heatmap Local enviroment
```
docker build . -t abinhho/atlas-to-s3 -f Dockerfile.atlas_to_s3 --force-rm
docker push abinhho/atlas-to-s3
```

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
  atlas-to-s3
```
