xpack.security.authc.realms:
    native:
      local:
        order: 0
    saml:
      azure_ad:
        order: 1
        attributes.principal: "https://schemas.xmlsoap.org/ws/2005/05/identity/claims/name"
        attributes.groups: "https://schemas.microsoft.com/ws/2008/06/identity/claims/role"
        attributes.name: "https://schemas.microsoft.com/identity/claims/displayname"
        attributes.mail: "https://schemas.xmlsoap.org/ws/2005/05/identity/claims/emailaddress"
        idp.metadata.path: "${federation_metadata_url}"
        idp.entity_id: "${azuread_id}"
        sp.entity_id: "${kibana_endpoint}"
        sp.acs: "${kibana_endpoint}/api/security/saml/callback"
        sp.logout: "${kibana_endpoint}/logout"


