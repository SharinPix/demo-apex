## Copy Image
##### This Apex Class contains a method **copy** whose sole purpose is to copy an image or several images from an album and paste it or them into another album.
### Usage
##### To perform the *copy* action, you need to supply three values to the parameters of the method:

- `sourceAlbumId` - corresponds to the id of the album from which the image(s) is copied.
- `destinationAlbumId` - corresponds to the id of the album on which the image(s) is pasted.
- `imageList` - corresponds to the list of image ids that needs to be copied.

```
 CopyImage.copy(sourceAlbumId, destinationAlbumId, imageList);
```
[<img src="https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/deploy.png">](https://githubsfdeploy.herokuapp.com?owner=sharinpix&repo=demo-apex&ref=copy-image)
