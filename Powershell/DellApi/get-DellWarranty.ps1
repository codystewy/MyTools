$ApiKey="l7900669d188724e22a64dbcfb803c672f";
$ApiSecret="69a0c36238ca4b9d8b51c8ca4a7bb84f";

$SerialNumber = "69HBXF2,GVD7DH2"

$AuthURI = "https://apigtwb2c.us.dell.com/auth/oauth/v2/token"
$OAuth = "$ApiKey`:$ApiSecret";
$Bytes = [System.Text.Encoding]::ASCII.GetBytes($OAuth);
$EncodedOAuth = [Convert]::ToBase64String($Bytes);
$TokenHeaders = @{};
$TokenHeaders.Add("authorization", "Basic $EncodedOAuth");
$Authbody = 'grant_type=client_credentials';
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;
$AuthResult = Invoke-RESTMethod -Method Post -Uri $AuthURI -Body $AuthBody -Headers $TokenHeaders;
$Token = $AuthResult.access_token;
$ApiHeaders = @{"Accept" = "application/json" };
$ApiHeaders.Add("Authorization", "Bearer $Token");
$Params = @{};
$Params = @{servicetags = $SerialNumber; Method = "GET" };
$res = Invoke-RestMethod -Uri "https://apigtwb2c.us.dell.com/PROD/sbil/eapi/v5/asset-entitlements" -Headers $ApiHeaders -Body $Params -Method Get -ContentType "application/json" -ea 0
$res | Export-Csv -NoClobber -Path c:\ittemp\apiresponse.csv