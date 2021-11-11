# Roku Analytics for Snowplow

[![early-release]][tracker-classificiation]
[![Build Status][gh-actions-image]][gh-actions]
[![Coverage Status][coveralls-image]][coveralls]
[![Release][release-image]][releases]
[![License][license-image]][license]

Snowplow is a scalable open-source platform for rich, high quality, low-latency data collection. It is designed to collect high quality, complete behavioral data for enterprise business.

**To find out more, please check out the [Snowplow website][website] and our [documentation][docs].**

## Snowplow Roku Tracker Overview

The Snowplow Roku Tracker allows you to add analytics to your Roku apps when using a [Snowplow][snowplow] pipeline.

With this tracker you can collect granular event-level data as your users interact with your Roku applications.

**Technical documentation can be found for each tracker in our [Documentation][roku-docs].**

## Quick Start

### Installation Using Roku Package Manager (ropm)

```bash
ropm install snowplow@npm:@snowplow/roku-tracker
```

### Manual Installation

1. Download the `dist.zip` or `dist.tar.gz` package from the latest release build on Github.
2. Copy the following folders and files to your Roku project:
    - Contents of `dist/source` into your `source` directory
    - Contents of `dist/components` into your `components` directory

### Using the Tracker

It is recommended that you instantiate Snowplow and add it to the global scope.
In this way, it will be accessible from anywhere within your SceneGraph application.
You may create the instance in the `init` function of your main scene.

```brs
m.global.AddField("snowplow", "node", false)
m.global.snowplow = CreateObject("roSGNode", "Snowplow")
```

Trackers are initialized by setting the `init` property with configuration of the tracker.
Below is an example configuration, please refer to the documentation for a complete specification.

```brs
m.global.snowplow.init = {
    namespace: "ns1", ' optional, defaults to "default"
    network: {
        collector: "https://...",
        method: "POST",
        retryCount: 3 ' optional, defaults to 0
    },
    subject: {
        domainUserId: "",
        networkUserId: "",
        appId: ""
    }
}
```

You may initialize multiple trackers with different namespaces.
Setting the `init` property with the same tracker namespace updates the configuration of the tracker.
When no namespace is given, a namespace with the name "default" is used (both in configuration and when tracking events).

To track events, simply assign their properties as associative arrays to fields corresponding to event types.
Events will be sent to all initialized trackers (with any namespace) when setting the event types on the Snowplow instance.
To send events to a specific tracker, call its namespace as follows: `m.global.snowplow.trackerNamespace.structured = {...}`.
The following are some examples of the tracked events.
Please refer to the documentation for specificiation of event properties.

```brs
' Tracking a screen view event using all initialized trackers
m.global.snowplow.screenView = {
    id: CreateObject("roDeviceInfo").GetRandomUUID(),
    name: "HomeScene",
    type: "scene",
    transitionType: "init"
}

' Tracking a screen view event using a tracker with the namespace "ns1"
m.global.snowplow.ns1.screenView = {
    id: CreateObject("roDeviceInfo").GetRandomUUID(),
    name: "HomeScene",
    type: "scene",
    transitionType: "init"
}

' Tracking a self-describing events
m.global.snowplow.selfDescribing = {
    data: {
        id: CreateObject("roDeviceInfo").GetRandomUUID(),
        name: "name",
        type: "type"
    },
    schema: "iglu:com.snowplowanalytics.mobile/screen_view/jsonschema/1-0-0"
}

' Tracking a structured event
m.global.snowplow.structured = {
    namespace: "otherNamespace",
    se_ca: "category",
    se_ac: "action",
    se_la: "label",
    se_pr: "property",
    se_va: 10
}

' Adding context to an event
m.global.snowplow.structured = {
    ...
    contexts: [
        {
            data: {
                id: CreateObject("roDeviceInfo").GetRandomUUID(),
                name: "contextName",
                type: "type"
            },
            schema: "iglu:com.snowplowanalytics.mobile/screen_view/jsonschema/1-0-0"
        }
    ]
}
```

## Find Out More

| Technical Docs                    | Setup Guide                 |
|-----------------------------------|-----------------------------|
| [![i1][techdocs-image]][techdocs] | [![i2][setup-image]][setup] |
| [Technical Docs][techdocs]        | [Setup Guide][setup]        |

## Maintainers

| Contributing                                 |
|----------------------------------------------|
| [![i4][contributing-image]](CONTRIBUTING.md) |
| [Contributing](CONTRIBUTING.md)              |

### Maintainer Quick Start

Assuming git, Node.js 12 LTS or 16 LTS are installed.

