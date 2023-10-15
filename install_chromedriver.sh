#!/bin/bash

set -e

chromeVersion="118.0.5993.70"

echo "Version: ${chromeVersion}"

# Cut off the minor version
chromeVersionMajor=${chromeVersion%.*}

# Detect matching chromedriver version
wget "https://googlechromelabs.github.io/chrome-for-testing/LATEST_RELEASE_${chromeVersionMajor}" -O /opt/chromedriver_version.txt

chromedriverVersion=$(cat /opt/chromedriver_version.txt)

wget https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/${chromedriverVersion}/linux64/chrome-linux64.zip -O /usr/local/bin/chromdriver.zip

cd /usr/local/bin && unzip /usr/local/bin/chromdriver.zip

chmod +x /usr/local/bin/chrome-linux64/chrome

# Cleanup
rm /usr/local/bin/chromdriver.zip
rm /opt/chromedriver_version.txt
