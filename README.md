<h1 align="center">
  <img src="snap-assets/logo.png" alt="Audacity">
  <br />
  Audacity
</h1>

<p align="center"><b>This is the snap for Audacity</b>, <i>“Audio software for multi-track recording and editing”</i>. It works on Ubuntu, Fedora, Debian, and other major Linux
distributions.</p>

[![Snap Status](https://build.snapcraft.io/badge/diddlesnaps/audacity.svg)](https://build.snapcraft.io/user/diddlesnaps/audacity)

<!-- Uncomment and modify this when you have a screenshot
![my-snap-name](screenshot.png?raw=true "my-snap-name")
-->

<p align="center">Published for <img src="https://raw.githubusercontent.com/anythingcodes/slack-emoji-for-techies/gh-pages/emoji/tux.png" align="top" width="24" /> with 💝 by Snapcrafters</p>

## Install

    sudo snap install audacity

([Don't have snapd installed?](https://snapcraft.io/docs/core/install))

## OpenVINO™ AI Plugins

This branch contains support for AI features including:

  - Music Separation
  - Noise Suppression
  - Music Generation and Continuation
  - Whisper Transcription
  - Super Resolution

The plugins and models come installed out-of-the-box and support running on Intel hardware (CPU, GPU, and NPU). Instructions for using each of the features can be found in the [upstream GitHub repository](https://github.com/intel/openvino-plugins-ai-audacity/tree/main/doc/feature_doc).

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

> [!IMPORTANT]
> Since the models (which are roughly 6.2 GiB in size total) are built into the snap, downloading and installing the snap may take several minutes or longer, depending on the speed of your internet connection. Please be patient!

## Remaining tasks
<!-- Uncomment and modify this when you have a screenshot
![my-snap-name](screenshot.png?raw=true "my-snap-name")
-->

Snapcrafters ([join us](https://forum.snapcraft.io/t/join-snapcrafters/1325)) 
are working to land snap install documentation and
the [snapcraft.yaml](https://github.com/snapcrafters/fork-and-rename-me/blob/master/snap/snapcraft.yaml)
upstream so Audacity can authoritatively publish future releases.

  - [x] Fork the [Snapcrafters template](https://github.com/snapcrafters/fork-and-rename-me) repository to your own GitHub account.
    - If you have already forked the Snapcrafter template to your account and want to create another snap, you'll need to use GitHub's [Import repository](https://github.com/new/import) feature because you can only fork a repository once.
  - [x] Rename the forked Snapcrafters template repository
  - [x] Update the description of the repository
  - [x] Update logos and references to `[Project]` and `[my-snap-name]`
  - [x] Create a snap that runs in `devmode`
  - [x] Register the snap in the store, **using the preferred upstream name**
  - [ ] Add a screenshot to this `README.md`
  - [x] Publish the `devmode` snap in the Snap store edge channel
  - [x] Add install instructions to this `README.md`
  - [x] Update snap store metadata, icons and screenshots
  - [x] Convert the snap to `strict` confinement, or `classic` confinement if it qualifies
  - [x] Publish the confined snap in the Snap store beta channel
  - [x] Update the install instructions in this `README.md`
  - [x] Post a call for testing on the [Snapcraft Forum](https://forum.snapcraft.io) - [link]()
  - [x] Make a post in the [Snapcraft Forum](https://forum.snapcraft.io) asking for a transfer of the snap name from you to snapcrafters - [link]()
  - [ ] Ask a [Snapcrafters admin](https://github.com/orgs/snapcrafters/people?query=%20role%3Aowner) to fork your repo into github.com/snapcrafters, and configure the repo for automatic publishing into edge on commit
  - [ ] Add the provided Snapcraft build badge to this `README.md`
  - [x] Publish the snap in the Snap store stable channel
  - [x] Update the install instructions in this `README.md`
  - [x] Post an announcement in the [Snapcraft Forum](https://forum.snapcraft.io) - [link]()
  - [ ] Submit a pull request or patch upstream that adds snap install documentation - [link]()
  - [ ] Submit a pull request or patch upstream that adds the `snapcraft.yaml` and any required assets/launchers - [link]()
  - [ ] Add upstream contact information to the `README.md`  
  - If upstream accept the PR:
    - [ ] Request upstream create a Snap store account
    - [ ] Contact the Snap Advocacy team to request the snap be transferred to upstream
  - [ ] Ask the Snap Advocacy team to celebrate the snap - [link]()

If you have any questions, [post in the Snapcraft forum](https://forum.snapcraft.io).


## The Snapcrafters

| [![Daniel Llewellyn](http://gravatar.com/avatar/c77d9922c44ee0a34b8cabc4029b5082/?s=128)](https://github.com/diddledan/) |
| :---: |
| [Daniel Llewellyn](https://github.com/diddledan/) |

<!-- Uncomment and modify this when you have upstream contacts
## Upstream

| [![Upstream Name](https://gravatar.com/avatar/bc0bced65e963eb5c3a16cab8b004431?s=128)](https://github.com/upstreamname) |
| :---: |
| [Upstream Name](https://github.com/upstreamname) |
-->
