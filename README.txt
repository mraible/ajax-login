To build this project, you'll likely need AppFuse's snapshot repository settings in your settings.xml. The easiest
way to do this is likely to copy the contents of the following file into your ~/.m2/settings.xml.

https://gist.github.com/raw/841724/a8336606b9eb30c1d98b1492e033448aad37752b/appfuse-settings.xml

After doing this, you should be able to run the project using:

mvn jetty:run

You will need to configure Apache to proxy requests to Jetty using mod_proxy to get rid of ports in your URLs. Once
you've done this, you should be able to access the project at http://localhost.

1. Click on the Users tab to see the self-signed certificate warning and accept it in your browser.
2. Go back to http://localhost and click on the "View Demonstration" button.
3. Login using admin/admin.

For more information about this project, see the following blog post:

http://raibledesigns.com/rd/entry/implementing_ajax_authentication_using_jquery