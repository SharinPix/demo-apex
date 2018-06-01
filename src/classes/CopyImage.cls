public class CopyImage {

    public CopyImage() {}

    /**
     * Copy an image from an album to an another album
     * @param sourceAlbumId ID of the album of the image to be copied
     * @param destinationAlbumId ID of the album where the image needs to be pasted
     * @return void
     */
    public static void copy(String sourceAlbumId, String destinationAlbumId, List<String> imageList) {
        Blob cryptoBlob = Crypto.GenerateAESKey(128);
        String clipboardId = EncodingUtil.convertToHex(cryptoBlob); //must in uuid format
        String endpointCopy = '/clipboards';
        String endpointPaste = '/clipboards/'+clipboardId+'/paste';

        sharinpix.Client clientInstance = sharinpix.Client.getInstance();

        Map<String, Object> albumParamsCopy = new Map<String, Object> {
            'Id' => sourceAlbumId,
            'abilities' => new Map<String, Object> {
                sourceAlbumId => new Map<String, Object> {
                    'Access' => new Map<String, Boolean> {
                        'see' => true,
                        'image_list' => true,`
                        'image_copy' => true
                    }
                }
            }
        };

        Map<String, Object> albumParamsPaste = new Map<String, Object> {
            'Id' => destinationAlbumId,
            'abilities' => new Map<String, Object> {
                destinationAlbumId => new Map<String, Object> {
                    'Access' => new Map<String, Boolean> {
                        'see' => true,
                        'image_list' => true,
                        'paste' => true
                    }
                }
            }
        };

        Map<String, Object> copyParams = new Map<String, Object>{
            'id' => clipboardId,
            'image_ids' => imageList
        };
            
        Map<String, Object> copyResult = (Map<String, Object>) clientInstance.post(
            endpointCopy,
            Blob.valueOf(JSON.serialize(copyParams)),
            albumParamsCopy
        );

        Map<String, Object> pasteParams = new Map<String, Object>{
            'id' => clipboardId,
            'album_id' => destinationAlbumId
        };

        List<Object> pasteResult = (List<Object>) clientInstance.post(
            endpointPaste,
            Blob.valueOf(JSON.serialize(pasteParams)),
            albumParamsPaste
        );
    }
}