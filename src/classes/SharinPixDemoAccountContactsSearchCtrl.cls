public class SharinPixDemoAccountContactsSearchCtrl {
    private Map<String, Object> params;
    private sharinpix.Client clientInstance = sharinpix.Client.getInstance();

    public SharinPixDemoAccountContactsSearchCtrl(ApexPages.StandardController stdCtrl) {
        Id accountId = stdCtrl.getId();
        List<Contact> contacts = [SELECT Id FROM Contact WHERE AccountId = :accountId];
        Map<String, Object> query = new Map<String, Object>();
        String queryStr = '';
        for (Contact contact : contacts) {
            queryStr += '"' + contact.Id + '" ';
        }

        query.put('q', queryStr);
        params = new Map<String, Object> {
            'path' => '/search?search_bar=false&q=' + clientInstance.token(query),
            'download' => true,
            'download_filename' => 'my_zip_filename',
            'download_filenames' => 'inside_the_zip-00001'
        };
    }

    public String getParameters() {
        return JSON.serialize(params);
    }

    public String getSearchUrl() {
        return clientInstance.getAppHost() + '?token=' + clientInstance.token(params);
    }
}