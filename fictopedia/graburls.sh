#!bin/sh
#url=http://fictopedia.net/w/index.php?title=Special:AllPages\&from=1906_Sherman_Ranch_Monitor_Lizard_Rampage\&to=Key_Factors_Of_how_to_delete_google_plus_account_on_ipad_-_For_Adults
#url=http://fictopedia.net/w/index.php?title=Special:AllPages\&from=Key_Factors_Of_setting_up_google_authorship_-_For_Adults\&to=The_Home_Herring_Channel
url=http://fictopedia.net/w/index.php?title=Special:AllPages\&from=The_Hura\&to=Zombie_Chris
curl -s "${url}" | grep "<a href=" | grep "<td" | sed 's/.*<a href="\([^"]*\)".*/http:\/\/fictopedia.net\1/g'

