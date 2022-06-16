# symplr-help
Docker container to host Symplr HTML help.

## Docker

### Build
Build image.

```
docker build --tag symplr-help:latest .
```

### Run
Start container (daemonized) and expose port 8080
```
docker run -dit -p 8080:80 symplr-help:latest
```

## IIS

```powershell
# get the list of default documents
Get-WebConfigurationProperty -Filter //defaultDocument/files/add -PSPath 'IIS:\Sites\Default Web Site' -Name value | select value

# add 'default.html' to the list of default documents
Add-WebConfiguration -Filter //defaultDocument/files -PSPath 'IIS:\Sites\Default Web Site' -atIndex 0 -Value @{value='default.html'}
```