public with sharing class CustomFooterCtrl {
	public String parameters { get; set; }

    public CustomFooterCtrl (ApexPages.StandardController stdCtrl) {
        Id albumId = stdCtrl.getId();
        Map<String, Object> params = new Map<String, Object> {
            'abilities' => new Map<String, Object> {
                albumId => new Map<String, Object> {
                    'Access' => new Map<String, Object> {
                        'see' => true,
                        'image_list' => true,
                        'image_upload' => true
                    }
                }
            }
        };
        parameters = JSON.serialize(params);
    }
}