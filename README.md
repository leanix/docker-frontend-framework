# docker-frontend-framework
Contains supporting frameworks for frontend builds and tests

- `dockerbuild.sh`: Build the container locally.
- `protractor.sh`: Use instead of `protractor` to run Protactor via the container. `protractor.conf.js` in the current working directory will be used.

If `b2d-sync` is used for another container simultaneously, this currently breaks the setup above on Mac OSX. Because it relies on the '/Users' directory being mounted into the boot2docker VM, but `b2d-sync` unmounts that directory on every run.
