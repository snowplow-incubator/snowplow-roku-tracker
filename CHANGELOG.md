Version 0.3.2 (2025-11-03)
--------------------------
Support extracting content information from playlist items
Fix double firing events when custom UI manually changes state
Only calculate bitrate drops against same-media stream chunks

Version 0.3.1 (2025-07-31)
--------------------------

Let Network User ID be consistent within sessions
Adds support for the `application_install` event
Log errors when using `trackMediaEvent` without specifying media
Fix source of domainSessionId
Fix properties being lowercased for the quality_change and error media v2 events
Fix invalid reference to ad_break entity schema
Fix top-level `snowplow` object not dispatching `trackMediaEvent` calls to tracker instances

Version 0.3.0 (2025-05-30)
--------------------------

Add tracker prefix (roku-) in the tracker version field tracked in events (#18)
Support for setting User ID field (#17)
Session ID support (via client_session entity or domain_*id values) (#6)
Add support for the application entity
Add support for anonymous tracking
Media tracking changes:
  Support for Audio nodes
  Support for custom entities
  Fix for label configuration not matching documentation
  Allow disabling the com.roku/video entity
  Media Schemas v2 support

Adds support for media tracking v2 schema
Fix some lint configuration
General dependency/build ecosystem updates

Version 0.2.0 (2021-12-23)
--------------------------

Add video tracking (#10)
Add platform context about Roku device to events (#4)
Use millisecond granularity in event timestamps (#7)

Version 0.1.0 (2021-11-10)
--------------------------

Initial release.
