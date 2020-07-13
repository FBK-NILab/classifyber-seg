Docker to segment white matter bundles with Classifyber.

You can run Classifyber through the docker container in the following way: 

```
sudo docker run -v /absolute/path/to/my/data/directory:/data \
-t giuliaberto/classifyber:1.1 ./Classifyber-seg \
-tractogram /data/track.tck \
-t1 /data/t1.nii.gz \
-config /data/config.json
```

provided that ```track.tck``` is the whole brain tractogram from which you want to segment the bundles, that ```t1.nii.gz``` is the T1 structral image (in the same anatomical space of the tractogram), and that ```config.json``` contains the IDs of the bundles to be segmented (for a template refer to the config_template.json file and for the ID mapping refer to this repo https://github.com/FBK-NILab/app-classifyber-segmentation).  

### Reference
["Classifyber, a robust streamline-based linear classifier for white matter bundle segmentation"](https://www.biorxiv.org/content/10.1101/2020.02.10.942714v1), Bertò, G., Bullock, D., Astolfi, P., Hayashi, S., Zigiotto, L., Annicchiarico, L., Corsini, F., De Benedictis, A., Sarubbo, S., Pestilli, F., Avesani, P., Olivetti, E.
