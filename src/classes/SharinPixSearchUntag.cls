global class SharinPixSearchUntag {
    private Map<String, Object> params;
    private sharinpix.Client clientInstance = sharinpix.Client.getInstance();

    public SharinPixSearchUntag() {
        Map<String, Object> query = new Map<String, Object>();
		Id albumId = '0011t00000Qh4o3AAB';
        query.put('q', albumId);
        params = new Map<String, Object> {
            'path' => '/search?v=2&q=' + clientInstance.token(query),
			'thumbnail_tags' => true,
			'download' => true
        };
    }


	@RemoteAction
	global static void untagImages(String images) {
		sharinpix.Utils utl = new sharinpix.Utils();
		List<Object> imageObjects = (List<Object>) JSON.deserializeUntyped(images);
		for(Object image : imageObjects) {
			Map<String, Object> imageObject = (Map<String, Object>) image;
			String publicId = (String) imageObject.get('public_id');
			utl.clearTags(publicId);
		}
	}

    public String getParameters() {
        return JSON.serialize(params);
    }
}