The tracker is implemented using [BrighterScript](https://github.com/rokucommunity/brighterscript).

#### Clone Repository

```bash
git clone https://github.com/snowplow-incubator/snowplow-roku-tracker.git
```

## Building

To build the package in order to include it in other Roku projects:

1. Run `npm install` on the project
2. Install ropm `npm i ropm -g`
3. Install ropm packages `ropm install`
4. Run `npm run build`
5. The package source files will be placed in the `dist` folder and may be copied for use in another Roku project

## Demo App

The tracker comes with a demo app that shows it in use.
It is a simple video player with a fixed collection of played videos and an interface to switch between them.

The project is located in the `src-demo-app` subfolder.
The following steps assume that you have enabled developer mode on your Roku device and it is connected to your network.

1. Run `npm install` on the project
2. Install ropm `npm i ropm -g`
3. Install ropm packages `ropm install`
4. Create `.env` file with environment variables in the root of this repository

    ```bash
    ROKU_IP=192.168.100.129
    ROKU_PASSWORD=XXXX
    ```

5. Add configuration for Snowplow collector to `src-demo-app/manifest`

    ```bash
    snowplow_collector=http://192.168.100.127:9090
    snowplow_method=POST
    ```

6. Start the demo app using `npm run demo-app`

Alternatively, you may run the demo app from Visual Studio Code as the debug configuration is already prepared.
Install the BrightScript extension to Visual Studio Code and choose "Run demo app" in the debug options.

Events will be sent to the Snowplow collector as you navigate through the app.

## Testing

The tracker functionality is verified using unit and integration tests.
Unit tests test individual components of the tracker in isolation and do not make any external network requests.
Integration tests use a Snowplow Micro instance to verify end-to-end tracking of events.

The tests are located in the `tests` subfolder.
The following steps assume that you have enabled developer mode on your Roku device and it is connected to your network.

1. Run `npm install` on the project
2. Install ropm `npm i ropm -g`
3. Install ropm packages `ropm install`
4. Create `.env` file with environment variables in the root of this repository

    ```bash
    ROKU_IP=192.168.100.129
    ROKU_PASSWORD=XXXX
    ```

5. Start [Snowplow Micro](https://github.com/snowplow-incubator/snowplow-micro) on your computer
6. Add configuration for your Snowplow Micro (with the network IP of your computer) instance to `tests/manifest`

    ```bash
    snowplow_collector=http://192.168.100.127:9090
    snowplow_method=POST
    ```

7. Run the tests using `npm test`

Alternatively, you may run the tests from Visual Studio Code as the debug configuration is already prepared.
Install the BrightScript extension to Visual Studio Code and choose "Run tests" in the debug options.

## Copyright and License

The Snowplow Roku Tracker is copyright 2021 Snowplow Analytics Ltd.

Licensed under the **[Apache License, Version 2.0][license]** (the "License");
you may not use this software except in compliance with the License.

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

[website]: https://snowplowanalytics.com
[snowplow]: https://github.com/snowplow/snowplow
[docs]: https://docs.snowplowanalytics.com/
[roku-docs]: TODO

[gh-actions]: https://github.com/snowplow-incubator/snowplow-roku-tracker/actions/workflows/build.yml
[gh-actions-image]: https://github.com/snowplow-incubator/snowplow-roku-tracker/actions/workflows/build.yml/badge.svg

[coveralls]: https://coveralls.io/github/snowplow-incubator/snowplow-roku-tracker?branch=master
[coveralls-image]: https://coveralls.io/repos/github/snowplow-incubator/snowplow-roku-tracker/badge.svg?branch=master

[license]: https://www.apache.org/licenses/LICENSE-2.0
[license-image]: https://img.shields.io/github/license/snowplow-incubator/snowplow-roku-tracker

[release-image]: https://img.shields.io/github/v/release/snowplow-incubator/snowplow-roku-tracker?sort=semver
[releases]: https://github.com/snowplow-incubator/snowplow-roku-tracker/releases

[setup-docs]: TODO
[setup-docs-image]: https://d3i6fms1cm1j0i.cloudfront.net/github/images/setup.png

[techdocs]: TODO
[techdocs-image]: https://d3i6fms1cm1j0i.cloudfront.net/github/images/techdocs.png
[setup]: TODO
[setup-image]: https://d3i6fms1cm1j0i.cloudfront.net/github/images/setup.png

[api-docs]: https://snowplow.github.io/snowplow-roku-tracker/

[contributing-image]: https://d3i6fms1cm1j0i.cloudfront.net/github/images/contributing.png

[tracker-classificiation]: https://github.com/snowplow/snowplow/wiki/Tracker-Maintenance-Classification
[early-release]: https://img.shields.io/static/v1?style=flat&label=Snowplow&message=Early%20Release&color=014477&labelColor=9ba0aa&logo=data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAMAAAAoLQ9TAAAAeFBMVEVMaXGXANeYANeXANZbAJmXANeUANSQAM+XANeMAMpaAJhZAJeZANiXANaXANaOAM2WANVnAKWXANZ9ALtmAKVaAJmXANZaAJlXAJZdAJxaAJlZAJdbAJlbAJmQAM+UANKZANhhAJ+EAL+BAL9oAKZnAKVjAKF1ALNBd8J1AAAAKHRSTlMAa1hWXyteBTQJIEwRgUh2JjJon21wcBgNfmc+JlOBQjwezWF2l5dXzkW3/wAAAHpJREFUeNokhQOCA1EAxTL85hi7dXv/E5YPCYBq5DeN4pcqV1XbtW/xTVMIMAZE0cBHEaZhBmIQwCFofeprPUHqjmD/+7peztd62dWQRkvrQayXkn01f/gWp2CrxfjY7rcZ5V7DEMDQgmEozFpZqLUYDsNwOqbnMLwPAJEwCopZxKttAAAAAElFTkSuQmCC
