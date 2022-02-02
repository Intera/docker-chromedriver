#!/bin/bash

set -e

chromeVersion=$(google-chrome --version | cut -d " " -f 3)

# Cut off the minor version
chromeVersionMajor=${chromeVersion%.*}

# Detect matching chromedriver version
wget "https://chromedriver.storage.googleapis.com/LATEST_RELEASE_${chromeVersionMajor}" -O /opt/chromedriver_version.txt
chromedriverVersion=$(cat /opt/chromedriver_version.txt)

wget https://chromedriver.storage.googleapis.com/${chromedriverVersion}/chromedriver_linux64.zip -O /usr/local/bin/chromdriver.zip

cd /usr/local/bin && unzip /usr/local/bin/chromdriver.zip

chmod +x /usr/local/bin/chromedriver

# Cleanup
rm /usr/local/bin/chromdriver.zip
rm /opt/chromedriver_version.txt
