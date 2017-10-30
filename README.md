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
docker run -ti --name onedrive -v $HOME/Documents/onedrive/config:/config -v $HOME/Documents/onedrive/data:/onedrive croc/onedrive
```

Example:
```
# docker run -ti --name onedrive croc/onedrive

Authorize this app visiting:

https://login.microsoftonline.com/common/oauth2/v2.0/authorize?client_id=22c49a0d-d21c-4792-aed1-8f163c982546&scope=files.readwrite%20files.readwrite.all%20offline_access&response_type=code&redirect_uri=https://login.microsoftonline.com/common/oauth2/nativeclient

Enter the response uri: https://login.microsoftonline.com/common/oauth2/nativeclient?code=OAQABAAIAAABHh4kmS_aKT5XrjzxRAtHzoSHIBU14P6vaeNCK7-IOmw2VfKsWXV213o7VJA2M-sITUA8SkqdfCyL2-rDost5GN4manBGWA7w9NZb6htzqTIimusmRjbAP5IdmZTLmrl92ZIae9iwir8-Pj8SpHSDNK_ngpGYJvmTRRR5KZGV_OrxWF97UfgT5W82GhDjQwukIvA6r2a5vqhYuBHkn2BcaeEsa92_It6Iy0T0hkqEB75Qp2u7yVfM6cAxdktsi3N1aAZhmGhzqaVvaRfgq6bV3khhNlioAeZq54gOthE8iGH_Gldn0dmEGqAMvpCqjUvG71dLRCne1PJOwwKSoFx17tnRQOZB-ndMpkAAJOZ6G9cbx9FzK0OUew1etsAl9yQbykeGgX6pXWer-_wz1wQnwLsg9Ic8lf_0TyWPYq6IkGXiqkOVz39fzCOoyPPKdMrS8gSr8xVz_87xU8jfUhlJ7obvlzWqAaaK5lWlftVdzPlRYYify5Blwy6IjbMht6tGZuqzWn3QjB0Eap6j2Uu9XykL_YqxCyBIY6rV0bi0j1fWB0nETEQn7CAC79BQege4pMTe2n_RrV3VRHVAsnvweRoi1ll68ePfktwPnUFkPYbBEmF12QOVHE51AhNOBKbgEDHI7wbV_Gc9YDbrj_GDXHe2OCZz9YsYmKipOHGXwgSAA&session_state=6ea77fea-9447-478c-b1d4-0399ec95c623
Creating directory: ./Mindenkivel megosztva
Creating directory: ./E-mail mellékletek
...
```

I recommend, restart the container after the sync is started.

### Run

```
docker rm -v -f onedrive
docker run -tid --name onedrive -v $HOME/Documents/onedrive/config:/config -v $HOME/Documents/onedrive/data:/onedrive croc/onedrive
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
