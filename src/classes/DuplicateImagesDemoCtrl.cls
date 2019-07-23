global with sharing class DuplicateImagesDemoCtrl {
    private Map<String, Object> params;
    private sharinpix.Client clientInstance = sharinpix.Client.getInstance();

    global DuplicateImagesDemoCtrl(ApexPages.StandardController stdCtrl) {
        Id accountId = stdCtrl.getId();
        List<Contact> contacts = [SELECT Id FROM Contact WHERE AccountId = :accountId];
        Map<String, Object> query = new Map<String, Object>();
        String queryStr = '';
        for (Contact contact : contacts) {
            queryStr += '"' + contact.Id + '" ';
        }

        query.put('q', queryStr);
        params = new Map<String, Object> {
            'download' => true,
            'path' => '/search?search_bar=false&q=' + clientInstance.token(query)
        };
    }

    global String getSearchUrl() {
        return clientInstance.getAppHost() + '?token=' + clientInstance.token(params);
    }

    @RemoteAction
    global static Integer duplicate(String params) {
        Map<String, Object>  parameters = (Map<String, Object>) JSON.deserializeUntyped(params);
        String destinationAlbumId = (String) parameters.get('destinationAlbumId');
        List<Object> imageObjects = (List<Object>) parameters.get('images');
        sharinpix.Utils utl = new sharinpix.Utils();
        List<String> images = new List<String>();

        for(Object imageObj : imageObjects) {
            images.add((String) imageObj );
        }

        List<Object> duplicatedImages = utl.duplicateImages(destinationAlbumId, images);
        return duplicatedImages.size();
    }
}
