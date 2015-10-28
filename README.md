# docker-frontend-framework
Contains supporting frameworks for frontend builds and tests

- `dockerbuild.sh`: Build the container locally.
- `protractor.sh`: Use instead of `protractor` to run Protactor via the container. `protractor.conf.js` in the current working directory will be used.

On OSX, the directory mounting sometimes fails and docker needs to be restarted to fix this.
