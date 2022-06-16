FROM mcr.microsoft.com/windows/servercore/iis

# remove all files
RUN powershell -NoProfile -Command Remove-Item -Recurse C:\inetpub\wwwroot\*

# add default.html to the list of "default" documents
RUN  powershell -NoProfile -Command Add-WebConfiguration -Filter //defaultDocument/files -PSPath 'IIS:\Sites\Default Web Site' -atIndex 0 -Value @{value='default.html'}

WORKDIR /inetpub/wwwroot

COPY html/ .