# dsci310-ia3-yui-ubc-docker

```bash
docker run \
   --rm \
   -it \
   -e PASSWORD="password" \
   -p 8787:8787 \
   -v /$(pwd):/home/rstudio/pizza
   rocker/studio/4.4.2