<h1 align="center">
  <img src="snap-assets/logo.png" alt="Audacity">
  <br />
  Audacity
</h1>

<p align="center"><b>This is the snap for Audacity</b>, <i>“Audio software for multi-track recording and editing”</i>. It works on Ubuntu, Fedora, Debian, and other major Linux
distributions.</p>

<p align="center">
<a href="https://snapcraft.io/audacity"><img src="https://snapcraft.io/audacity/badge.svg" alt="Snap Status"></a>
<a href="https://github.com/snapcrafters/audacity/actions/workflows/sync-version-with-upstream.yml"><img src="https://github.com/snapcrafters/audacity/actions/workflows/sync-version-with-upstream.yml/badge.svg"></a>
<a href="https://github.com/snapcrafters/audacity/actions/workflows/release-to-candidate.yml"><img src="https://github.com/snapcrafters/audacity/actions/workflows/release-to-candidate.yml/badge.svg"></a>
<a href="https://github.com/snapcrafters/audacity/actions/workflows/promote-to-stable.yml"><img src="https://github.com/snapcrafters/audacity/actions/workflows/promote-to-stable.yml/badge.svg"></a>
</p>


## Install

    sudo snap install audacity

([Don't have snapd installed?](https://snapcraft.io/docs/core/install))

<p align="center">Published for <img src="https://raw.githubusercontent.com/anythingcodes/slack-emoji-for-techies/gh-pages/emoji/tux.png" align="top" width="24" /> with :gift_heart: by Snapcrafters</p>

## OpenVINO™ AI Plugins

This snap contains support for AI features including:

  - Music Separation
  - Noise Suppression
  - Music Generation and Continuation
  - Transcription
  - Super Resolution

The plugins come installed out-of-the-box and support running on Intel hardware only (CPU, GPU, and NPU). Instructions for using each of the features can be found in the [upstream GitHub repository](https://github.com/intel/openvino-plugins-ai-audacity/tree/main/doc/feature_doc).

For Intel NPU support (which are available in Intel Core Ultra processors), make sure to install the snap containing the supporting libraries:

```shell
sudo snap install intel-npu-driver
```

> [!IMPORTANT]
> The models (which are roughly 6.2 GiB in size total) are NOT built into the snap. To use the AI features you must download and install them from the command line. Note that downloading the models may take several minutes or longer, depending on the speed of your internet connection. Please be patient!

To ease the process of downloading and installing the models, an interactive command is available within the snap that can be invoked like so:

```shell
sudo audacity.fetch-models
```

This will provide you with an interactive menu where you can select the model you wish to download and install. Alternatively, if you wish to enable all of the AI features, you can simply pass the `--batch` flag:

```shell
sudo audacity.fetch-models --batch
```


> [!IMPORTANT]
> Please ensure you are in the `render` Unix group on your system in order to access Intel accelerators for the plugins (Intel GPU and NPU).
To check your current groups, please run the following from a terminal:

```shell
groups
```

If you do not see `render` listed in the output, you may add your current user with the following:

```shell
sudo usermod -a -G render $USER
```

Now log out and back in to ensure your active session has the `render` group included.

To ensure the device nodes have appropriate group permissions set, you may also run:

```shell
sudo chown root:render /dev/accel/accel*
sudo chmod g+rw /dev/accel/accel*
sudo chown root:render /dev/dri/render*
sudo chmod g+rw /dev/dri/render*
```

## How to contribute to this snap

Thanks for your interest! Below you find instructions to help you contribute to this snap.

The general workflow is to submit pull requests that merges your changes into the `candidate` branch here on GitHub. Once the pull request has been merged, a GitHub action will automatically build the snap and publish it to the `candidate` channel in the Snap Store. Once the snap has been tested thoroughly, we promote it to the `stable` channel so all our users get it!

### Initial setup

If this is your first time contributing to this snap, you first need to set up your own fork of this repository.

1. [Fork the repository](https://docs.github.com/en/github/getting-started-with-github/fork-a-repo) into your own GitHub namespace.
2. [Clone your fork](https://git-scm.com/book/en/v2/Git-Basics-Getting-a-Git-Repository), so that you have it on your local computer.
3. Configure your local repo. To make things a bit more intuitive, we will rename your fork's remote to `myfork`, and add the snapcrafters repo as `snapcrafters`.

    ```shell
    git remote rename origin myfork
    git remote add snapcrafters https://github.com/snapcrafters/audacity.git
    git fetch --all
    ```

### Submitting changes in a pull request

Once you're all setup for contributing, keep in mind that you want the git information to be all up-to-date. So if you haven't "fetched" all changes in a while, start with that:

```shell
git fetch --all -p
```

Now that your git metadata has been updated you are ready to create a bugfix branch, make your changes, and open a pull request.

1. All pull requests should go to the stable branch so create your branch as a copy of the stable branch:

    ```shell
    git checkout -b my-bugfix-branch snapcrafters/candidate
    ```

2. Make your desired changes and build a snap locally for testing:

    ```shell
    snapcraft --use-lxd
    ```

3. After you are happy with your changes, commit them and push them to your fork so they are available on GitHub:

    ```shell
    git commit -a
    git push -u myfork my-bugfix-branch
    ```

4. Then, [open up a pull request](https://docs.github.com/en/github/collaborating-with-issues-and-pull-requests/about-pull-requests) from your `my-bugfix-branch` to the `snapcrafters/candidate` branch.
5. Once you've opened the pull request, it will automatically trigger the build-test action that will launch a build of the snap. You can watch the progress of the snap build from your pull request (Show all checks -> Details). Once the snap build has completed, you can find the built snap (to test with) under "Artifacts".
6. Someone from the team will review the open pull request and either merge it or start a discussion with you with additional changes or clarification needed.
7. Once the pull request has been merged into the stable branch, a GitHub action will rebuild the snap using your changes and publish it to the [Snap Store](https://snapcraft.io/audacity) into the `candidate` channel. After sufficient testing of the snap from the candidate channel, one of the maintainers or administrators will promote the snap to the stable branch in the Snap Store.

## Maintainers

-   [@lucyllewy](https://github.com/lucyllewy/)

## License

-   The license of the build files in this repository is [MIT](https://github.com/snapcrafters/audacity/blob/candidate/LICENSE)
