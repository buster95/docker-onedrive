# OneDrive client with Docker

This container runs skilion's OneDrive client. This client works with Personal and Business Onedrive (Sharepoint) too.

  - https://github.com/skilion/onedrive


## Build

```
docker build -t croc/onedrive .
```

## Run


### Base Config

If you start first, You should configure first.
Run without `-d`, because You have to answer to a form in the container.

```
docker run -ti --rm --name onedrive -v $PWD/config:/config croc/onedrive
```

Open the URL (Authorize this app visiting), do the necessary steps (login on the opened site, etc...) and paste the long URL after the login.
Maybe You see a blank white page, but a long URL in the browser's address bar. Copy this long URL and paste to response URI (Enter the response uri).

That's it. :)

Example:
```
# docker run -ti --rm --name onedrive -v $PWD/config:/config croc/onedrive

Authorize this app visiting:

https://login.microsoftonline.com/common/oauth2/v2.0/authorize?client_id=22c49a0d-d21c-4792-aed1-8f163c982546&scope=files.readwrite%20files.readwrite.all%20offline_access&response_type=code&redirect_uri=https://login.microsoftonline.com/common/oauth2/nativeclient

Enter the response uri: https://login.microsoftonline.com/common/oauth2/nativeclient?code=M9d34df5b-d304-9606-9f06-38fd6afb76e0 
Creating directory: ./Mindenkivel megosztva
Creating directory: ./E-mail mellékletek
...
```

If the sync is started, stop the container with CTRL-C (or with `docker rm -v -f onedrive`), and recreate the container again with some extra parameters or with docker-compose file with same config directory.

### Run

```
docker rm -v -f onedrive
docker run -tid --name onedrive --restart always -v $PWD/config:/config -v $PWD/data:/onedrive croc/onedrive
```


If you need, change the permission of the folders to the user:

```
usr="<youruser>"; chown -R $usr /home/$usr/Documents/onedrive
```

#### Optional parameters

  - `GROUP_ID` - the default owner's groupID of the syncronized files (default: 1000)
  - `USER_ID` - the default owner's userID of the syncronized files (default: 1000)
  - `SYNC_LIST` - you can choose some folders for sync, other folders on your onedrive will be ignored for sync (example: Sync1,My Stuff,Work)

Example:
```
docker run -tid --name onedrive --restart always -v $HOME/Documents/onedrive/config:/config -v $HOME/Documents/onedrive/data:/onedrive -e GROUP_ID=1005 -e USER_ID=1005 -e SYNC_LIST="work,my stuff,Sync1" croc/onedrive
```

## Configuration

The OneDrive container/clients sync all files basically.

You can skip files/drives and You can select only some files/folders for sync. You should use some configuration files for this.

### Selective sync

Create a `sync_list` file under the `config` folder that contains the files and folder names.
Example:
`config/sync_list`:
```
Backup
Documents/latest_report.docx
Work/ProjectX
notes.txt
```

### Skip list

You can ignore some folders from the sync with a `skip_file`.

List the files in `config/skip_file`:
```
MyOldStuff
Photos
Movies
Verylarge_stuff
```
