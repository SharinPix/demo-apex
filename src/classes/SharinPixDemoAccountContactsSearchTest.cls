@isTest
private class SharinPixDemoAccountContactsSearchTest
{
	private static ApexPages.StandardController stdCtrl;
	private static Contact contact1, contact2;
	private static sharinpix.Client clientInstance;

	@isTest
	static void itShouldCheckParams()
	{
		Account acc = new Account(Name='Acme Ltd');
		insert acc;

		contact1 = new Contact(LastName='Bond', AccountId = acc.Id);
		insert contact1;

		contact2 = new Contact(LastName='Sarge', AccountId = acc.Id);

		insert contact2;
		stdCtrl = new ApexPages.StandardController(acc);

		clientInstance = sharinpix.Client.getInstance();
		SharinPixDemoAccountContactsSearchCtrl controller = new SharinPixDemoAccountContactsSearchCtrl(stdCtrl);
		String queryString = '"' + contact1.Id + '" ' + '"' + contact2.Id + '" ';
        
		Map<String, Object> expectedParams = new Map<String, Object> {
			'path' => '/search?search_bar=false',
            'q' => queryString,
			'download' => true,
            'download_filename' => 'my_zip_filename',
            'download_filenames' => 'inside_the_zip-00001'
		};

		String expectedParameters = JSON.serialize(expectedParams);
		String expectedSearchUrl = clientInstance.token(expectedParams);
		System.assertEquals(expectedParameters, controller.getParameters());
		System.assertEquals(expectedSearchUrl, controller.getSearchUrl());
	}
}