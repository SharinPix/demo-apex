global with sharing class FaceCrop {
    global String parameters { get; set; }

    global FaceCrop(ApexPages.StandardController stdCtrl) {
        Map<String, Object> params = new Map<String, Object> {
            'abilities' => new Map<String, Object> {
                (Id)stdCtrl.getId() => new Map<String, Object> {
                    'Access' => new Map<String, Object> {
                        'see' => true,
                        'image_list' => true,
                        'image_upload' => true,
                        'image_delete' => true,
                        'image_crop' => true,
                        'image_rotate' => true
                    }
                }
            }
        };
        parameters = JSON.serialize(params);
    }

    @RemoteAction
    global static void getFaceCrop(String publicId, Id albumId) {
        Integer custom_width = 180;
        Integer custom_height = 240;
        String crop_value = '0.5';
        Map<String, Object> imageParams = new Map<String, Object> { 
            'image_id' => publicId, 
            'sharinpix' => new Map<String, Boolean> {
                'download' => false
            },
            'transformations' => new List<Object> {
                new Map<String, Object> {
                    'gravity' => 'face',
                    'crop' => 'crop',
                    'zoom' => crop_value
                },
                new Map<String, Object> {
                    'crop' => 'fit', 
                    'width' => custom_width,
                    'height' => custom_height
                } 
            } 
        };
		//Url of the face-cropped image
        String resourceUrl = (String)new sharinpix.Utils().getImageExternalUrl(imageParams).get('resource_url');
    }
}