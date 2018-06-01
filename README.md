# Crop Face Image with Tag

## Overview

The present demo will show it is possible to crop the face part of a given image whenever a specific tag is applied to it.

### Visualforce Page

In this scenario, the standardController of the Visualforce Page is Account. The Visualforce Page is used to: 
- Display the SharinPix Album
- Crop the face found on an image when the tag named profile-picture is applied to it.
- To perform the cropping action only when a particular tag is applied, replace profile-picture with the tag name relevant to your case in the code below.  

### Apex Class

The Apex Class is used to:
- Supply the parameters for the SharinPix Album to be displayed on the Visualforce Page
- Perform the crop face action.

`Note:` 
- The **custom_width** variable refers to the width of the cropped image.
- The **custom_height** variable refers to the height of the cropped image.
- The **crop_value**  variable refers to the zoom value of the cropped image.
- The **resourceUrl** refers to the url of the image where the face has been cropped.

[<img src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/deploy.png">](https://githubsfdeploy.herokuapp.com?owner=sharinpix&repo=demo-apex&ref=face-crop-demo)