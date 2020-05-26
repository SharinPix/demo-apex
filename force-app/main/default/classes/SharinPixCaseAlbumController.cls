public class SharinPixCaseAlbumController {
	@AuraEnabled
    public static List<Case> getCaseRecords() {
		return [SELECT Id, CaseNumber FROM Case];           
    }
    
    @AuraEnabled
    public static String getAlbumParams(String albumId) {
         Map<String, Object> albumParams = new Map<String, Object> {
            'abilities' =>  new Map<String, Object> {
                albumId => new Map<String, Object> {
                    'Access' =>  new Map<String, Object> {
                        'see' => true,
                        'fullscreen' => true,
                        'image_list' => true,
                        'image_upload' => true,
                        'image_delete' => true,
                        'image_copy' => true,
                       	'fullscreen' => true,
                        'image_tag' => true
                    },
					'Display' => new Map<String, Object> {
                    	'tags' => true		        
                    }
                },
                    'tags'=> new Map<String, Object> {
                        'create' => true,
    					'read'=> true,
    					'filter_any_of'=> true
  					}
            },
			'download' => true,
            'Id' => albumId,
            'path' => '/pagelayout/' + albumId
        };

        sharinpix.Client clientInstance = sharinpix.Client.getInstance();
        return clientInstance.getAppHost() + '?token=' + clientInstance.token(albumParams);
    }
}