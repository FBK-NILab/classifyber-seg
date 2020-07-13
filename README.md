Docker to segment white matter bundles with Classifyber.

You can run Classifyber through the docker container in the following way: 

```
sudo docker run -v /absolute/path/to/my/data/directory:/data \
-t giuliaberto/classifyber:1.1 ./Classifyber-seg \
-tractogram /data/track.tck \
-t1 /data/t1.nii.gz \
-config /data/config.json
```
