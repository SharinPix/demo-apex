@isTest
private class DuplicateImagesDemoCtrlTest {
	private static ApexPages.StandardController stdCtrl;
	private static Contact contact1, contact2;
	private static sharinpix.Client clientInstance;

	@isTest
	static void itShouldCheckParams() {
		Account acc = new Account(Name='Acme Ltd');
		insert acc;

		contact1 = new Contact(LastName='Bond', AccountId = acc.Id);
		insert contact1;

		contact2 = new Contact(LastName='Sarge', AccountId = acc.Id);

		insert contact2;
		stdCtrl = new ApexPages.StandardController(acc);

		clientInstance = sharinpix.Client.getInstance();
		DuplicateImagesDemoCtrl controller = new DuplicateImagesDemoCtrl(stdCtrl);
		String queryString = '"' + contact1.Id + '" ' + '"' + contact2.Id + '" ';
		Map<String, Object> query = new Map<String, Object> {
			'q' => queryString
		};

		Map<String, Object> expectedParams = new Map<String, Object> {
            'download' => true,
			'path' => '/search?search_bar=false&q=' + clientInstance.token(query)
		};

		String expectedSearchUrl = clientInstance.getAppHost() + '?token=' + clientInstance.token(expectedParams);
		System.assertEquals(expectedSearchUrl, controller.getSearchUrl());
	}

    @isTest
    static void itShouldDuplicateImages() {
        String params = '{ "destinationAlbumId": "albumId", "images": ["1", "2"] }';
        String expectedResponse = '[{"public_id": "1"}, {"public_id":  "2"}]';

        Map<String, HttpCalloutMock> requestResponses = new Map<String, HttpCalloutMock> {
            'https://api.sharinpix.com/api/v1/images/duplicate_bulk' => new SingleRequestMock(200, 'OK', expectedResponse, null)
        };
        Test.setMock(HttpCalloutMock.class, new MultiRequestMock(requestResponses));

        Test.startTest();
        Integer actualImageCount = DuplicateImagesDemoCtrl.duplicate(params);
        Test.stopTest();

        System.assertEquals(2, actualImageCount);
    }
}