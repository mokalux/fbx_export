# fbx_export

To see the bug:
- either export Gideros project for "Windows Desktop" or for "Win32"
- then when you run the app from a path with no space in it, "fbx to json" button works as expected
- but if you move the app to a path which has spaces in it, "fbx to json" button will throw an error:
        - The system cannot find the file C:\Users\xxx\Downloads\New.

Somehow Qt replaces space with a dot!

Thank you.