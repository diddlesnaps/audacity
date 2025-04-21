The files under this directory are not meant to be under source control. To populate the OpenVINO models for inclusion into the snap, please run the `fetch-models.sh` script from the root directory of this repo. For example:

```shell
sudo apt install -y git git-lfs wget unzip # install script dependencies
./fetch-models.sh --batch
```

The above will install all the models from Hugging Face into the `models` directory, with the required directory tree layout to function with the plugins inside the snap.

You may also run the script interactively to install the models one at a time:

```shell
./fetch-models.sh
```
