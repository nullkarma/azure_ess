xpack.security.authc.realms.saml.azure_ad:
    order: 2
    attributes.principal: nameid
    attributes.groups: "https://schemas.microsoft.com/ws/2008/06/identity/claims/role"
    idp.metadata.path: "https://login.microsoftonline.com/${azure_tenant_id}/federationmetadata/2007-06/federationmetadata.xml?appid=${azuread_application_id}"
    idp.entity_id: "https://sts.windows.net/${azure_tenant_id}/"
    sp.entity_id: "${kibana_endpoint}"
    sp.acs: "${kibana_endpoint}/api/security/saml/callback"
    sp.logout: "${kibana_endpoint}/logout"
